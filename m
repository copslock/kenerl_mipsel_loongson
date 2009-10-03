Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Oct 2009 12:22:38 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45113 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492313AbZJCKWc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Oct 2009 12:22:32 +0200
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>)
	id 1Mu1ku-0000Jr-6J; Sat, 03 Oct 2009 12:22:24 +0200
Received: from wsa by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <wsa@pengutronix.de>)
	id 1Mu1kr-0000Jk-JT; Sat, 03 Oct 2009 12:22:21 +0200
Date:	Sat, 3 Oct 2009 12:22:21 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
Message-ID: <20091003102221.GB24206@pengutronix.de>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com> <20091002105903.GC3179@pengutronix.de> <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com> <20091002125423.GD3179@pengutronix.de> <f861ec6f0910020732p2ff76990q1e7a2bca16e52e64@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <f861ec6f0910020732p2ff76990q1e7a2bca16e52e64@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: wsa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <wsa@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Yeah, I saw that you want to remove it, still I don't know why :) Is it=
 feature
> > incomplete and updating is impossible? Is the concept outdated? Could y=
ou
> > enlighten me on that?
>=20
> I started out with the intention to fix its styling issues, add carddetec=
t irq
> support, etc.  In the end it was easier to write a quick-and-dirty standa=
lone
> full-features socket driver for the DB1200 and extend it to support the
> other DB/PB boards. While I was at it I modified my driver for the xxs150=
0,
> that's all.

Okay, that explains.

>=20
> The only *technical* reason I have is a personal dislike for how the curr=
ent
> one works: it forces every conceivable board to add dozens of cpp macros
> for mem/io ranges and gets registered by board-independent code.
> Hardly convincing, I know.

Well, you have the (to me) pretty convincing technical argument that your
drivers provide more features and less crashes which is a clear benefit for
users. If we remove the generic au1000-part, then it might even be in the s=
ame
amount in LoC. Okay, we lose a bit of maintainability if a bug is found in a
section which was shared among the former users of generic, as it has to be
updated for each of the three drivers, but well... Are there any plans to
convert pb1x00 as well?

Maybe I find time to look a bit more into it, but I can't test anything, of
course, so the more additional comments/test-reports the better.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrHJd0ACgkQD27XaX1/VRtIlACcDbnPsEWZ4WTlEqP+ow7aoPC9
MxkAniEmjtjOYTdVkajO7oaZ78g+8M4t
=87Vf
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
