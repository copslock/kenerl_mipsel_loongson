Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 06:17:26 +0000 (GMT)
Received: from shawidc-mo1.cg.shawcable.net ([IPv6:::ffff:24.71.223.10]:23893
	"EHLO pd2mo3so.prod.shaw.ca") by linux-mips.org with ESMTP
	id <S8224898AbVBBGRI>; Wed, 2 Feb 2005 06:17:08 +0000
Received: from pd5mr7so.prod.shaw.ca
 (pd5mr7so-qfe3.prod.shaw.ca [10.0.141.183]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IB900JKQTF76X80@l-daemon> for linux-mips@linux-mips.org; Tue,
 01 Feb 2005 23:16:19 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd5mr7so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IB90052XTF7S120@pd5mr7so.prod.shaw.ca> for
 linux-mips@linux-mips.org; Tue, 01 Feb 2005 23:16:19 -0700 (MST)
Received: from curie.orbis-terrarum.net
 (S01060050da688d47.vc.shawcable.net [24.80.100.253])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0IB90000ETF7FV@l-daemon> for linux-mips@linux-mips.org; Tue,
 01 Feb 2005 23:16:19 -0700 (MST)
Received: (qmail 29737 invoked by uid 10000); Tue, 01 Feb 2005 22:16:03 -0800
Date:	Tue, 01 Feb 2005 22:16:03 -0800
From:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
In-reply-to: <1107323435.15057.4.camel@SillyPuddy.localdomain>
To:	linux-mips@linux-mips.org
Cc:	Josh Green <jgreen@users.sourceforge.net>
Mail-followup-to: linux-mips@linux-mips.org,
 Josh Green <jgreen@users.sourceforge.net>
Message-id: <20050202061603.GA21757@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=HlL+5n6rz5pIUxbD;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
 <20050202011614.GA31554@curie-int.orbis-terrarum.net>
 <1107323435.15057.4.camel@SillyPuddy.localdomain>
User-Agent: Mutt/1.5.6i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@orbis-terrarum.net
Precedence: bulk
X-list: linux-mips


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2005 at 09:50:35PM -0800, Josh Green wrote:
> > For your ksymoops, i find it very useful to build my host binutils (not
> > the cross-compiler chain) with '--enable-targets=3Dall' as then it's
> > possible to use your regular ksymoops (as of 2.4.10, see the INSTALL
> > document for more details, I wrote up 'Building ksymoops for
> > cross-debugging only' section ;-) without having to jump thru hoops for
> > a cross-ksymoops.
> Thanks for the tip on ksymoops, I'll give that a shot.  I'm also using
> gentoo, for my host system, would be nice if there was a USE flag to
> enable all targets :)  Cheers.
stick 'multitarget' in your USE flags and re-merge binutils ;-).

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFCAHAjPpIsIjIzwiwRAkODAKDGVxjjxo47k5G6d2IPWHsbp3KKRACg7vvz
MimdS6Yfl5udeWMj+co0Pk0=
=b7At
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
