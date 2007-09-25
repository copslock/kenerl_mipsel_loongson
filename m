Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 22:54:01 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:40602 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20023088AbXIYVxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 22:53:52 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 8BBFF8E67AC;
	Tue, 25 Sep 2007 23:53:14 +0200 (CEST)
Received: from [192.168.0.3] (fbx.alphacore.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 58902D0E315;
	Tue, 25 Sep 2007 23:53:14 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] Au1000 : fix PCI controller registration
Date:	Tue, 25 Sep 2007 23:54:12 +0200
User-Agent: KMail/1.9.7
Cc:	linux-mips@linux-mips.org, blogic@openwrt.org, nbd@openwrt.org
References: <200709251707.29067.florian.fainelli@telecomint.eu> <200709251917.15431.florian.fainelli@telecomint.eu> <20070925171823.GA11640@linux-mips.org>
In-Reply-To: <20070925171823.GA11640@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1197078.JygzaHWGth";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709252354.15365.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart1197078.JygzaHWGth
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mardi 25 septembre 2007, Ralf Baechle a =E9crit=A0:
> On Tue, Sep 25, 2007 at 07:17:10PM +0200, Florian Fainelli wrote:
> > > >  #define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
> > > > -#define IOPORT_RESOURCE_END   0xffffffff
> > > > +#define IOPORT_RESOURCE_END   0xfffffffffULL
> > >
> > > So you're saying that PCI has just under 64GB worth of ioport address
> > > space on Alchemy?  That's not how I recall my PCI spec ...
> >
> > Errm, no, actually, Alchemy has a 36bits PCI adressing mode if I recall
> > right.
>
> Nope.  IOspace is max. 4GB with PCI, even on 64-bit PCI.

Talking with John Crispin, the MTX-1 really needs this 64Gb IO space thing,=
=20
otherwise it does not work and the PCI controller still does not register. =
We=20
are preparing a real fix for this.

>
>   Ralf



=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart1197078.JygzaHWGth
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG+YOHmx9n1G/316sRAlmIAKCg8wllv/8kbXJrKJ9R0sBMFQ0yKwCfehFy
ZF2WwqjW1NlS4hB5jiQdP+o=
=ITiB
-----END PGP SIGNATURE-----

--nextPart1197078.JygzaHWGth--
