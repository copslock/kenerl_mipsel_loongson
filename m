Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2006 22:40:35 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:17848 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S20039086AbWLNWka (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Dec 2006 22:40:30 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11.20060308/8.12.11) with ESMTP id kBEMckk9029026;
	Thu, 14 Dec 2006 17:40:31 -0500
Received: from authsmtp1.cc.vt.edu (auth.smtp.vt.edu [198.82.161.56])
	by vivi.cc.vt.edu (MOS 3.8.2-GA)
	with ESMTP id GQW41692;
	Thu, 14 Dec 2006 17:40:22 -0500 (EST)
Received: from gs4073.geos.vt.edu (gs4073.geos.vt.edu [128.173.184.73])
	(authenticated bits=0)
	by authsmtp1.cc.vt.edu (8.13.1/8.13.1) with ESMTP id kBEMeL2d025869;
	Thu, 14 Dec 2006 17:40:22 -0500
Date:	Thu, 14 Dec 2006 17:39:35 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Jens Seidel <jensseidel@users.sourceforge.net>
Subject: Re: SGI Octane kernel patches fail
Message-ID: <20061214173935.485faba6@gs4073.geos.vt.edu>
In-Reply-To: <20061214203535.GA18511@pluto>
References: <20061214203535.GA18511@pluto>
Organization: Gentoo Linux
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; i686-pc-linux-gnu)
X-Face:	SZkgO{p^G't0]8U]p8b=DtT,_0Hz?S)hKCI\sEHZRAdrYo?=`'CDw8uu-Mpo(x;@%XjW]VR
 euvbMM4Iixr>@Wxy?~f]4@1uGNlXGT0!AC[b{1R>:@]U~bPf8(Jcg8C&H}<7dM!Q2p/C\tw4vUb{he
 PZ&oWm&Pr#hRGa*=ReoPd,mbd_X/-yCj\-Ya{7j7Dkg)5bA&1!c,~8V/7lBGlF?6;fBJ):7sjgT0\=
 Jre""/n'zX=E==KMA{k&pBLm,c*Y0
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_oiST9PxXCNTLbVGhB8ro.zw;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Junkmail-Status: score=10/50, host=vivi.cc.vt.edu
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090207.4581D197.00A1:SCCEO16322,ss=1,fgs=0,
	ip=198.82.161.56,
	so=2006-09-22 03:48:54,
	dmn=5.2.121/2006-09-27
X-Mirapoint-RAPID-Raw: score=unknown(0),
	refid=str=0001.0A090207.4581D197.00A1:SCCEO16322,ss=1,fgs=0,
	ip=198.82.161.56,
	so=2006-09-22 03:48:54,
	dmn=5.2.121/2006-09-27
X-Mirapoint-Loop-Id: f8a8173ab3592955c342fb77a2fd2cd6
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

--Sig_oiST9PxXCNTLbVGhB8ro.zw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2006 21:35:35 +0100
Jens Seidel <jensseidel@users.sf.net> wrote:

> Hi,
>=20
> I have a SGI Octane IP30 and was able to boot Linux on it with the
> ip30-r10k+-20050128.img Gentoo kernel. Nevertheless I noticed that
> this kernel is very unstable.

Yes, that kernel is ancient and known to be totally broken.  Try
http://dev.gentoo.org/~kumba/mips/netboot/testing/ip30-r10k+-20060112.img.b=
z2
instead.

-Steve

--Sig_oiST9PxXCNTLbVGhB8ro.zw
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFgdKsHyvOE7OTyFYRAlidAJ4n0glAGH6xSd0yjQn3gF9UiBwA0wCghv5u
91tIqH1vVHpIZMrDk+VcjKU=
=5tAM
-----END PGP SIGNATURE-----

--Sig_oiST9PxXCNTLbVGhB8ro.zw--
