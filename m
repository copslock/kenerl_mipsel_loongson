Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 18:16:57 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:25235 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20023321AbXIYRQz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 18:16:55 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 9E98E8E6148;
	Tue, 25 Sep 2007 19:16:15 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 98CCED0E315;
	Tue, 25 Sep 2007 19:16:15 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] Au1000 : fix PCI controller registration
Date:	Tue, 25 Sep 2007 19:17:10 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org, blogic@openwrt.org, nbd@openwrt.org
References: <200709251707.29067.florian.fainelli@telecomint.eu> <20070925171119.GA11350@linux-mips.org>
In-Reply-To: <20070925171119.GA11350@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8105405.dnaVJnAcN7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709251917.15431.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart8105405.dnaVJnAcN7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mardi 25 septembre 2007, Ralf Baechle a =E9crit=A0:
> On Tue, Sep 25, 2007 at 05:07:28PM +0200, Florian Fainelli wrote:
> > diff --git a/include/asm-mips/mach-au1x00/au1000.h
> > b/include/asm-mips/mach-au1x00/au1000.h index 58fca8a..046920a 100644
> > --- a/include/asm-mips/mach-au1x00/au1000.h
> > +++ b/include/asm-mips/mach-au1x00/au1000.h
> > @@ -1680,9 +1680,9 @@ extern au1xxx_irq_map_t au1xxx_irq_map[];
> >  #define PCI_LAST_DEVFN  (19<<3)
> >
> >  #define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
> > -#define IOPORT_RESOURCE_END   0xffffffff
> > +#define IOPORT_RESOURCE_END   0xfffffffffULL
>
> So you're saying that PCI has just under 64GB worth of ioport address spa=
ce
> on Alchemy?  That's not how I recall my PCI spec ...

Errm, no, actually, Alchemy has a 36bits PCI adressing mode if I recall rig=
ht.

>
>   Ralf



=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart8105405.dnaVJnAcN7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG+UKbmx9n1G/316sRAjJ9AKCMUhBHgxduqcSnoz5gdkiiJJESiwCg2pjB
Z9+svowVK6d3p4aZgucMqew=
=SVVy
-----END PGP SIGNATURE-----

--nextPart8105405.dnaVJnAcN7--
