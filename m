Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 18:51:44 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:48348 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20025406AbYADSvf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2008 18:51:35 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id B35B432DED; Fri,  4 Jan 2008 19:51:30 +0100 (CET)
Date:	Fri, 4 Jan 2008 19:51:30 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080104185130.GB6532@paradigm.rfc822.org>
References: <477E6296.7090605@raritan.com> <20080104172136.GD22809@networkno.de> <477E7DAE.2080005@raritan.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <477E7DAE.2080005@raritan.com>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200801041924@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2008 at 01:40:46PM -0500, Gregor Waltz wrote:
> CRC Check passed
> Image Started At Address 0x80020000.
> Image Length =3D 3424394 (0x34408a).
> Exception! EPC=3D80056eb4 CAUSE=3D30000008(TLBL)
> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc

The exception comes from PMON too - Did you look up the EPC in your
System.map file ?

> Further, the exception gets printed immediately after "Image Length =3D=
=20
> 3424394 (0x34408a)." The exception happens so soon that I doubt that the=
=20
> kernel does very much beforehand.

The kernel seems to be initializing and steps upon an virtual address
and triggers an TLB exception which as the kernel is not yet ready
to handle it itself, thus PMONs exception handler gets triggered.

My first guess is that you are catching a NULL Pointer exception
somewhere.

FLo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHfoAyUaz2rXW+gJcRAhrBAJ9Pk9//CkR1xHQOubwX8qihfPGBFACgrByO
aEdaHe0uYrhTIrdnBWeE6iw=
=c3ie
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
