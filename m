Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 01:17:09 +0000 (GMT)
Received: from shawidc-mo1.cg.shawcable.net ([IPv6:::ffff:24.71.223.10]:21829
	"EHLO pd2mo3so.prod.shaw.ca") by linux-mips.org with ESMTP
	id <S8225325AbVBBBQy>; Wed, 2 Feb 2005 01:16:54 +0000
Received: from pd5mr5so.prod.shaw.ca
 (pd5mr5so-qfe3.prod.shaw.ca [10.0.141.181]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IB9000J2FJIKTA0@l-daemon> for linux-mips@linux-mips.org; Tue,
 01 Feb 2005 18:16:30 -0700 (MST)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
 by pd5mr5so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IB9007AZFJIHSE0@pd5mr5so.prod.shaw.ca> for
 linux-mips@linux-mips.org; Tue, 01 Feb 2005 18:16:30 -0700 (MST)
Received: from curie.orbis-terrarum.net
 (S01060050da688d47.vc.shawcable.net [24.80.100.253])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0IB900C0DFJHFA@l-daemon> for linux-mips@linux-mips.org; Tue,
 01 Feb 2005 18:16:30 -0700 (MST)
Received: (qmail 17359 invoked by uid 10000); Tue, 01 Feb 2005 17:16:14 -0800
Date:	Tue, 01 Feb 2005 17:16:14 -0800
From:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
In-reply-to: <1107304567.2912.34.camel@SillyPuddy.localdomain>
To:	linux-mips@linux-mips.org
Mail-followup-to: linux-mips@linux-mips.org
Message-id: <20050202011614.GA31554@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=IJpNTDwzlM2Ie8A6;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
User-Agent: Mutt/1.5.6i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@orbis-terrarum.net
Precedence: bulk
X-list: linux-mips


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2005 at 04:36:07PM -0800, Josh Green wrote:
> I'm using the latest Linux MIPS CVS (2.6.11-rc2) on an AMD Alchemy
> DB1100 with a tool chain created with buildroot (gcc 3.4.3, binutils
> 2.15.91.0.2) and found a bug in drivers/pcmcia/au1000_generic.c that
> was causing the following error during initialization (not exact text,
> close as I can remember), and subsequently the PCMCIA hardware was
> unavailable (pcmcia_register_socket() was failing due to NULL
> resource_opts field).
>=20
> au1x00_pcmcia: probe of au1x00-pcmcia0 failed with error -22
I can confirm this. I thought it was my error in trying to implement
PCMCIA for the XXS1500 board.
A fuller log available here:
http://dev.gentoo.org/~robbat2/xxs1500/linux-xxs1500-20050130.4.status

The preliminary patch that status report refers to is:
http://dev.gentoo.org/~robbat2/xxs1500/linux-xxs1500-20050130.4.gz
(not ready for any merging yet, still contains extra debug code)

> The other problem I've experienced is a kernel oops when ejecting a
> card.  While it isn't a problem for my project (should never be
> inserting/ejecting cards) I thought I'd mention it.  Here is the oops
> output, I wasn't able to use ksymoops since I'm having trouble
> building a cross compiled version (buildroot didn't install libbfd,
> etc from binutils), so this may or may not be useful:
For your ksymoops, i find it very useful to build my host binutils (not
the cross-compiler chain) with '--enable-targets=3Dall' as then it's
possible to use your regular ksymoops (as of 2.4.10, see the INSTALL
document for more details, I wrote up 'Building ksymoops for
cross-debugging only' section ;-) without having to jump thru hoops for
a cross-ksymoops.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFCACnePpIsIjIzwiwRAqo1AJ9cDE2CBby7LgDk57tfNvGK2nJhTQCfTnB3
4Jdys48gxs2x99QXqhi+KUE=
=0/jm
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
