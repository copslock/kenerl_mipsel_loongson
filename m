Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 07:48:05 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:24580 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225196AbTDKGsE>; Fri, 11 Apr 2003 07:48:04 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 7166E4AB36; Fri, 11 Apr 2003 08:47:56 +0200 (CEST)
Date: Fri, 11 Apr 2003 08:47:56 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: ext3 under MIPS?
Message-ID: <20030411064754.GM5242@lug-owl.de>
Mail-Followup-To: Linux MIPS mailing list <linux-mips@linux-mips.org>
References: <3E954651.C7AECB90@ekner.info> <20030410154050.GI5242@lug-owl.de> <3E95D16D.1671BA5A@ekner.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uwB7x3tnyrZQfZJI"
Content-Disposition: inline
In-Reply-To: <3E95D16D.1671BA5A@ekner.info>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--uwB7x3tnyrZQfZJI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-04-10 22:17:49 +0200, Hartvig Ekner <hartvig@ekner.info>
wrote in message <3E95D16D.1671BA5A@ekner.info>:
> Jan-Benedict Glaw wrote:

[ext3 fs corruption after journal recovery]

> I can reproduce this anytime by just pushing the reset button and checkin=
g the filesystem
> at reboot after ext3 recovery has run. However, if I just do regular fsck=
's (without unclean
> shutdowns) nothing seems to be wrong. So I am pretty sure it is something=
 which

How do you invoce fsck?

> goes wrong in conjunction with the unclean shutdowns.

That's bad then:-(

> Is ext3 journal recovery really supposed to recover everything to a state=
 where fsck returns no
> errors, or is it potentially leaving non-fatal errors in the filesystem (=
e.g. lost inodes which just

No. The concept is different.

Such a journal will log things like:

- File creation/deletion
- Owner/timestamp/access changes

These informations are restored during journal recovery. Most
filesystems do /not/ store the actual data you're writing to a file into
the journal. So, after you've issued a write() and presses the reset
button, the journal contains the new filesize, but by possibility
__not__ the data you've written to the file. So file size is okay, but
file content isn't. It's basically the job of the journal to keep your
filesystem intact, but not your data.

If you do this:

	- Boot with / mounted r/o
	- e2fsck -f /dev/your-root-device
	- Reset
	- Boot with / mounted r/w
	- Write something
	- Reset

You shouldn't see fsck failing (except it may replay the journal for
filesystems which hadn't been mounted on /).

If you see corruption here (ie. fsck finds problems after replaying the
journal), something is serverely broken.


> reduces capacity, but does not cause further corruption if the filesystem=
 is used) which will then
> be picked up by a later fsck when one has time to run it?

It should present you a f/s with no *known* problems. If corruption
(broken DMA transfers, ...) took place, this hasn't eventually logget
into the journal so this isn't recovered:-)

> What does the error "Inodes that were part of a corrupted orphan linked l=
ist found." actually
> mean? Is this a fatal error, or a non-critical error along the lines I de=
scribed above (an error
> which does not get any worse if the filesystem is used)?

I think this basically means that fsck found files of a (destroyed)
directory. But for exact statements here, read e2fsck's sources...

> Is there anybody with ext3 up and running who would volunteer to do a cou=
ple of unclean
> shutdowns and see if the recovery works without any fsck errors present a=
fterwards?

:-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--uwB7x3tnyrZQfZJI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lmUZHb1edYOZ4bsRAkrOAJ99YcZXXAv5V7L4Og5Xsx8wDikuUQCeLK1y
uUeRA36NKnr6ZMvtmzIOeeQ=
=2I05
-----END PGP SIGNATURE-----

--uwB7x3tnyrZQfZJI--
