Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 16:40:55 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:6660 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225205AbTDJPky>; Thu, 10 Apr 2003 16:40:54 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id B451F4AB8D; Thu, 10 Apr 2003 17:40:50 +0200 (CEST)
Date: Thu, 10 Apr 2003 17:40:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: ext3 under MIPS?
Message-ID: <20030410154050.GI5242@lug-owl.de>
Mail-Followup-To: Linux MIPS mailing list <linux-mips@linux-mips.org>
References: <3E954651.C7AECB90@ekner.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Content-Disposition: inline
In-Reply-To: <3E954651.C7AECB90@ekner.info>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-04-10 12:24:17 +0200, Hartvig Ekner <hartvig@ekner.info>
wrote in message <3E954651.C7AECB90@ekner.info>:
> Hi,
>=20
> I have been using ext3 with MIPS, and it seems to work fine during normal=
 operations. However, when
> doing an unclean shutdown things don't exactly behave the way I believe t=
hey should. Does anybody
> know how the ext3 recovery is supposed to work?
>=20
> Basically I just reset the system mid-stream to see what happens. This me=
ans the rc.sysinit "control
> file "/.autofsck" is on the filesystem to indicate an unclean shutdown. D=
uring the next boot I get:
>=20
> ... stuff deleted
>=20
> ttyS02 at 0xb1300000 (irq =3D 2) is a 16550
> ttyS03 at 0xb1400000 (irq =3D 3) is a 16550
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.

It recovers the journal. That's fine (and works as expected).

> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 64k freed
> Algorithmics/MIPS FPU Emulator v1.5
> INIT: version 2.84 booting
>=20
> So, it seems the kernel ext3 filesystem code runs some kind of recovery b=
ased on the
> journal prior to the actual mount of / occurring, which is exactly what I=
 would expect
> to happen, right?

Jupp.

> Then bootup continues with:
>=20
>=20
>                Welcome to Red Hat Linux
>                 Press 'I' to enter interactive startup.
> Mounting proc filesystem:  [  OK  ]
> Configuring kernel parameters:  [  OK  ]
> Cannot access the Hardware Clock via any known method.
> Use the --debug option to see the details of our search for an access met=
hod.
> Setting clock  (localtime): Thu Jan  1 01:00:13 CET 1970 [  OK  ]
> Activating swap partitions:  [  OK  ]
> Setting hostname copau01:  [  OK  ]
> modprobe: Can't open dependencies file /lib/modules/2.4.21-pre4/modules.d=
ep (No
> such file or directory)
> modprobe: Can't open dependencies file /lib/modules/2.4.21-pre4/modules.d=
ep (No
> such file or directory)
> Your system appears to have shut down uncleanly
> Press Y within 3 seconds to force file system integrity check...y
> Checking root filesystem
> /dev/hdc2: Inodes that were part of a corrupted orphan linked list found.
>=20
> /dev/hdc2: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
>         (i.e., without -a or -p options)
> [/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -f /dev/hdc2
>=20
> [FAILED]
>=20
> *** An error occurred during the file system check.
> *** Dropping you to a shell; the system will reboot
> *** when you leave the shell.
> Give root password for maintenance
> (or type Control-D for normal startup):
>=20
> So can somebody tell me what the heck just happened? After the ext3 recov=
ery done before the mount,
> .autofsck is still on the disk, so the rc.sysinit script of course assume=
s the shutdown was unclean,

This ".autofsck" file seems to be a userland approach to detect a system
which wasn't shutted down completely. Even this is fine. What's *not*
okay is that there are still errors remaining. It seems your filesystem
has been damaged before (and in no means which could have been handled
by the journal).

> and pops the 5-second question. However, if I to be safe push "Y" here to=
 get my filesystem check (which
> I guess should be unnecessary, due to the ext3 recovery just run, right?)=
, strange things happen and
> fsck reports the "corrupted orphan list... " error.

Wrong. The journal should prevent you from actually loosing things at
hard-power-off situations. It does *not* cover things like silent data
corruption, which may have lead to this breakage.

> Is there something wrong here, or how should the system behave?

Everything with journal recovery is fine here. The failing fsck is a
different problem (a journal doesn't preven you to do a fsck at a
regular basis. It's only to not be forced to to it if you don't have the
time to do this *now* (on crash)).

So there seems do be some corruption (caused by whatever) going on at
your system:-(

Watch out if this happens again soon after you've completed the fsck.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lZCCHb1edYOZ4bsRAu/aAJsGMil0tUh5/9VCrTYBwIIsDNoekACgiYdv
DawzfpgDI3jrqqs4khGJREs=
=5hK5
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--
