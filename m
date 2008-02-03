Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 06:30:34 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:17619 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20025424AbYBCGaZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2008 06:30:25 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 7B30B32CFF; Sun,  3 Feb 2008 07:27:11 +0100 (CET)
Date:	Sun, 3 Feb 2008 07:27:11 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080203062711.GA28394@paradigm.rfc822.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20080203021647.GA15910@linux-mips.org>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200802030725@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2008 at 03:16:48AM +0100, Ralf Baechle wrote:
> On Sat, Feb 02, 2008 at 05:08:31PM -0500, Kumba wrote:
>=20
> >=20
> > Thomas Bogendoerfer wrote:
> >> no suprise here. As Ralf already noted cache barrier is a restricted
> >> instruction, it will always cause a illegal instruction when used
> >> in user space. Nevertheless it looks like all IP28 are affected
> >> by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
> >> and this avoids triggering the hang.
> >
> > Ah, didn't know the 'cache' instructions was kernel-mode only.  Explain=
s=20
> > why it survived then :)
> >
> > How does one enable the LLSC war workaround in glibc?
>=20
> By modifying the code ;-)

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D462112

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHpV6/Uaz2rXW+gJcRAjkdAKCEvqw8qVHxGHiWFLK81Ga/y/lJ3ACfe6UN
Ib3l6DMhVfc4kEk7IrOVIsA=
=O6pE
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
