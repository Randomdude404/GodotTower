
extends Reference


# @var  Console
var _console


# @param  Console  console
func _init(console):
	self._console = console

	self._console.add_command('echo', self._console, 'write')\
		.set_description('Prints a string.')\
		.add_argument('text', TYPE_STRING)\
		.register()

	self._console.add_command('history', self._console.History, 'print_all')\
		.set_description('Print all previous commands used during the session.')\
		.register()

	self._console.add_command('commands', self, '_list_commands')\
		.set_description('Lists all available commands.')\
		.register()

	self._console.add_command('help', self, '_help')\
		.set_description('Outputs usage instructions.')\
		.add_argument('command', TYPE_STRING)\
		.register()

	self._console.add_command('quit', self, '_quit')\
		.set_description('Exit application.')\
		.register()

	self._console.add_command('clear', self._console)\
		.set_description('Clear the terminal.')\
		.register()
		
	self._console.add_command('panic', self, '_panic')\
		.set_description('Activates Pizza Time.')\
		.register()
		
	self._console.add_command('showcollisions', self, '_showcollisions')\
		.set_description('Toggles collision visibility.')\
		.register()
		
	self._console.add_command('debugview', self, '_debugview')\
		.set_description('Toggles debug camera view.')\
		.register()
		
	self._console.add_command('loadtest', self, '_loadtest')\
		.set_description('Go to test room')\
		.register()
		
	self._console.add_command('levelselect', self, '_levelselect')\
		.set_description('Level select')\
		.register()
		
	self._console.add_command('character', self, '_character')\
		.set_description('Changes the player character.')\
		.add_argument('character', TYPE_STRING)\
		.register()
		
	self._console.add_command('giveheat', self, '_giveheat')\
		.set_description('Add heat')\
		.register()

	self._console.add_command('version', self, '_version')\
		.set_description('Shows engine version.')\
		.register()

	self._console.add_command('fps_max', Engine, 'set_target_fps')\
		.set_description('The maximal framerate at which the application can run.')\
		.add_argument('fps', self._console.IntRangeType.new(10, 1000))\
		.register()


# Display help message or display description for the command.
# @param    String|null  command_name
# @returns  void
func _help(command_name = null):
	if command_name:
		var command = self._console.get_command(command_name)

		if command:
			command.describe()
		else:
			self._console.Log.warn('No help for `' + command_name + '` command were found.')

	else:
		self._console.write_line(\
			"Type [color=#ffff66][url=help]help[/url] <command-name>[/color] show information about command.\n" + \
			"Type [color=#ffff66][url=commands]commands[/url][/color] to get a list of all commands.\n" + \
			"Type [color=#ffff66][url=quit]quit[/url][/color] to exit the application.")

# It's Pizza Time!
func _panic():
	utils.debug_panic()
	
# Toggles collision visibility.
func _showcollisions():
	utils.debug_showcollisions()
	
# Toggles debug camera view.
func _debugview():
	utils.debug_view()
	
# Go to test room
func _loadtest():
	global.targetDoor = "A"
	utils.get_player().state = global.states.normal
	utils.room_goto("", "rm_testing")
	Console.toggle_console()
	
# Level select
func _levelselect():
	global.targetDoor = "A"
	utils.get_player().state = global.states.titlescreen
	utils.room_goto("", "rm_levelselect")
	Console.toggle_console()
	
func _character(character = null):
	if character:
		utils.debug_character(character)
		Console.toggle_console()
		
func _giveheat():
	utils.debug_giveheat()

# Prints out engine version.
# @returns  void
func _version():
	self._console.write_line(Engine.get_version_info())


# @returns  void
func _list_commands():
	for command in self._console._command_service.values():
		var name = command.get_name()
		self._console.write_line('[color=#ffff66][url=%s]%s[/url][/color]' % [ name, name ])


# Quitting application.
# @returns  void
func _quit():
	self._console.Log.warn('Quitting application...')
	self._console.get_tree().quit()
