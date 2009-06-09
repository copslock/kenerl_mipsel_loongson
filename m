Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 18:24:00 +0100 (WEST)
Received: from apollo.i-cable.com ([203.83.115.103]:48636 "HELO
	apollo.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20022675AbZFIRXy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Jun 2009 18:23:54 +0100
Received: (qmail 10670 invoked by uid 508); 9 Jun 2009 17:23:45 -0000
Received: from 203.83.114.122 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.190502 secs); 09 Jun 2009 17:23:45 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 9 Jun 2009 17:23:44 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n59HNQPf027103;
	Wed, 10 Jun 2009 01:23:26 +0800 (CST)
Date:	Wed, 10 Jun 2009 01:23:14 +0800
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
Subject: Re: [loongson-PATCH-v3 15/25] add basic yeeloong(2f) laptop support
Message-ID: <20090609172314.GB1287@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
References: <cover.1244120575.git.wuzj@lemote.com> <438a70c6864380344960719a0a2fe0f32de9ff45.1244120575.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <438a70c6864380344960719a0a2fe0f32de9ff45.1244120575.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:07 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/com=
mon/cmdline.c
> index 12bb606..c7b6eb1 100644
> --- a/arch/mips/loongson/common/cmdline.c
> +++ b/arch/mips/loongson/common/cmdline.c
> @@ -19,6 +19,8 @@
>   */
> =20
>  #include <asm/bootinfo.h>
> +#include <loongson.h>
> +#include <cmdline.h>

duplicated #include's.
> =20
>  #include <loongson.h>
>  #include <cmdline.h>


--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoumoIACgkQvFHICB5OKXOW8wCfT5Xb7OVbnmmTemXCT1hvD/3Z
1VgAn2MEVHAPfakxsixTghVx1KjnfSaa
=7Ocf
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
