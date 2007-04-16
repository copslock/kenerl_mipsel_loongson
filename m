Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 15:48:01 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:7126 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20023318AbXDPOr7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 15:47:59 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 7A7865DF8D;
	Mon, 16 Apr 2007 16:47:53 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SeHyvO0jy+0I; Mon, 16 Apr 2007 16:47:53 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id DB24D5DF3D; Mon, 16 Apr 2007 16:47:52 +0200 (CEST)
Date:	Mon, 16 Apr 2007 16:47:52 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Jaroslav Kysela <perex@suse.cz>
Cc:	Marco Braga <marco.braga@gmail.com>,
	Charles Eidsness <charles@cooper-street.com>,
	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Message-ID: <20070416144752.GT18693@dusktilldawn.nl>
References: <20070307104930.GD25248@dusktilldawn.nl> <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com> <45F350E9.3020208@cooper-street.com> <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com> <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com> <45F5DC73.9060004@cooper-street.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Chn8nxio6L/4biUD"
Content-Disposition: inline
In-Reply-To: <45F5DC73.9060004@cooper-street.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--Chn8nxio6L/4biUD
Content-Type: multipart/mixed; boundary="SSJ6yXlPvEk0CmSI"
Content-Disposition: inline


--SSJ6yXlPvEk0CmSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaroslav,

Please find attached a patch that fixes some known problems
currently part of the au1x00 ALSA audio driver.

Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

Below is a small time explanation of why the patch is needed.


On Mon, Mar 12, 2007 at 07:04:19PM -0400, Charles Eidsness wrote:
> I wonder if the AC'97 Controller has to be up for at least one
> frame before issuing the cold reset. Each frame is 20.8us, you
> could try setting that delay to 25us instead of 500ms.

The 10us delay indeed is not enough. 25us gives way better
results. Combining it with...

> Sergei on the mailing list had a good suggestion as well. You could try=
=20
> replacing every udelay with an au_sync_udelay, and each mdelay with an=20
> au_sync_delay.

=2E..Sergei his suggestion, and more importantly...


> I think that spin_lock_irqsave stuff might fix the problem that Freddy=20
> has

=2E..replacing spin_lock() by spin_lock_irqsave() gives me good
results.

Still not perfectly, but way better than it was. Using the Python
audio-script I've attached to this email I've loaded and unloaded
the driver 4033 times and it failed 6 times on me. Failing means
one control is missing or a control features the wrong settings.
If this happens the Python script tries to load the driver again
and in all of my tests succeeds right away.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--SSJ6yXlPvEk0CmSI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="au1x00.patch"
Content-Transfer-Encoding: quoted-printable

diff -Naur linux-2.6.20.orig/sound/mips/au1x00.c linux-2.6.20/sound/mips/au=
1x00.c
--- linux-2.6.20.orig/sound/mips/au1x00.c	2007-02-04 20:22:45.000000000 +00=
00
+++ linux-2.6.20/sound/mips/au1x00.c	2007-04-16 14:04:39.000000000 +0000
@@ -496,8 +496,9 @@
 	u32 volatile cmd;
 	u16 volatile data;
 	int             i;
+	unsigned long flags;
=20
-	spin_lock(&au1000->ac97_lock);
+	spin_lock_irqsave(&au1000->ac97_lock, flags);
 /* would rather use the interupt than this polling but it works and I can't
 get the interupt driven case to work efficiently */
 	for (i =3D 0; i < 0x5000; i++)
@@ -520,7 +521,7 @@
 	}
=20
 	data =3D au1000->ac97_ioport->cmd & 0xffff;
-	spin_unlock(&au1000->ac97_lock);
+	spin_unlock_irqrestore(&au1000->ac97_lock, flags);
=20
 	return data;
=20
@@ -533,8 +534,9 @@
 	struct snd_au1000 *au1000 =3D ac97->private_data;
 	u32 cmd;
 	int i;
+	unsigned long flags;
=20
-	spin_lock(&au1000->ac97_lock);
+	spin_lock_irqsave(&au1000->ac97_lock, flags);
 /* would rather use the interupt than this polling but it works and I can't
 get the interupt driven case to work efficiently */
 	for (i =3D 0; i < 0x5000; i++)
@@ -547,7 +549,7 @@
 	cmd &=3D ~AC97C_READ;
 	cmd |=3D ((u32) val << AC97C_WD_BIT);
 	au1000->ac97_ioport->cmd =3D cmd;
-	spin_unlock(&au1000->ac97_lock);
+	spin_unlock_irqrestore(&au1000->ac97_lock, flags);
 }
=20
 static int __devinit
@@ -577,15 +579,15 @@
=20
 	/* Initialise Au1000's AC'97 Control Block */
 	au1000->ac97_ioport->cntrl =3D AC97C_RS | AC97C_CE;
-	udelay(10);
+	au_sync_udelay(10);
 	au1000->ac97_ioport->cntrl =3D AC97C_CE;
-	udelay(10);
+	au_sync_udelay(25);
=20
 	/* Initialise External CODEC -- cold reset */
 	au1000->ac97_ioport->config =3D AC97C_RESET;
-	udelay(10);
+	au_sync_udelay(10);
 	au1000->ac97_ioport->config =3D 0x0;
-	mdelay(5);
+	au_sync_delay(5);
=20
 	/* Initialise AC97 middle-layer */
 	if ((err =3D snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus)) < 0)

--SSJ6yXlPvEk0CmSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=audio
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/python
#
# Nice script to load/unload the audio kernel driver. It checks as much
# controls as possible. It does this by comparing the configured values to =
the
# values restored after loading the driver. It reads the configured values =
=66rom
# /var/lib/alsa/asound.state and tries to load the driver again if any cont=
rol
# does not hold it's configured value or is even missing.
#
# Usage: audio start|stop
#
# Freddy Spierenburg <freddy@dusktilldawn.nl>  Mon, 16 Apr 2007 16:39:45 +0=
200

import sys, os, re, string, alsaaudio

# This is the class definition for the base control type. All derived contr=
ols
# share this information.
class Control:
	# The class constructor method.
	def __init__(self, storage):
		# Get the name for this control.
		self.name =3D storage['name'].replace('\'', '')

		# Initialize the value list.
		self.value =3D []
		# Does this control has more than one value?
		if int(storage['comment.count']) > 1:
			# Yes, run through all the values.
			for index in range(int(storage['comment.count'])):
				# Save every value in our value list.
				self.value.append(storage['value.' + str(index)])
		else:
			# No, just store this one value in the list.
			self.value.append(storage['value'])

	# A nice debug information method.
	def show(self):
		# Show the name for this control.
		print self.name, ':'
		# Run through all the values for this control.
		for v in self.value:
			# Show every value.
			print 'value =3D', v
	=09

# This is the class definition for the boolean control type.
class BooleanFactory:
	def Create(self,storage):
		return Boolean(storage)

class Boolean(Control):
	# The class constructor method.
	def __init__(self, storage):
		# Start the constructor for the base class.
		Control.__init__(self, storage)

	# The test method to see if the control is initialized correctly. We test =
to see
	# if the current boolean value is equal to the one configured.
	def error(self):
		# Get the real name for the control. All control names should be stripped=
 from the
		# named strings, except the one holding a '-' character.
		control =3D self.name
		if control.count('-') =3D=3D 0:
			control =3D control.replace('Playback Switch', '').replace('Switch', '')
		control =3D control.strip()

		try:
			# Get a reference to the control
			mixer =3D alsaaudio.Mixer(control)
			# Find the mute state for this control.
			mute =3D mixer.getmute()
			# Return true if the current boolean value is not equal to the configure=
d value.
			return not ((mute[0] =3D=3D 0 and self.value[0] =3D=3D 'true') or (mute[=
0] =3D=3D 1 and self.value[0] =3D=3D 'false'))
		except alsaaudio.ALSAAudioError:
			# An error probably indicates a missing control. This is bad!
			return True


# This is the class definition for the integer control type.
class IntegerFactory:
	def Create(self,storage):
		return Integer(storage)

class Integer(Control):
	# The class constructor method.
	def __init__(self, storage):
		# Start the constructor for the base class.
		Control.__init__(self, storage)
		# An integer type holds a range. Split it into a minimum and
		# maximum field.
		field =3D string.split(re.sub("'", '', storage['comment.range']), '-')
		# Save the minimum value.
		self.minimum =3D int(field[0])
		# Save the maximum value.
		self.maximum =3D int(field[1])

	# A nice debug information method.
	def show(self):
		# Show the information for the base class.
		Control.show(self)
		# Show the configured minimum and maximum value for the range.
		print 'minimum =3D', self.minimum, 'maximum =3D', self.maximum

	# The test method to see if the control is initialized correctly. We test =
to see
	# if the range value is like expected and the current volume setting is li=
ke it
	# is configured.
	def error(self):
		# Get the real name for the control.
		control =3D self.name.replace('Playback Volume', '').replace('Volume', ''=
).strip()
		try:
			# Get a reference to the control.
			mixer =3D alsaaudio.Mixer(control)
		except alsaaudio.ALSAAudioError:
			# An error indicates a missing control. This is bad!
			return True
		# Find the range for this control.
		rng =3D mixer.getrange()
		# Check if the current range value is like expected.
		rangeOK =3D (rng[0] =3D=3D self.minimum and rng[1] =3D=3D self.maximum)

		# Find the current volume value.
		volume =3D mixer.getvolume()
		# Expect this volume value to be good by default.
		volumeOK =3D True
		# Run through the found volume values.
		for index in range(len(volume)):
			# We get the percentage volume value from the ALSA layer, but
			# we need the index value. Calculate the index value from the
			# percentage.
			volume[index] =3D round(volume[index] * self.maximum / 100.0)
			# Is the current volume value not equal to the configured value?
			if volume[index] !=3D int(self.value[index]):
				# Yes, unfortunately there is something wrong. Set our flag!
				volumeOK =3D False
				# And stop checking right away. We're out of luck anyway!
				break
			=09
		# Return true if the range or volume is not ok!
		return not (rangeOK and volumeOK)
	=09

# This is the class definition for the enumerated control type.
class EnumeratedFactory:
	def Create(self,storage):
		return Enumerated(storage)

class Enumerated(Control):
	# The class constructor method.
	def __init__(self, storage):
		# Start the constructor for the base class.
		Control.__init__(self, storage)
=09
	# A nice debug information method.
	def show(self):
		# Show only the information for the base class.
		Control.show(self)

	# The test method to see if the control is initialized correctly. We test =
to
	# see if the current enumerated type value for the control is equal to the
	# configured value.
	def error(self):
		try:
			# Get a reference to the control.
			mixer =3D alsaaudio.Mixer(self.name)
			# Find the enumerated type for this control.
			enum =3D mixer.getenum()
			# Return true if the current enumerated type is not equal to the
			# configured one.
			return not (enum[0] =3D=3D self.value[0].replace('\'', ''))
		except alsaaudio.ALSAAudioError:
			# An error probably indicates a missing control. This is bad!
			return True


# We do not yet do much with the IEC958 control type.
class IEC958Factory:
	def Create(self,storage):
		return IEC958(storage)

class IEC958(Control):
	def __init__(self, storage):
		Control.__init__(self, storage)


# The factories is a dictionary of control types we recognize and handle.
factories =3D {
	'BOOLEAN': BooleanFactory(),
	'INTEGER': IntegerFactory(),
	'ENUMERATED': EnumeratedFactory(),
	'IEC958': IEC958Factory()
}

# The list of all the controls that should be available. If we need to
# check them they hold the value true, false if we choose to ignore them.
controlsAvailableList =3D {
	"'Master Playback Switch'": True,
	"'Master Playback Volume'": True,
	"'Headphone Playback Switch'": True,
	"'Headphone Playback Volume'": True,
	"'Master Mono Playback Switch'": True,
	"'Master Mono Playback Volume'": True,
	"'PC Speaker Playback Switch'": True,
	"'PC Speaker Playback Volume'": True,
	"'Phone Playback Switch'": True,
	"'Phone Playback Volume'": True,
	"'Mic Playback Switch'": True,
	"'Mic Playback Volume'": True,
	"'Mic Boost (+20dB)'": True,
	"'Line Playback Switch'": True,
	"'Line Playback Volume'": True,
	"'CD Playback Switch'": True,
	"'CD Playback Volume'": True,
	"'Video Playback Switch'": True,
	"'Aux Playback Switch'": True,
	"'PCM Playback Switch'": True,
	"'PCM Playback Volume'": True,
	"'Capture Source'": False,
	"'Capture Switch'": False,
	"'Capture Volume'": True,
	"'PCM Out Path & Mute'": True,
	"'3D Control - Switch'": True,
	"'Mono Output Select'": True,
	"'Mic Select'": True,
	"'3D Control - Center'": True,
	"'3D Control - Depth'": True,
	"'IEC958 Playback Con Mask'": False,
	"'IEC958 Playback Pro Mask'": False,
	"'IEC958 Playback Default'": False,
	"'IEC958 Playback Switch'": False,
	"'IEC958 Playback AC97-SPSA'": False,
	"'Front Playback Volume'": True,
	"'Front Playback Switch'": True,
	"'External Amplifier'": True
}

# The routine to stop the audio driver.
def driverStop():
	os.system('/sbin/rmmod snd-au1x00 > /dev/null 2>&1')
=09
# The routine to start the audio driver.
def driverStart():
	# The start of a control block is marked by the next reg-exp.
	start =3D re.compile('control')
	# The end of a control block is marked by the next reg-exp.
	end =3D re.compile('\s+}$')

	# We only add stuff to our storage when we are inside a control block.
	process =3D False
	# Initialize our temporary storage to be empty at the start.
	storage =3D {}
	# Initialize our list of controls to be empty at the start..
	controls =3D []

	# Open the ALSA configuration file.
	file=3Dopen('/var/lib/alsa/asound.state', 'r')
	# Process every line read from the file.
	for line in file.readlines():
		# What kind of line is this?
		if start.search(line):
			# It marks the start of a control block. Start processing.
			process =3D True
			# Clear our temporary storage before we begin.
			storage.clear()
		elif end.search(line):
			# It marks the end of a control block. Stop processing.
			process =3D False
			# Is this one of the controls we would like to check?
			if controlsAvailableList.has_key(storage['name']) and controlsAvailableL=
ist[storage['name']]:
				# Yes! Find out by means of the control type, what kind of object to cr=
eate.
				factory =3D factories[storage['comment.type']]
				# Add the object type to our list of controls.
				controls.append(factory.Create(storage))
		elif process:
			# We are in the middle of processing and this line is data we need to
			# store in our object. First split the line in a name and value pair. The
			# first space is seen as the separator.
			field =3D string.split(string.strip(line), ' ', 1)
			# Put the name and value pair inside our temporary storage.
			storage[field[0]]=3Dfield[1]
	# Close the file.
	file.close()

	# To see if the driver is loaded is marked by the next reg-exp.
	driver =3D re.compile('^snd_au1x00')
	# By default we expect our driver not to load.
	loaded =3D False
	# Continue to load the driver untill it is loaded.
	while not loaded:
		# Run the command to find out which kernel drivers are loaded.
		stdout =3D os.popen('/bin/lsmod')
		# Read the output from the previous command.
		output =3D stdout.read()
		# Is our driver loaded?
		if driver.search(output):
			# Yes, mark that we've loaded the driver.
			loaded =3D True
		else:
			# No, so try to load it ourselves.
			loaded =3D not os.system('(/sbin/modprobe snd-au1x00 && /etc/init.d/alsa=
-utils start) > /dev/null 2>&1')

		# If we're loaded we are going to check if everything is ok.
		ok =3D loaded
		# Is everything ok?
		if ok:
			# Yes, run our command to find out how many control we have got.
			stdout =3D os.popen('/usr/bin/amixer controls')
			# See if we have all the expected controls. Are we missing some?
			if len(stdout.readlines()) !=3D len(controlsAvailableList):
				# Yes, mark that we are not ok anymore.
				ok =3D False
		# Is everything still ok?
		if ok:
			# Yes, process all the found controls.
			for control in controls:
				# Does this control object has a error method?
				if hasattr(control, 'error'):
					# Yes, it has. Now run it, to see if an error in the control exist. Do=
es it?
					if control.error():
						# Yes, mark that we are not ok anymore.
						ok =3D False
						# Stop processing, since it does not make sense anymore
						break
		=09
		# Did anything go wrong and was the driver loaded?
		if not ok and loaded:
			# Yes, so mark that we still have not loaded the driver successfully.
			loaded =3D False
			# Stop the driver.
			driverStop()

# A nice usage routine.
def usage():
	# Write the usage of this program to stdout.
	print 'Usage: %s {start|stop}' % (sys.argv[0])
	# Quit right away.
	sys.exit(1)

# Do we have received enough command line arguments?
if len(sys.argv) >=3D 2:
	# Yes, what was the first argument received?
	if sys.argv[1] =3D=3D 'start':
		# It was our command to start the driver. Start it!
		driverStart()
	elif sys.argv[1] =3D=3D 'stop':
		# It was our command to stop the driver. Stop it!
		driverStop()
	else:
		# It was an unknown command. Display our usage message.
		usage()
else:
	# No, display our usage message.
	usage()

# Exit cleanly.
sys.exit(0)

--SSJ6yXlPvEk0CmSI--

--Chn8nxio6L/4biUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGI4yYbxf9XXlB0eERAiN2AJ9tuacSRfHOCK94DhH/QjXORfxw/gCgvNaC
4R2nFbmKcfHjAcVS1RwharE=
=XyEI
-----END PGP SIGNATURE-----

--Chn8nxio6L/4biUD--
