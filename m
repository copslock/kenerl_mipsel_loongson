Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 10:34:14 +0000 (GMT)
Received: from tool.snarl.nl ([82.95.241.19]:7645 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20021333AbXCIKdq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2007 10:33:46 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 50A895DF46;
	Fri,  9 Mar 2007 11:33:08 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bdmtjwM0vt8i; Fri,  9 Mar 2007 11:33:07 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id CAF5D5DF3D; Fri,  9 Mar 2007 11:33:07 +0100 (CET)
Date:	Fri, 9 Mar 2007 11:33:07 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Marco Braga <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Message-ID: <20070309103307.GI25248@dusktilldawn.nl>
References: <20070307104930.GD25248@dusktilldawn.nl> <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlgRIH+VC25VUu7I"
Content-Disposition: inline
In-Reply-To: <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--UlgRIH+VC25VUu7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Fri, Mar 09, 2007 at 08:22:22AM +0100, Marco Braga wrote:
> I have exactly the same problem with a custom board based on an Alchemy
> Au1500, kernel 2.6.17.14 from linux-mips.org
> No solution at the moment.

The only solution I have yet is a small shell-script to load the
kernel driver and checks if all 38 controls are available. If not
it removes the driver and loads it again. Most of the times it
works right away and it's a very rare case that it takes the
script 8 loads to get all controls. I did around 143.000 tests
and 120.000 times it loaded correctly the first time, 20.000 the
seconds time, it faded gradually after that and only one time it
took 8 times.

But unfortunately, this work-around is far from perfect. It's
possible for the driver to load with all 38 controls, but wrong
control data. Let's say the CD volume control has a normal range
that is 0 - 31, and it happens sometimes the range is fucked up.
Let's say 0 - 15. Again snd_au1000_ac97_read() to blame.
Anyway, you don't want that, for obvious reason!

So as a more robust work-around, I'm almost finished with a small
Python program that reads /var/lib/alsa/asound.state (the saved
mixer values) and checks these against the values received from
the ALSA layer. I've patched pyalsaaudio-0.2 (the most usable
Python ALSA bindings IMHO) a little bit, and can now ask the
ALSA layer all relevant information needed. When it's completely
finished I shall mail the patches to the maintainer in the hope
he'll include them. And if finished I'm willing to share the
small Python program too, if anyone asks.

But what does this gives us? In the long run not much, to be
honoust! Like I told in my first email, I did also do a lot of
other tests and if the driver is loaded correctly things do work
well. So in the short run this is a good workable solution for
me.

But in the long run the kernel driver needs te be fixed of
course. And unfortunately I still consider myself a fool when it
comes to kernel programming. I have already decided to dive into
this a little bit in my spare time, but I'm afraid I lack the
right kernel knowledge when it comes to solve this issue. Charles
Eidsnes nicely answered my email with some tips, but also told me
he has other priorities than to dive into this. If one is up to
the challange to fix this he is willing to answer some questions,
but he's not actively involved with mips-linux anymore. Anyway,
here is his tip to look into:

On Wed, Mar 07, 2007 at 06:48:05PM -0500, Charles Eidsness wrote:
> I'm not sure what could cause this issue. Given your results on
> different hardware I think you're right in assuming that it's
> not a hardware issue (at least not with your AC'97 Codec). It
> kind of seems like a S/W timing issue. All that I can think of
> to suggest it to try adding some delays during the read cycle
> and see if that helps. It may be that there is some lag between
> when the processor says the data register has data, and when it
> really has data. You could also try to implement an interrupt
> based read, you may have better luck with it than I did. I gave
> up because it was taking me too long to get it to work, and I
> didn't mind the extra over-head of a polled read.

Sounds like some good advice to look into. Althought I'm a little
bit confused about why the AC97 controller would state that
information is available, when it is really not yet available.
Sounds like plain wrong to me. But then again, do not forget that
I'm the fool without a lot of knowledge on the subject again. :)

Anyway, to end up this long, long writing. Within a couple of
hours I'm of to the south of France to do some serious
snowboarding, so I will not look into this for like a little more
than a week. After that I will finish the Python work-around and
in my spare time shall dive into a real solution, but not with
much hope of fixing it for real.

Thanks for your reply and maybe with this little bit of extra
information some kernel hacker has his druthers and fixes the
bloody thing. If not just wait what I come up with, but please
don't hold your breath to it.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--UlgRIH+VC25VUu7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF8Tfjbxf9XXlB0eERAkDpAJ4yJd5/Q72RJICSEp8+47mY8CU/cwCgo3SW
cCk3rngKG+PA34VdzgRLedI=
=66Qc
-----END PGP SIGNATURE-----

--UlgRIH+VC25VUu7I--
