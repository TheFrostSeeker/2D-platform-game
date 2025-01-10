class_name FiniteStateMachine extends Node2D

@onready var Pause: PlayerPause = $Pause
@onready var idle: PlayerIdle = $Idle
@onready var run: PlayerRun = $Run
@onready var jump: PlayerJump = $Jump
@onready var jump_peak: PlayerJumpPeak = $JumpPeak
@onready var fall: PlayerFall = $Fall
@onready var dash: PlayerDash = $Dash
@onready var dash_cooldown: Timer = $Dash/DashCooldown
@onready var attack_1: PlayerAttack = $Attack_1
@onready var attack_2: PlayerAttack = $Attack_2
@onready var attack_3: PlayerAttack = $Attack_3
