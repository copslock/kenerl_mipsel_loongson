Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 14:54:06 +0200 (CEST)
Received: from chilli.pcug.org.au ([203.10.76.44]:56616 "EHLO smtps.tip.net.au"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491937Ab0ENMyB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 May 2010 14:54:01 +0200
Received: from canb.auug.org.au (ta-1-1.tip.net.au [203.11.71.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtps.tip.net.au (Postfix) with ESMTPSA id B4D06144001;
        Fri, 14 May 2010 22:53:53 +1000 (EST)
Date:   Fri, 14 May 2010 22:53:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>
Cc:     linux-next@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linuxppc-dev@ozlabs.org, "David H?rdeman" <david@hardeman.nu>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Message-Id: <20100514225348.05e25821.sfr@canb.auug.org.au>
In-Reply-To: <201005141326.52099.PeterHuewe@gmx.de>
References: <201005051720.22617.PeterHuewe@gmx.de>
        <201005112042.14889.PeterHuewe@gmx.de>
        <20100514060240.GD12002@linux-sh.org>
        <201005141326.52099.PeterHuewe@gmx.de>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__14_May_2010_22_53_48_+1000_F6ZXC=D=N=F2Vx.l"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Fri__14_May_2010_22_53_48_+1000_F6ZXC=D=N=F2Vx.l
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, 14 May 2010 13:26:51 +0200 Peter H=C3=BCwe <PeterHuewe@gmx.de> wrot=
e:
>
> From: Peter Huewe <peterhuewe@gmx.de>
>=20
> This patch adds a missing include linux/delay.h to prevent
> build failures[1-5]
>=20
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> Forwarded to linux-next mailing list -=20
> breakage still exists in linux-next of 20100514 - please apply

This patch was included in the v4l-dvb tree (and thus linux-next) today
-see commit 1e19cb4e7d15d724cf2c6ae23f0b871c84a92790.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__14_May_2010_22_53_48_+1000_F6ZXC=D=N=F2Vx.l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvtR90ACgkQjjKRsyhoI8wyygCfZDik8epd0H05Npyb+DFFvBOx
CdwAoJMc/3TgT2LBEXA6b3UoshPylvNm
=cIoQ
-----END PGP SIGNATURE-----

--Signature=_Fri__14_May_2010_22_53_48_+1000_F6ZXC=D=N=F2Vx.l--
