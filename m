Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KAVIS07964
	for linux-mips-outgoing; Wed, 20 Feb 2002 02:31:18 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KAV5907929
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 02:31:05 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1C0BE883; Wed, 20 Feb 2002 10:30:41 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 838821A23B; Wed, 20 Feb 2002 10:30:12 +0100 (CET)
Date: Wed, 20 Feb 2002 10:30:12 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220093012.GF11654@paradigm.rfc822.org>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <15475.24039.877276.257999@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <15475.24039.877276.257999@gladsmuir.algor.co.uk>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2002 at 08:27:19AM +0000, Dominic Sweetman wrote:
> It may be heretical... but the lazy FPU context switch was invented
> for 16MHz CPUs using a write-through cache and non-burst memory, where
> saving 16 x 64-bit registers took 6us or so (and quite a bit less,
> later, to read them back).  Call it 8us.

We are still running on good ol Decstations *snief* Going the way to
make it SMP only like others archs seem to do it would be good.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8c2ykUaz2rXW+gJcRAtT+AJ40ZITjrI5zafu+ckPVIRKwLT4UWACeJCfS
pak03BnkPcyMuxk5LWtM52s=
=h2CX
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
