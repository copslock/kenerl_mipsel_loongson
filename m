Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 16:23:47 +0100 (WEST)
Received: from apollo.i-cable.com ([203.83.115.103]:51564 "HELO
	apollo.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20023382AbZFFPXj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 16:23:39 +0100
Received: (qmail 18535 invoked by uid 508); 6 Jun 2009 15:23:29 -0000
Received: from 203.83.114.122 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.174594 secs); 06 Jun 2009 15:23:29 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 6 Jun 2009 15:23:28 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n56FNKL4002329;
	Sat, 6 Jun 2009 23:23:20 +0800 (CST)
Date:	Sat, 6 Jun 2009 23:23:16 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Yan Hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Pavel Machek <pavel@ucw.cz>, Wu Zhangjin <wuzj@lemote.com>,
	Hu Hongbing <huhb@lemote.com>
Subject: Re: [PATCH-v2] Hibernation Support in mips system
Message-ID: <20090606152315.GA16785@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Yan Hua <yanh@lemote.com>,
	Zhang Fuxin <zhangfx@lemote.com>, Pavel Machek <pavel@ucw.cz>,
	Wu Zhangjin <wuzj@lemote.com>, Hu Hongbing <huhb@lemote.com>
References: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20:27 Thu 04 Jun     , wuzhangjin@gmail.com wrote:

[snip]

> +++ b/arch/mips/power/cpu.c
> @@ -0,0 +1,43 @@
> +/*
> + * Suspend support specific for mips.

Sorry for nitpicking, but here "specific" could be omitted.

> + *
> + * Distribute under GPLv2

Distributed

=2E..
[snip]
=2E..

> +++ b/arch/mips/power/hibernate.S
> @@ -0,0 +1,70 @@
> +/*
> + * Hibernation support specific for mips - temporary page tables

Same here

> + *
> + * Distribute under GPLv2

And here

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoqieMACgkQvFHICB5OKXO7lQCdG0BnAB7NlZz6SoJkjJe6iFYb
/4AAn2hgZw2cUdiSFXT5+ENOgw0aAeiL
=GCgw
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
