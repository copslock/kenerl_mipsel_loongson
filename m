Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 17:45:09 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:17127 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8225252AbUIXQpF>;
	Fri, 24 Sep 2004 17:45:05 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id ACE9A199607; Fri, 24 Sep 2004 18:45:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id AD222138065; Fri, 24 Sep 2004 18:44:30 +0200 (CEST)
Date: Fri, 24 Sep 2004 18:44:30 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: "Stephen P. Becker" <geoman@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20040924164430.GA29683@paradigm.rfc822.org>
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org> <41536765.9000304@longlandclan.hopto.org> <20040924090703.GA13468@paradigm.rfc822.org> <4154407A.4050204@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <4154407A.4050204@longlandclan.hopto.org>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 25, 2004 at 01:42:50AM +1000, Stuart Longland wrote:
> >
> > The 64 bit kernel should work so far - With the ip22zilog.c fixes
> > tsbogend just committed the console begins to work again.
> >
> > Includeing the patch i sent earlier my R5k Indy boots fine a 64bit
> > current cvs head and goes into userspace.
> >
> > Using the "soo to be" rtc and statfs64 fixes everything seems to be
> > fine for o32 userspace.
>=20
> Tried the patch, for some reason 'patch' couldn't find some of the
> files, and was expecting me to enter the paths in by hand... but once I
> did that, it applied cleanly[1].

The last file has a bogus path (Hand crafted patch) and needs the first=20
path element removed IIRC.

> Exception: <vector=3DNormal>
> Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=3D???,MODE=3DKERNEL,EXL,I=
E>
> Cause register: 0x8010<CE=3D0,IP8,EXC=3DRADE>
> Exception PC: 0x830f018, Exception RA: 0x88804514
> Read address error exception, bad address: 0x830f018
>Local I/O interrupt register 1: 0x80 <VR/GIO2>
>   Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>   arg: a8740000 88002000 88001fe0 18
>   tmp: a8740000 2 8880e0b4 8360020 8880e0b0 887fe53c 887fe234 9fc55064
>   sve: a8740000 3 400000 8000000 16 3f80 0 10000000
>   t8 a8740000 t9 ffffffff at ffffffff v0 ffffffff v1 ffffffff k1 8360020
>   gp a8740000 f0 ffffffff sp ffffffff ra ffffffff
>=20
> PANIC: Unexpected exception

This should be a crash in free_bootmem_core because of the non correct
spaces.h

> I can't rule out it being something with my config though.  Has someone
> got a working config for mips64 on this class of machine?  (even a
> binary)  Seeing as it works on R5k, could we be dealing with an R4x00
> bug here?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBVE7uUaz2rXW+gJcRAmQMAJ0fgz/GEM2DvOUtELNsgPWGoqGQGACbBUNt
ynfqv3d8WbZrt/pLjFv+E1U=
=a9fu
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
