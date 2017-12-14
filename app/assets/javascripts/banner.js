/*
 * TheaterJS, a typing effect mimicking human behavior.
 *
 * Github repository:
 * https://github.com/Zhouzi/TheaterJS
 *
 */

var theater = theaterJS()

theater
  .on('type:start, erase:start', function () {
    theater.getCurrentActor().$element.classList.add('actor__content--typing')
  })
  .on('type:end, erase:end', function () {
    theater.getCurrentActor().$element.classList.remove('actor__content--typing')
  })
  .on('type:start, erase:start', function () {
    if (theater.getCurrentActor().name === 'vader') {
      document.body.classList.add('dark')
    } else {
      document.body.classList.remove('dark')
    }
  })

theater
  .addActor('luke')
  .addScene('luke: BROWSE IT', 400)
  .addScene('luke:SAVE IT',400)
  .addScene('luke:TRACK IT', 600)
  .addScene('luke:BUY IT', 400)
  .addScene(theater.replay.bind(theater))
