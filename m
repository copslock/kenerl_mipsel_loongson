Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2007 10:50:19 +0000 (GMT)
Received: from tool.snarl.nl ([82.95.241.19]:62156 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20021572AbXCGKuP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2007 10:50:15 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id A3FC85DF46;
	Wed,  7 Mar 2007 11:49:31 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zUKxGWHbzVhE; Wed,  7 Mar 2007 11:49:31 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 31C1A5DF3D; Wed,  7 Mar 2007 11:49:31 +0100 (CET)
Date:	Wed, 7 Mar 2007 11:49:30 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Charles Eidsness <charles@cooper-street.com>
Cc:	linux-mips@linux-mips.org
Subject: Trouble with sound/mips/au1x00.c AC97 driver
Message-ID: <20070307104930.GD25248@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lf0NQ8GVTdtriwpn"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--lf0NQ8GVTdtriwpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Charles,

I'm experiencing strange behaviour with the sound/mips/au1x00.c
AC97 driver. I'm using kernel 2.6.16, but 2.6.20 gives me the
same results.

When I load the driver sometimes (frequently enough that it's a
serious problem) I do not get all 38 simple mixer controls.
Sometimes I'm missing one or more controls, but in a more rare
situation it also happens that a control holds the wrong min/max
values. And in an even more rare situation I get the error below
while loading the driver:

	AC'97 0 access error (not audio or modem codec)

I have tried to track it down and it all boils down to the
snd_au1000_ac97_read() routine, I think. When I try to debug the
problem, I see that most of the time the res and val variables
compared in snd_ac97_try_bit() from sound/pci/ac97/ac97_codec.c
do not appear to be equal. Hence the missing controls. It looks
to me that snd_au1000_ac97_read() is not returning a value
expected.

When I look at the snd_au1000_ac97_read() implementation it looks
good to me. I've read the AU1100 Processor Data Book and your
routine does exactly the thing needed to read data from the AC97
controller. I've also inspected the whole thing a little bit and
I never receive a 'au1000 AC97: AC97 command read timeout'. Never
is a command still pending before you stop try to poll for the
sane situation and never is an answer not yet received from the
codec before you stop polling for it. And the poll values are
never close to the 0x5000 max you specify. For the latter test
(the test if the data is available) I have also checked if the
data is available right away (i=3D=3D0). This happens rarely and does
not cause trouble if it happens.

So there is not much that I understand that goes wrong in this
routine. I might be wrong of course. Any insight from real kernel
hackers?

I really do get the feeling that it's a hardware thing. But my
hardware engineer doesn't yet believe that. And I'm afraid he has
sound (sic :) reasoning. I've tested this code on two different platforms.
The first is an official AMD SYRAH DbAu1100 board with a Sigmatel
STAC9752T audio codec and the second is our own Balvenie board
(based on the DbAu1100 design) with an Wolfson WM9705 audio
codec. Both platforms experience the same problems.

We have also checked all the timings to and from the codec with
an oscilloscope and they are up to spec. Nothing strange
happening over there.

What I've also done is play a sound file constantly over the
course of several days. During that playing I constantly did some
muting/unmuting of the 'Master', 'Master Mono' and 'Headphone'
output. I connected some speakers and the small shell-script I
wrote rotated the audio in a nice loop around the speakers. This
happened like every second or so. No error messages from the
amixer utility over that course of days and no error message from
aplay whatsoever. I have also never heard any strange glitch in
the playing of audio, but if only a few samples are missing or
tampered it might be impossible to hear.

Anyway, does anyone have ever experienced this trouble and have
any clue what might causes it?


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--lf0NQ8GVTdtriwpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF7pi6bxf9XXlB0eERAua6AJ9QZDnNIy0g5vG7ETzvYfobbUrbRACg7GPa
UJWUR2SgCsaxD6w0CI6OlOU=
=9dai
-----END PGP SIGNATURE-----

--lf0NQ8GVTdtriwpn--
