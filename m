Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2003 17:48:40 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:36283
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225361AbTHaQsH>; Sun, 31 Aug 2003 17:48:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 5AD8F2BC3C; Sun, 31 Aug 2003 18:48:05 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 25499-09;
 Sun, 31 Aug 2003 18:48:03 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb5586.pool.mediaWays.net [217.187.85.134])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 561962BC39; Sun, 31 Aug 2003 18:48:03 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 1E0E34099; Sun, 31 Aug 2003 18:48:12 +0200 (CEST)
Date: Sun, 31 Aug 2003 18:48:12 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix sigevent_t stuff
Message-ID: <20030831164812.GB766@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ulrich Drepper <drepper@redhat.com>, linux-mips@linux-mips.org
References: <20030831145854.GB23189@linux-mips.org> <20030831161217.GA10286@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20030831161217.GA10286@linux-mips.org>
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ralf,
On Sun, Aug 31, 2003 at 06:12:17PM +0200, Ralf Baechle wrote:
> On Sun, Aug 31, 2003 at 04:58:54PM +0200, Ralf Baechle wrote:
>=20
> > below patch fixes a mismatch between glibc and the kernel header's
> > definition on MIPS.  Please apply.
>=20
> Please ignore this patch.  Digging through the history of the missmatch
> I came to the conclusion that this fix isn't the right one; I'll send
> an updated patch.
Could you please post these patches to libc-alpha in the future?  Only
very few people will see patches on libc-hacker since subscription is
restricted.
Regards,
 -- Guido

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/UibLn88szT8+ZCYRAqcCAJ9DCwVXYRJSRWENR4Ipdq+z+SNlcgCfZNOY
ibkbAI6yhM32rn2U/kxiWgg=
=+A8f
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
