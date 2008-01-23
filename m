Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2008 09:53:25 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:23015 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20030859AbYAWJxR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jan 2008 09:53:17 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 143DB32DFF; Wed, 23 Jan 2008 10:51:13 +0100 (CET)
Date:	Wed, 23 Jan 2008 10:51:13 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	gigo@poczta.ibb.waw.pl
Cc:	linux-mips@linux-mips.org
Subject: Re: Old Indy, 64-bit setup
Message-ID: <20080123095113.GA30081@paradigm.rfc822.org>
References: <Pine.LNX.4.64.0801222106460.31014@poczta.ibb.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801222106460.31014@poczta.ibb.waw.pl>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200801230916@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2008 at 10:10:37PM +0100, gigo@poczta.ibb.waw.pl wrote:
>  Hello,
> Just a silly question. Is there any working 64-bit kernel configuration=
=20
> for my r4k 100MHz Indy? From time to time i compile another new kernel fo=
r=20
> 64-bit... and see the thing dying. Recently it looked pretty well like=20
> Indy r4k 100MHz (BROTHER!?!?!) crash shown in=20
> http://www.linux-mips.org/archives/linux-mips/2007-11/msg00186.html
> Everything but the kernel is debian stable: binutils 2.17
> gcc 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)...

There are CPU Bug workarounds needed which are not yet complete in
kernel and gcc. I am running my 100Mhz Indy with an 32Bit Kernel built
=66rom the debian source package just by replacing the 64BIT ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlw4RUaz2rXW+gJcRAkTbAJ9BdVfp/iU/SbyfkQfYJhe6x7CusACfSPpC
yNcH4TH0Nkv9WnOAYaKMdcc=
=I18C
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
