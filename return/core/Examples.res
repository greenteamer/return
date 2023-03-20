module Model = {
  type pickupTime = Js.Date.t
  type pickupAddress = string
  type dropoffAddress = string
  type dateConfirmed = Js.Date.t

  type maybePickupTime = option<pickupTime>
  type maybePickupAddress = option<pickupAddress>
  type maybeDropoffAddress = option<dropoffAddress>
  type maybeDateConfirmed = option<dateConfirmed>

  type context = {
    pickupTime: maybePickupTime,
    pickupAddress: maybePickupAddress,
    dropoffAddress: maybeDropoffAddress,
    dateConfirmed: maybeDateConfirmed,
  }

  type readyDataStep1 = DataStep1({context: context, pickupTime: pickupTime})
  type readyDataStep2 =
    DataStep2({context: context, pickupTime: pickupTime, pickupAddress: pickupAddress})
  type readyDataStep3 =
    | DataStep3({
        context: context,
        pickupTime: pickupTime,
        pickupAddress: pickupAddress,
        dropoffAddress: dropoffAddress,
      })

  type readyDataReviewStep =
    | DataReviewStep({
        pickupTime: pickupTime,
        pickupAddress: pickupAddress,
        dropoffAddress: dropoffAddress,
        dateConfirmed: dateConfirmed,
      })
}

module FSM = {
  type step1 = Model.readyDataStep1
  type step2 = Model.readyDataStep2
  type step3 = Model.readyDataStep3
  type reviewStep = Model.readyDataReviewStep

  type rec state<'a> =
    | Step1(step1): state<step1>
    | Step2(step2): state<step2>
    | Step3(step3): state<step3>
    | ReviewStep(reviewStep): state<reviewStep>

  // type rec state =
  //   | Step1(Model.readyDataStep1)
  //   | Step2(Model.readyDataStep2)
  //   | Step3(Model.readyDataStep3)
  //   | ReviewStep(Model.readyDataReviewStep)

  type rec action<'a> =
    | Next(Model.context): action<state<'a>>
    | Prev: action<state<step2>>
    | Confirm
    | UpdateContext

  // let step1reducer = (state, action) =>
  //   switch (state, action) {
  //   | (state, Next(ctx)) => "hello"
  //   // | (Step2(data), _) => "hello"
  //   // | (Step3(data), _) => "hello"
  //   // | (Step3(data), _) => "hello"
  //   // | (ReviewStep(data), _) => "hello"
  //   }
}

