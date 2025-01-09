class_name FiniteStateMachine extends Node2D

@onready var Pause: PlayerPause = $Pause
@onready var idle: PlayerIdle = $Idle
@onready var run: PlayerRun = $Run
@onready var jump: PlayerJump = $Jump
@onready var jump_peak: PlayerJumpPeak = $JumpPeak
@onready var fall: PlayerFall = $Fall
@onready var dash: PlayerDash = $Dash
@onready var attack: PlayerAttack = $Attack
