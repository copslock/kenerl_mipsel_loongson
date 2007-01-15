Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2007 23:34:12 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:10700 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28577019AbXAOXeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jan 2007 23:34:07 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 49F628D168F;
	Tue, 16 Jan 2007 00:32:54 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Date:	Tue, 16 Jan 2007 00:33:06 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <200701151936.57738.florian.fainelli@int-evry.fr> <20070116074205.0428449d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070116074205.0428449d.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1497024.eRIfmZyur9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701160033.10947.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart1497024.eRIfmZyur9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Yoichi,

I first used the COBALT_LED_PORT address but it did not work for a reason I=
=20
ignore. If I use the COBALT_LED_BASE as defined, which is taken from the Co=
Lo=20
code, it works fine.

Do know you what could explain this difference ? Can you test it on your=20
boxes ?

Thank you very much in advance for your answer.

Le lundi 15 janvier 2007 23:42, Yoichi Yuasa a =E9crit=A0:
> Hi,
>
> On Mon, 15 Jan 2007 19:36:52 +0100
>
> Florian Fainelli <florian.fainelli@int-evry.fr> wrote:
> > Hi all,
> >
> > This patch adds support for controlling the front LED on Cobalt Server.
> > It has been tested on Qube 2 with either no default trigger, or the
> > IDE-activity trigger. Both work fine. Please comment and test !
> >
> > Thanks
> >
> > Florian
> >
> > Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
> >
> > diff -urN linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h
> > linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h
> > --- linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h      =20
> > 2006-12-11 20:32:53.000000000 +0100
> > +++ linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h  =20
> > 2007-01-15 19:29:07.000000000 +0100
> > @@ -97,6 +97,7 @@
> >                 (PCI_FUNC (devfn) << 8) | (where)), GT_PCI0_CFGADDR_OFS)
> >
> >  #define COBALT_LED_PORT                (*(volatile unsigned char *)
> > CKSEG1ADDR(0x1c000000))
> > +#define COBALT_LED_BASE         0xbc000000
>
> You don't need COBALT_LED_BASE.
> Because COBALT_LED_PORT is already defined.
>
> Yoichi

=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------
5, rue Charles Fourier
Chambre 1202
91011 Evry
http://www.alphacore.net
(+33) 01 60 76 64 21
(+33) 06 09 02 64 95
=2D--------------------------------------------
Association MiNET
http://www.minet.net
=2D--------------------------------------------
Institut National des T=E9l=E9communication
http://www.int-evry.fr/telecomint
=2D--------------------------------------------

--nextPart1497024.eRIfmZyur9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFrA82Q/Yr6D8A81kRAhxAAJ95my1K1YPfmBuamzf5Dbfo/IvLWwCfblr8
qyyzyiJG7Ccm+4Zz0YmDgxo=
=JnCd
-----END PGP SIGNATURE-----

--nextPart1497024.eRIfmZyur9--
