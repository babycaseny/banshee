# Initializers
MONO_BASE_PATH = 
MONO_ADDINS_PATH =

# Install Paths
DEFAULT_INSTALL_DIR = $(pkglibdir)
ADDINS_INSTALL_DIR = $(DEFAULT_INSTALL_DIR)/addins

# External libraries to link against, generated from configure
LINK_SYSTEM = -r:System
LINK_SQLITE = -r:System.Data -r:Mono.Data.Sqlite
LINK_CAIRO = -r:Mono.Cairo
LINK_MONO_POSIX = -r:Mono.Posix
LINK_GLIB = $(GLIBSHARP_LIBS)
LINK_GTK = $(GTKSHARP_LIBS)
LINK_GCONF = $(GCONFSHARP_LIBS)
LINK_DBUS = $(NDESK_DBUS_LIBS)

# Internal directories/libraries

# Ext
DIR_EXT = $(top_srcdir)/ext

#DIR_MONO_ADDINS = $(DIR_EXT)/mono-addins/Mono.Addins
#MONO_BASE_PATH += $(DIR_MONO_ADDINS)
#LINK_MONO_ADDINS_DEPS = -r:$(DIR_MONO_ADDINS)/Mono.Addins.dll
LINK_MONO_ADDINS_DEPS = $(MONO_ADDINS_LIBS)
LINK_MONO_ADDINS_SETUP_DEPS = $(MONO_ADDINS_SETUP_LIBS)
LINK_MONO_ADDINS_GUI_DEPS = $(MONO_ADDINS_GUI_LIBS)

DIR_TAGLIB = $(DIR_EXT)/taglib-sharp
MONO_BASE_PATH += $(DIR_TAGLIB)
REF_TAGLIB = $(LINK_MONO_POSIX)
LINK_TAGLIB = -r:$(DIR_TAGLIB)/TagLib.dll
LINK_TAGLIB_DEPS = $(REF_TAGLIB) $(LINK_TAGLIB)


# Extras
DIR_EXTRAS = $(top_srcdir)/src/Extras

DIR_BOO = $(DIR_EXTRAS)/Boo
if EXTERNAL_BOO
LINK_BOO = $(BOO_LIBS)
else
LINK_BOO = \
	-r:$(DIR_BOO)/Boo.Lang.dll \
	-r:$(DIR_BOO)/Boo.Lang.Compiler.dll \
	-r:$(DIR_BOO)/Boo.Lang.Interpreter.dll
endif

DIR_BOOBUDDY = $(DIR_EXTRAS)/BooBuddy
MONO_BASE_PATH += $(DIR_BOOBUDDY)
REF_BOOBUDDY = $(LINK_GTK) $(LINK_BOO)
LINK_BOOBUDDY = -r:$(DIR_BOOBUDDY)/BooBuddy.dll
LINK_BOOBUDDY_DEPS = $(REF_BOOBUDDY) $(LINK_BOOBUDDY)

DIR_GNOME_KEYRING = $(DIR_EXTRAS)/Gnome.Keyring
MONO_BASE_PATH += $(DIR_GNOME_KEYRING)
REF_GNOME_KEYRING = $(LINK_DBUS) $(LINK_MONO_POSIX)
LINK_GNOME_KEYRING = -r:$(DIR_GNOME_KEYRING)/Gnome.Keyring.dll
LINK_GNOME_KEYRING_DEPS = $(REF_GNOME_KEYRING) $(LINK_GNOME_KEYRING)

DIR_LAST_FM = $(DIR_EXTRAS)/Last.FM
MONO_BASE_PATH += $(DIR_LAST_FM)
REF_LAST_FM = $(LINK_GTK) $(LINK_GNOME_KEYRING_DEPS)
LINK_LAST_FM = -r:$(DIR_LAST_FM)/Last.FM.dll
LINK_LAST_FM_DEPS = $(REF_LAST_FM) $(LINK_LAST_FM)

DIR_MUSICBRAINZ = $(DIR_EXTRAS)/MusicBrainz
MONO_BASE_PATH += $(DIR_MUSICBRAINZ)
REF_MUSICBRAINZ = $(LINK_SYSTEM)
LINK_MUSICBRAINZ = -r:$(DIR_MUSICBRAINZ)/MusicBrainz.dll
LINK_MUSICBRAINZ_DEPS = $(REF_MUSICBRAINZ) $(LINK_MUSICBRAINZ)


# Core
DIR_CORE = $(top_srcdir)/src/Core

DIR_HYENA = $(DIR_CORE)/Hyena
MONO_BASE_PATH += $(DIR_HYENA)
REF_HYENA = $(LINK_SYSTEM) $(LINK_SQLITE)
LINK_HYENA = -r:$(DIR_HYENA)/Hyena.dll
LINK_HYENA_DEPS = $(REF_HYENA) $(LINK_HYENA)

DIR_HYENA_GUI = $(DIR_CORE)/Hyena.Gui
MONO_BASE_PATH += $(DIR_HYENA_GUI)
REF_HYENA_GUI = $(LINK_HYENA_DEPS) $(LINK_MONO_POSIX) $(LINK_CAIRO) $(LINK_GTK)
LINK_HYENA_GUI = -r:$(DIR_HYENA_GUI)/Hyena.Gui.dll
LINK_HYENA_GUI_DEPS = $(REF_HYENA_GUI) $(LINK_HYENA_GUI)

DIR_BANSHEE_CORE = $(DIR_CORE)/Banshee.Core
MONO_BASE_PATH += $(DIR_BANSHEE_CORE)
REF_BANSHEE_CORE = $(LINK_HYENA_DEPS) $(LINK_MONO_POSIX) \
	$(LINK_DBUS) $(LINK_TAGLIB) $(LINK_GCONF)
LINK_BANSHEE_CORE = -r:$(DIR_BANSHEE_CORE)/Banshee.Core.dll
LINK_BANSHEE_CORE_DEPS = $(REF_BANSHEE_CORE) $(LINK_BANSHEE_CORE)

DIR_BANSHEE_SERVICES = $(DIR_CORE)/Banshee.Services
MONO_BASE_PATH += $(DIR_BANSHEE_SERVICES)
REF_BANSHEE_SERVICES = $(LINK_SQLITE) $(LINK_BANSHEE_CORE_DEPS) \
	$(LINK_MONO_ADDINS_DEPS)
LINK_BANSHEE_SERVICES = -r:$(DIR_BANSHEE_SERVICES)/Banshee.Services.dll
LINK_BANSHEE_SERVICES_DEPS = $(REF_BANSHEE_SERVICES) $(LINK_BANSHEE_SERVICES)

DIR_BANSHEE_WIDGETS = $(DIR_CORE)/Banshee.Widgets
MONO_BASE_PATH += $(DIR_BANSHEE_WIDGETS)
REF_BANSHEE_WIDGETS = $(LINK_MONO_POSIX) $(LINK_CAIRO) $(LINK_GTK)
LINK_BANSHEE_WIDGETS = -r:$(DIR_BANSHEE_WIDGETS)/Banshee.Widgets.dll
LINK_BANSHEE_WIDGETS_DEPS = $(REF_BANSHEE_WIDGETS) $(LINK_BANSHEE_WIDGETS)

DIR_BANSHEE_THICKCLIENT = $(DIR_CORE)/Banshee.ThickClient
MONO_BASE_PATH += $(DIR_BANSHEE_THICKCLIENT)
REF_BANSHEE_THICKCLIENT = $(LINK_BANSHEE_WIDGETS_DEPS) \
	$(LINK_BANSHEE_SERVICES_DEPS) $(LINK_HYENA_GUI_DEPS) $(LINK_MONO_ADDINS_SETUP_DEPS) $(LINK_MONO_ADDINS_GUI_DEPS)
LINK_BANSHEE_THICKCLIENT = -r:$(DIR_BANSHEE_THICKCLIENT)/Banshee.ThickClient.dll
LINK_BANSHEE_THICKCLIENT_DEPS = $(REF_BANSHEE_THICKCLIENT) \
	$(LINK_BANSHEE_THICKCLIENT)

DIR_NEREID = $(DIR_CORE)/Nereid
MONO_BASE_PATH += $(DIR_NEREID)
REF_NEREID = $(LINK_BANSHEE_THICKCLIENT_DEPS)


# Backends
DIR_BACKENDS = $(top_srcdir)/src/Backends

DIR_BACKEND_GSTREAMER = $(DIR_BACKENDS)/Banshee.GStreamer
MONO_ADDINS_PATH += $(DIR_BACKEND_GSTREAMER)
REF_BACKEND_GSTREAMER = $(LINK_BANSHEE_SERVICES_DEPS) $(LINK_GLIB)


# Extensions
DIR_EXTENSIONS = $(top_srcdir)/src/Extensions

DIR_EXTENSION_NOTIFICATIONAREA = $(DIR_EXTENSIONS)/Banshee.NotificationArea
MONO_ADDINS_PATH += $(DIR_EXTENSION_NOTIFICATIONAREA)
REF_EXTENSION_NOTIFICATIONAREA = $(LINK_BANSHEE_THICKCLIENT_DEPS)


# Build rules
# Ignoring 0278 due to a bug in gmcs: 
# http://bugzilla.ximian.com/show_bug.cgi?id=79998
BUILD_FLAGS = -debug -nowarn:0278 $(ASSEMBLY_BUILD_FLAGS)
BUILD = $(MCS) $(BUILD_FLAGS)
BUILD_LIB = $(BUILD) -target:library

# Cute hack to replace a space with something
colon:= :
empty:=
space:= $(empty) $(empty)

# Build path to allow running uninstalled
RUN_PATH = $(subst $(space),$(colon), $(MONO_BASE_PATH))

