Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 06:05:09 +0100 (BST)
Received: from apollo.i-cable.com ([203.83.115.103]:4745 "HELO
	apollo.i-cable.com") by ftp.linux-mips.org with SMTP
	id S28579424AbZDTFEz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 06:04:55 +0100
Received: (qmail 12658 invoked by uid 508); 20 Apr 2009 05:04:47 -0000
Received: from 203.83.114.122 by apollo (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7730.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.169512 secs); 20 Apr 2009 05:04:47 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 20 Apr 2009 05:04:46 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3K54Sok017224;
	Mon, 20 Apr 2009 13:04:28 +0800 (CST)
Date:	Mon, 20 Apr 2009 13:04:20 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-rt-users@vger.kernel.org
Subject: Re: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
Message-ID: <20090420050419.GA22520@adriano.hkcable.com.hk>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@hofr.at>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	zhangfx@lemote.com, loongson-dev@googlegroups.com, yanh@lemote.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-rt-users@vger.kernel.org
References: <1240193547.25532.52.camel@falcon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <1240193547.25532.52.camel@falcon>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Zhangjin,

Ralf told me he has a ftrace implementation too.

11:47 < Ralf> r0bertz: ftrace looks nice but not yet mergable yet.
11:47 < Ralf> r0bertz: I also have my own ftrace implementation which in so=
me
parts is better, in some is worse.=20
11:47 < Ralf> r0bertz: So this is going to be quite a job. =20

So I think you can talk to Ralf about how to get this merged, :)

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAknsAlMACgkQvFHICB5OKXP8FACgjDtvahfiKVOXeBVoi4RDq22y
TGwAoITlCsglF5WzSujLFiECiM3YVA8V
=QGmr
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
