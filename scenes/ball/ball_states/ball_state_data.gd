class_name BallStateData

var lock_duration : int

static func build() -> BallStateData:
	return BallStateData.new()

func set_lock_duration(duration: int) -> BallStateData:
	lock_duration = duration
	return self
