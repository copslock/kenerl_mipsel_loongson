Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AI91o09067
	for linux-mips-outgoing; Thu, 10 May 2001 11:09:01 -0700
Received: from straylight.cyberhqz.com (root@h24-78-251-235.vc.shawcable.net [24.78.251.235])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AI90F09064
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 11:09:00 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id LAA10011;
	Thu, 10 May 2001 11:08:47 -0700
Date: Thu, 10 May 2001 11:08:47 -0700
From: Ryan Murray <rmurray@debian.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010510110847.A2799@cyberhqz.com>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com> <20010509104635.D12267@paradigm.rfc822.org> <3AF934AE.38AB0089@cotw.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AF934AE.38AB0089@cotw.com>; from sjhill@cotw.com on Wed, May 09, 2001 at 07:14:38AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2001 at 07:14:38AM -0500, Steven J. Hill wrote:
> Florian Lohoff wrote:
> >=20
> > > > The whole point was to switch from our IRIX ELF flavoured binaries =
to
> > > > standard ABI ELF.  These two variants are close but not identical w=
hich
> > > > for example made modutils missbehave.
> > >
> I will expound a bit more. When I made the changes to fix binutils and sw=
itch
> us from the IRIX to ABI ELF flavoured binaries the default target names
> changed from 'elf[32|64][little|big]mips' to 'elf[32|64]trad[little|big]m=
ips'
> in binutils. This has the effect of breaking linker scripts but not a who=
le
> lot else. These will be the new targets for MIPS/Linux work. Binaries sho=
uld
> still run just fine if you compile glibc-2.2.2 with the old or new tools.
> Future work though should use the 'elf[32|64]trad[little|big]mips' target=
s.

So, in summary:
	* all existing binaries do not need to be recompiled, and should
	  continue to work.  (shlibs included?)
	* all new binaries should use the new formats.

To get the new targets working correctly:
	* new binutils
	* new gcc built with new binutils (does the 2.95.4 branch have the changes=
, or only 3.0?)
	* new libc built with new gcc
	* rebuild gcc with the new libc

Am I missing anything?

> > > Is anybody working on a solution, or are we waiting for the debian pe=
ople
> > > to rebuild all the packages?
> >=20
> You bet your ass they are in CVS. The Debian MIPS people? That would be F=
lo
> and Jason M. I believe. I'm getting ready to start a flame war (well I ho=
pe
> not, but it has potential) on the debian-mips list right after this email.
> You might want to hop up there and read that if you are interested.

> > I'll lean back, continue building .debs and wait for others to fix it.
> >
> And this is the problem Flo. Hop up to debian-mips and lets talk.

atm, I'm not building any packages, waiting for this to be resolved.

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6+tkuN2Dbz/1mRasRAtNwAJkBAT+/nlmQCVZ0hMh43+R8w4w3xQCfYvhK
rRxmRrO6zetdyJj6NcWXR74=
=ZpGp
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
