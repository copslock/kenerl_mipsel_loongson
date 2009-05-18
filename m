Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 07:35:52 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:37017 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20022134AbZERGfp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 07:35:45 +0100
Received: (qmail 5271 invoked by uid 508); 18 May 2009 06:35:36 -0000
Received: from 203.83.114.122 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.092429 secs); 18 May 2009 06:35:36 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 18 May 2009 06:35:35 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n4I6ZBqH002334;
	Mon, 18 May 2009 14:35:11 +0800 (CST)
Date:	Mon, 18 May 2009 14:35:11 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [PATCH 01/30] Fix warning: incompatible argument type of
	pci_fixup_irqs
Message-ID: <20090518063510.GA8917@adriano.hkcable.com.hk>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>, loongson-dev@googlegroups.com,
	zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
References: <1242424728.10164.140.camel@falcon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1242424728.10164.140.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05:58 Sat 16 May     , Wu Zhangjin wrote:
> >From 1e6360e89b239699ef1f5344e1d3a5c0b3c5bef1 Mon Sep 17 00:00:00 2001
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> Date: Tue, 12 May 2009 10:33:37 +0800
> Subject: [PATCH 01/30] Fix warning: incompatible argument type of
> pci_fixup_irqs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit

I don't know how you mailed these patches.
But it seems to me that you copy'n'pasted the format-patch'ed patch into the
text editor of your mailer.

If this is the case, please don't do this. Please use 'git send-email'.

Otherwise, please ignore this mail and I am sorry for the noise.

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoRAZ4ACgkQvFHICB5OKXM/HgCfb0knyDvHLUhK63QUblT/9Ub6
EqgAnicKn1tcrc5jrMVgBSPXKRfkqKrZ
=L/XC
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
