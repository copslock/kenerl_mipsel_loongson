Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 09:42:25 +0100 (BST)
Received: from shawidc-mo1.cg.shawcable.net ([IPv6:::ffff:24.71.223.10]:59128
	"EHLO pd4mo2so.prod.shaw.ca") by linux-mips.org with ESMTP
	id <S8226005AbVCaImK>; Thu, 31 Mar 2005 09:42:10 +0100
Received: from pd2mr7so.prod.shaw.ca (pd2mr7so-qfe3.prod.shaw.ca [10.0.141.10])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IE700HH0K67GQHI@l-daemon> for linux-mips@linux-mips.org; Thu,
 31 Mar 2005 01:42:07 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd2mr7so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IE700EMIK6750A0@pd2mr7so.prod.shaw.ca> for
 linux-mips@linux-mips.org; Thu, 31 Mar 2005 01:42:07 -0700 (MST)
Received: from curie.orbis-terrarum.net
 (S01060050da688d47.vc.shawcable.net [24.80.100.253])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0IE700B24K67Q6@l-daemon> for linux-mips@linux-mips.org; Thu,
 31 Mar 2005 01:42:07 -0700 (MST)
Received: (qmail 10008 invoked by uid 10000); Thu, 31 Mar 2005 00:42:07 -0800
Date:	Thu, 31 Mar 2005 00:42:07 -0800
From:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: Compressed Kernels
In-reply-to: <1112258126.28438.16.camel@localhost.localdomain>
To:	linux-mips <linux-mips@linux-mips.org>
Mail-followup-to: linux-mips <linux-mips@linux-mips.org>
Message-id: <20050331084207.GA8346@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=C7zPtVaVf+AK4Oqc;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
References: <1112258126.28438.16.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@orbis-terrarum.net
Precedence: bulk
X-list: linux-mips


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2005 at 09:35:26AM +0100, JP Foster wrote:
> I've noticed that mips doesn't have a compressed kernel option,
> so I had added support (ripped shamelessly from arch/i386) for it
> to save space on our flash chips.
>=20
> It works fine for my db1550 and also our product boards.
> The patch is pretty messy but if there was interest in it I could clean
> it up. Is there any historical reason for it not being included?
Pete Popov was already working some zImage code.

His link for it:
ftp://ftp.linux-mips.org/pub/linux/mips/people/ppopov/2.6/zImage_2_6_10.pat=
ch

It worked for me in January on an XXS1500 device, but I haven't tried it
on any newer kernel since then.

I don't know the current status of it, or if it is going to go into the
main codebase at all.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFCS7ffPpIsIjIzwiwRAjrHAJ9jE5iWhVYTGnBaM4LHFZJEF6U06wCfVWrb
NOVhnzkK2irvo/GC3c6OfQM=
=1PQv
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
