Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2005 09:35:11 +0100 (BST)
Received: from tirpitz.iat.sfu.ca ([IPv6:::ffff:209.87.56.17]:5836 "EHLO
	tirpitz.iat.sfu.ca") by linux-mips.org with ESMTP
	id <S8225074AbVGUIex>; Thu, 21 Jul 2005 09:34:53 +0100
Received: (qmail 2443 invoked from network); 21 Jul 2005 01:36:42 -0700
Received: from s01060050da688d47.vc.shawcable.net (HELO curie.orbis-terrarum.net) (24.80.100.253)
  by tirpitz.iat.sfu.ca with SMTP; 21 Jul 2005 01:36:42 -0700
Received: (qmail 28628 invoked by uid 10000); 21 Jul 2005 01:36:40 -0700
Date:	Thu, 21 Jul 2005 01:36:40 -0700
From:	"Robin H. Johnson" <robbat2@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	rolf liu <rolfliu@gmail.com>
Subject: Re: Is there some work done on db1550 for the security engine?
Message-ID: <20050721083640.GA26677@curie-int.orbis-terrarum.net>
Mail-Followup-To: linux-mips@linux-mips.org, rolf liu <rolfliu@gmail.com>
References: <2db32b720507201012712e5cd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <2db32b720507201012712e5cd1@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Return-Path: <robbat2@orbis-terrarum.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robbat2@gentoo.org
Precedence: bulk
X-list: linux-mips


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2005 at 10:12:04AM -0700, rolf liu wrote:
> Is there any driver availble to use the security engine inside au1550?
Not in the tree, or that I've seen floating around yet. Pete might know
if there is one available somewhere else.

Failing that, (and this is an idea I've been toying with for a while)
why not strike a deal with somebody here to write it for you: you can
provide the hardware, and they can write it, for some reasonable
compensation.

Lack of hardware to test on is probably the biggest stumbling block to
supporting it presently.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFC316YPpIsIjIzwiwRApC6AJ4ggH8LGVH/sNOzVJatPa2YYeu13gCfaOkl
Fq9xkNiORrC85hSuoQtUAh8=
=CJI+
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
