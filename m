Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 22:21:14 +0100 (BST)
Received: from shawidc-mo1.cg.shawcable.net ([IPv6:::ffff:24.71.223.10]:18141
	"EHLO pd3mo1so.prod.shaw.ca") by linux-mips.org with ESMTP
	id <S8225004AbUIHVVK>; Wed, 8 Sep 2004 22:21:10 +0100
Received: from pd2mr4so.prod.shaw.ca
 (pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0I3Q00A1MR54NO30@l-daemon> for linux-mips@linux-mips.org; Wed,
 08 Sep 2004 15:17:28 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
 by pd2mr4so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0I3Q00ISRR54CRC0@pd2mr4so.prod.shaw.ca> for
 linux-mips@linux-mips.org; Wed, 08 Sep 2004 15:17:28 -0600 (MDT)
Received: from curie.orbis-terrarum.net
 (S01060050da688d47.vc.shawcable.net [24.80.109.92])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0I3Q00C2XR54DS@l-daemon> for linux-mips@linux-mips.org; Wed,
 08 Sep 2004 15:17:28 -0600 (MDT)
Received: (qmail 14694 invoked by uid 10000); Wed, 08 Sep 2004 14:17:28 -0700
Date: Wed, 08 Sep 2004 14:17:28 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: SGI O2 Prom modification
In-reply-to: <413E9CB0.9020703@optusnet.com.au>
To: Glenn Barry <glennrbarry@optusnet.com.au>
Cc: linux-mips@linux-mips.org
Mail-followup-to: Glenn Barry <glennrbarry@optusnet.com.au>,
 linux-mips@linux-mips.org
Message-id: <20040908211728.GB3955@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=JWEK1jqKZ6MHAcjA;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
References: <413E84E2.4060401@optusnet.com.au> <413E9931.8060605@gentoo.org>
 <413E9CB0.9020703@optusnet.com.au>
User-Agent: Mutt/1.5.6i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@gentoo.org
Precedence: bulk
X-list: linux-mips


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 08, 2004 at 03:46:24PM +1000, Glenn Barry wrote:
> >AFAIK, this ability isn't too supported anymore.  The guy doing this=20
> >has apparently decided to quit.  While I'm sure this doesn't make such=
=20
> >modifications impossible, it likely makes them more difficult and more=
=20
> >expensive.
> This modification is currently being done with RM5200 boards and=20
> replacing the CPU. You can read more about it at=20
> http://forums.nekochan.net/viewtopic.php?t=3D1071
>=20
> The RM7000C @ 600MHx chip currently works fine in IRIX, sorry I should=20
> have specified that this isn't specifically related to Linux, I just=20
> thought that you people would have the best knnowledge of the SGI's=20
> outside SGI themselves, given that you've been able to port Linux to=20
> some of their machines.
Kumba and I do know all about the RM7000C work, as we are frequent
visitors to nekochan.

What Kumba was referring to what the mid-August post by ChicagoJoe (on
page 14) stating that the company that had been doing the BGA chip
replacement is not taking on any more work.

> >This would quite likely require direct access to the source code of=20
> >the IP32 PROM.  I think only IRIX developers have this access, and=20
> >there are likely license issues that would get in the way of modifying=
=20
> >such code to allow for detection of the RM7900
> Hmmm...given that the O2 line is discontinued I wonder if SGI would=20
> really object to having the code modified.
To get the PROM source, you'd really have to be in bed with SGI, as many
other folk from here have asked for a lot less and had no success.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFBP3boPpIsIjIzwiwRAjs9AJ4lp+k4D6BGVFC6KjtNBqiUQPCKmwCgoFty
gCwQCkhrbcOKRPIW01HVEtM=
=vmLt
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
