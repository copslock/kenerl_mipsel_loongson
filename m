Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 18:52:17 +0100 (WEST)
Received: from crux.i-cable.com ([203.83.115.104]:45466 "HELO crux.i-cable.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023907AbZFIRwD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jun 2009 18:52:03 +0100
Received: (qmail 18590 invoked by uid 107); 9 Jun 2009 17:51:50 -0000
Received: from 203.83.114.122 by crux (envelope-from <robert.zhangle@gmail.com>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.94.2/9149. spamassassin: 2.63.   
 Clear:RC:1(203.83.114.122):SA:0(2.6/5.0):. 
 Processed in 8.35331 secs); 09 Jun 2009 17:51:50 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 9 Jun 2009 17:51:42 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n59Hpei2029077;
	Wed, 10 Jun 2009 01:51:40 +0800 (CST)
Date:	Wed, 10 Jun 2009 01:51:31 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: Re: [loongson-PATCH-v3 10/25] split the loongson-specific part out
Message-ID: <20090609175130.GC1287@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
References: <cover.1244120575.git.wuzj@lemote.com> <cc26466a1817a94314d8e118dfcbe38d55190d62.1244120575.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <cc26466a1817a94314d8e118dfcbe38d55190d62.1244120575.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:05 Thu 04 Jun     , wuzhangjin@gmail.com wrote:

[...]

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig

[...]

Two cosmetic change suggestions:

> +config LOONGSON_SYSTEMS

To keep it in line with other CPU's, I suggest change LOONGSON_SYSTEMS to
MACH_LOONGSON. This is really a matter of taste. So take it at your own
discretion. And don't forget change all occurrences of CONFIG_LOONGSON_SYST=
EMS
to CONFIG_MACH_LOONGSON, too.

> +	bool "Loongson Based Machines"

There is no need to use capital letter in based and machines here.

Thanks!

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkouoSIACgkQvFHICB5OKXNADQCdGMZNLI9Yq7dgSSaCfoZy4WZy
nYIAniw2l3yxQhxvIpafHcNx4flmgPIO
=MWc0
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
