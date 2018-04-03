Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 18:07:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993864AbeDCQHk6R3Nk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Apr 2018 18:07:40 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C972620CAA;
        Tue,  3 Apr 2018 16:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972620CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 3 Apr 2018 17:07:29 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 3/3] MIPS: use generic GCC library routines from lib/
Message-ID: <20180403160728.GB3275@saruman>
References: <1522747466-22081-1-git-send-email-matt.redfearn@mips.com>
 <1522747466-22081-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <1522747466-22081-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 10:24:26AM +0100, Matt Redfearn wrote:
> From: Antony Pavlov <antonynpavlov@gmail.com>
>=20
> The commit b35cd9884fa5 ("lib: Add shared copies of some GCC library
> routines") makes it possible to share generic GCC library routines by
> several architectures.
>=20
> This commit removes several generic GCC library routines from
> arch/mips/lib/ in favour of similar routines from lib/.
>=20
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> [Matt Redfearn] Use GENERIC_LIB_* named Kconfig entries
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org

ci20_defconfig:
make[1]: *** No rule to make target 'arch/mips/lib/ashldi3.c', needed by 'a=
rch/mips/boot/compressed/ashldi3.c'.  Stop.
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/mips/Makefile +395 : vmlinuz] Error 2

same for db1xxx_defconfig (and possibly others).

Thanks
James

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDpsAACgkQbAtpk944
dnoiIQ/+KDxYNqNKyAK5CztRIZzY5OevXj6PV8PmNPNNAmpsYagbZsCPSBZDafvb
6gGENo7ZoCpTkQyj5nOBdmVFnUb6B7vSLG9Y2XwDC3Xj++tBRPb01zHcAPr7gbFh
A6edFgI3+D0Qp9/hthwg10ZS6K89dEeeLSiBcsAF5dWDnyyfj3mgEyhhwUKGr0g6
apGCOSWZBb+vwWOLZDyx5Mu5JyDTiiKZ4+176CDXlbOiLbam9DRV+QpwHnoX0NTp
6UcFSBJrHRBrXuLkWJKCWbjVBBy9RG+FMiaWtqbRoYCkLlYDL4PwQcs1jWPFiTuq
v9dCCFTHGuNWPNR6UwL/dbTlvxTEHEvyzmQjh12h7miFAh5BxOTGO67/9Ca9N7Yw
A3GkHR90lXeizplijUhbO92eIbmyRp9IOHNrZB6n6VXLlHKtdY2CD1dEXAB23h7n
lVzdJ+vsm+2sXk6if0Gx0SgFg/Qtr5jSg6748eG5dlT5I7q42ZhlswhTdvQhbt/o
Qjj5GMDjy/OES9Zj9/HZFyUf4rtu+9tRffHcRAFLadqyrPw2hg2Ks7ECUrl6pRXP
sEA/l/PowHSXv90I8GenKwEhpUn6YSSdv7JoPpqQKuhkcKotpgYKuSKrjfV9R7mL
AlesX/tQn8NlQwNRRtKprFeHn4m3/vg2mEYBSr9sEgTqReuJSpI=
=J1ZU
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
