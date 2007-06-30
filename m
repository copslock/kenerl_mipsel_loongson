Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2007 17:56:08 +0100 (BST)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:7123 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20021960AbXF3Q4G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 30 Jun 2007 17:56:06 +0100
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 3C015D0E315;
	Sat, 30 Jun 2007 18:55:30 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: Unhandled kernel unaligned access debugging
Date:	Sat, 30 Jun 2007 18:53:59 +0200
User-Agent: KMail/1.9.7
Cc:	michael@frogfoot.com, linux-mips@linux-mips.org
References: <20070629163951.GG5929@marmite.frogfoot.net> <20070701.014454.126142904.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070701.014454.126142904.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12075449.Hm0HrBcBbM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200706301854.01564.florian.fainelli@telecomint.eu>
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart12075449.Hm0HrBcBbM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Michael,

The OpenWrt kernel is based on the mainline kernel plus some other patches =
we=20
maintain for memory footprint or features.=20

I suggets you disable mini_fo in the kernel configuration because it was=20
responsible for some memory corruption.

You could also have reported the bug to our bug tracking system at=20
https://dev.openwrt.org. You will see that there a lot of other people tryi=
ng=20
to get AR7 work (better ?).

Best regards, Florian

Le samedi 30 juin 2007, Atsushi Nemoto a =E9crit=A0:
> On Fri, 29 Jun 2007 18:39:51 +0200, Michael Wood <michael@frogfoot.com>=20
wrote:
> > I think understand more or less what this means, but am unsure of how to
> > debug it.  I think OpenWRT is using the vanilla kernel, but maybe I'm
> > missing something.  Is this because I'm not using the kernel from
> > linux-mips.org?
>
> It is not vanilla kernel.  squashfs is not merged mainline yet.
>
> > Unhandled kernel unaligned access[#1]:
> > Cpu 0
> > $ 0   : 00000000 10008400 69725020 94001b90
> > $ 4   : 94003200 7265746e 00000002 00000000
> > $ 8   : 94016338 940162b0 94016228 940161a0
> > $12   : 94e5653c 943a0000 943a0000 94e5659c
> > $16   : 94001b80 00000000 94003200 00000002
> > $20   : 00000000 00000000 00000000 00000000
> > $24   : 00000000 9410b8a0
> > $28   : 943e4000 943e5ec0 00000000 94175e40
> > Hi    : 00000003
> > Lo    : 00000002
> > epc   : 941742bc drain_freelist+0x6c/0xf8     Not tainted
> > ra    : 94175e40 cache_reap+0xc0/0x124
> > Status: 10008402    KERNEL EXL
> > Cause : 10800010
> > BadVA : 7265746e
> > PrId  : 00018448
>
> ...
>
> > 0xffffffff941742bc <drain_freelist+108>:        lw      v1,0(a1)
>
> The value of a1 (0x7265746e) is not a kernel address and I do not
> think drain_freelist use such an address.  So it would not be an
> "unaligned access" problem.  I support it would be some sort of memory
> corruption.
>
> ---
> Atsushi Nemoto



=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------

--nextPart12075449.Hm0HrBcBbM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGhoqpmx9n1G/316sRAsI0AJ0X+UdUaL+n6Xh794r3/UYSzCkeXwCgxe3R
ruKipj+cR3mZbGxVTcBk9ck=
=tlHN
-----END PGP SIGNATURE-----

--nextPart12075449.Hm0HrBcBbM--
