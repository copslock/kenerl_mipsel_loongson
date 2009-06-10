Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 16:41:36 +0100 (WEST)
Received: from xylophone.i-cable.com ([203.83.115.99]:33059 "HELO
	xylophone.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20023074AbZFJPla (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2009 16:41:30 +0100
Received: (qmail 4340 invoked by uid 508); 10 Jun 2009 15:41:01 -0000
Received: from 203.83.114.121 by xylophone (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.219974 secs); 10 Jun 2009 15:41:01 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 10 Jun 2009 15:41:00 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n5AFehHJ003799;
	Wed, 10 Jun 2009 23:40:43 +0800 (HKT)
Date:	Wed, 10 Jun 2009 23:40:33 +0800
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
Subject: Re: [loongson-PATCH-v3 17/25] add a machtype kernel command line
	argument
Message-ID: <20090610154032.GB21877@adriano.hkcable.com.hk>
Mail-Followup-To: wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>, Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>, Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
References: <cover.1244120575.git.wuzj@lemote.com> <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:08 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
>=20
> the difference between yeeloong-7inch and yeeloong-8.9inch is very
> small, only including the screen size and shutdown logic. so, it's very
> important to share the same kernel image file between them instead of
> adding some new kernel config options. benefit from this, the
> distribution developers only have a need to compile the kernel one time.
>=20
> to share the same kernel image file between yeelooong-7inch and
> yeeloong-8.9inch, there is a need to add a kernel command line, here I
> name is machtype, it works like this:
>=20
> 	machtype=3Dlemote-yeeloong-2f-7inch
> 	      company - product - cpu revision - size
>=20
> so, we can choose a suitable vga mode for the screen of different size
> by default via this kernel command line in prom_init, here exactly is
> mach_prom_init_cmdline in arch/mips/loongson/yeeloong-2f/init.c.
>=20
> the vga command line will be used later in the SMI video driver to
> choose a suitable screen resolution ratio.
>=20
> and also, we can get the true machine name via this kenrel command line
> argument.

I have tested this patchset on both fuloong 2f and 2e boxes.
It works well except for that duplicated #include's problem.

However, there is an annoying problem. The system type on these two boxes
has an "-unknowninch" ending, which does not make any sense at all.=20

So I made a patch on top of your patchset which makes kernel param
machtype=3Dlemote-yeeloong-2f-7inch work as before, while on fuloongs return
system types like "lemote-fuloong-2e-box" and is less intrusive againt
linux-mips tree.

I will post this patch after I test the patchset on yeeloong 8.9 notebook.

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkov0/AACgkQvFHICB5OKXMuZQCgic65jefb0qmv097esUqsR73c
iuIAn1lRBhQBZc6bCkXSrAudZbmQ7mJH
=74vR
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
