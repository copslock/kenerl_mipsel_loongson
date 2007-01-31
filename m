Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 22:03:07 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:18635 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20038806AbXAaWDC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Jan 2007 22:03:02 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 238F7D0E322;
	Wed, 31 Jan 2007 23:00:59 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	"Sergio Aguayo" <sergio@amilda.org>
Subject: Re: Advice needed.
Date:	Wed, 31 Jan 2007 22:59:42 +0100
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org
References: <45C0C956.2050009@wp.pl> <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>
In-Reply-To: <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3243408.YHQuWLMysN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701312302.05473.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart3243408.YHQuWLMysN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello

Le mercredi 31 janvier 2007, Sergio Aguayo a =E9crit=A0:
> Hello
>
> I think you should check my webpage, www.amilda.org. It's a distro for
> other Edimax routers, based on the (also MIPS) ADM5120. While the kernel
> may not be what you need, the rest is quite the same. It may still be
> useful for you.

The board he is talking about is based on a rtl8186 which has few things in=
=20
common with admtek 5120?

>
> Regards,
>
> Sergio Aguayo
>
> > Hello,
> > currently i am "fighting" with Edimax BR-6024Wg, (Realtek-8186 based,
> > lexra-mips). I need an advice from a system developer/programmer:
> >
> > 1). When using original firmware (EDIMAX-developed Linux-mips), task of
> > upgrading firmware is done by web server binary: webs, which is GoAhead
> > 2.1.1, BUT Edimax didn't published "applets" -> C functions, that
> > implement real functionality.

This might be under particular licensing so that it has not been published.=
 By=20
analysing the web uploadable image, you should be able to discover how the=
=20
web image format works. Probably : header, crc check, kernel, rootfs ...

> >
> > 2). In /dev directory there is a block node with mtd name. I have cat'ed
> > it's contents to /web, and downloaded to PC. File seems to be raw
> > contents of Flash memory: 2048*1024bytes long. If I drop first 64kB and
> > truncate file to same length that Edimax-supplied firmware, files show
> > to be the same (using cmp). The first 64kB looks to contain among
> > others, variables used in BR system. There is originally an utility
> > "flash" to get/set variables.

There is probably some kind of nvram on this flash, to store settings. The=
=20
flash utility is probably checking crc on key+variable for instance.

> >
> > Now the question:
> > When I will have a new firmware (image) will it be safe(!?) to do such
> > thing: (instead of using webs binary):
> > cat /dev/mtd > some.file
> > dd first 64k of some.file to other.file,
> > then download image (from PC) to a third.file
> > cat other.file third.file > /dev/mtd back.??????

I think you had better using dd rather than cat, because /dev/mtdblock are=
=20
block devices, and should be treated like that. If your image has a valid=20
format, i.e : the bootloader accepts it, unless you made important=20
modifications to the system code, it should at least be booting.

> >
> > W.Piotrzkowski



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

--nextPart3243408.YHQuWLMysN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFwRHdQ/Yr6D8A81kRAujcAKCX9X3ln5FmE0M0yUx5y0hb4i2lWQCfaPuX
pR4JERcuj2/IW6arVGZdweU=
=zoOH
-----END PGP SIGNATURE-----

--nextPart3243408.YHQuWLMysN--
