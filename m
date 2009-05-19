Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 17:25:39 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:35828 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20024233AbZESQZd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 17:25:33 +0100
Received: (qmail 25452 invoked by uid 508); 19 May 2009 16:25:24 -0000
Received: from 203.83.114.121 by sitar (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.154444 secs); 19 May 2009 16:25:24 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 19 May 2009 16:25:24 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n4JGP7DS001775;
	Wed, 20 May 2009 00:25:07 +0800 (HKT)
Date:	Wed, 20 May 2009 00:25:04 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [PATCH 01/30] Fix warning: incompatible argument type of
	pci_fixup_irqs
Message-ID: <20090519162503.GC8917@adriano.hkcable.com.hk>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>, loongson-dev@googlegroups.com,
	zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Erwan Lerale <erwan@thiscow.com>
References: <1242424728.10164.140.camel@falcon> <20090518063510.GA8917@adriano.hkcable.com.hk> <1242724411.18816.16.camel@falcon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <1242724411.18816.16.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17:13 Tue 19 May     , Wu Zhangjin wrote:
> the new patchset will come one day or two later(will be sent out via
> 'git send-email')

BTW, please also check 'man git-format-patch' for --cover-letter and --thre=
ad
options.

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoS3V8ACgkQvFHICB5OKXMrHQCfcKXlVwsrP+GinyDDVr5+NNuK
VkUAoIcpvy8LyVB3CiI0bTyRrMAy6bkQ
=hvgE
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
