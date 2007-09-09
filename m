Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2007 19:28:20 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:3525 "EHLO smtp1.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S20022033AbXIIS2L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Sep 2007 19:28:11 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 064958E603C;
	Sun,  9 Sep 2007 20:27:29 +0200 (CEST)
Received: from [192.168.1.101] (fbx.hooligan0.net [82.67.141.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id D0659D0E315;
	Sun,  9 Sep 2007 20:27:28 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Date:	Sun, 9 Sep 2007 20:27:29 +0200
User-Agent: KMail/1.9.7
Cc:	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
References: <200708201704.11529.technoboy85@gmail.com> <20070909084752.GB2654@infomag.infomag.iguana.be> <200709092019.43471.technoboy85@gmail.com>
In-Reply-To: <200709092019.43471.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3546548.T39a3UZ9V3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709092027.32119.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-2.485, requis 4.01,
	autolearn=not spam, AWL 0.11, BAYES_00 -2.60)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart3546548.T39a3UZ9V3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

The thing is that the different TNETD versions : 7100, 7200 and 7300 should=
=20
not have the same watchdog handling.

Right now, we have no easy way to figure out what is different from one=20
version to another.

Le dimanche 9 septembre 2007, Matteo Croce a =E9crit=A0:
> Il Sunday 09 September 2007 10:47:52 hai scritto:
> > Hi Matteo,
> >
> > > Driver for the watchdog timer. It worked with 2.4, doesn't does with
> > > 2.6. Apart that it doesn't reboots the device it works :)
> >
> > Can you please explain this a bit more? Is this driver working under 2.4
> > (and also rebooting the device) but not under 2.6?
>
> Exactly.
> A guy had it working with the attached patch but it doesn't works for me.
>
> Cheers,
> Matteo
=2D-=20
Cordialement, Florian Fainelli
=2D-----------------------------

--nextPart3546548.T39a3UZ9V3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.6 (GNU/Linux)

iD8DBQBG5DsUmx9n1G/316sRAkbNAKDQBCDdDi0YmsL91QFac3u7zicmcQCeKyQa
WNIji9y6o+ctX8vI/SCDuro=
=bzOy
-----END PGP SIGNATURE-----

--nextPart3546548.T39a3UZ9V3--
