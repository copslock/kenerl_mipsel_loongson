Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 22:42:04 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:59969 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993023AbdKAVlz2RRrL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 22:41:55 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 01 Nov 2017 21:40:11 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Nov 2017
 14:39:33 -0700
Date:   Wed, 1 Nov 2017 21:40:24 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Matt Ranostay" <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        "Raghu Gandham" <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] MIPS: Update Goldfish RTC driver maintainer email
 address
Message-ID: <20171101214024.GM15235@jhogan-linux>
References: <1508509687-3074-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1508509687-3074-3-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j6zkAHxOZJkiczrA"
Content-Disposition: inline
In-Reply-To: <1508509687-3074-3-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509572410-637139-14740-440033-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186492
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--j6zkAHxOZJkiczrA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aleksandar,

On Fri, Oct 20, 2017 at 04:27:45PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>=20
> Change all relevant instances of miodrag.dinic@imgtec.com
> email address to miodrag.dinic@mips.com.
>=20
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index bd14d63..2494b4b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -118,6 +118,7 @@ Matt Ranostay <matt.ranostay@konsulko.com> <matt@rano=
stay.consulting>
>  Mayuresh Janorkar <mayur@ti.com>
>  Michael Buesch <m@bues.ch>
>  Michel D=C3=A4nzer <michel@tungstengraphics.com>
> +Miodrag Dinic <miodrag.dinic@imgtec.com> <miodrag.dinic@mips.com>

Thats the wrong way around (mips -> imgtec).

I'll take both of these via my mips-fixes branch for v4.14, so I'll fix
this up when applying.

Thanks
James

>  Mitesh shah <mshah@teja.com>
>  Mohit Kumar <mohit.kumar@st.com> <mohit.kumar.dhaka@gmail.com>
>  Morten Welinder <terra@gnome.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e753610..4a3de82 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -873,7 +873,7 @@ F:	drivers/android/
>  F:	drivers/staging/android/
> =20
>  ANDROID GOLDFISH RTC DRIVER
> -M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
> +M:	Miodrag Dinic <miodrag.dinic@mips.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
>  F:	drivers/rtc/rtc-goldfish.c
> --=20
> 2.7.4
>=20

--j6zkAHxOZJkiczrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAln6P0AACgkQbAtpk944
dnoC4g//ZJczmCxWtS5PkkmbVK03Mbn9qoO5xnAW6Zy7wIQEjIFPSzxC1I3dfjt+
2d+xWkglhFKZcsYTh1ZVbd44X38KqdgZ430iHgTxs0jx7ykdbGiseuyMLr0h2qdQ
btEzxwIBjc8SUcUN3pvrlVmp+ef2pkiYiqIMnZdiMwTVhovsn7sepBl/JV+iwJhF
v5IlJCWxn+ev/ZImUv7YGnjGKbinrurLk2GF1fBw5xcWq5Z9UYJI7A/47fmoUZf7
XHMepW1KA4c7EoHo+b3tgXzyWfcHKilTraXqDwaVwfv2BmVa85yBx0g5b9kYAUex
l4osd6+OB0sx6ViG7/YC3QHhw1h+hGk5qPxnTQmn8GVHaqGT1+FvOAs3kO6bGM1J
+EZtQNTNnF2hmsW8pmPKQIzNd/T5p+rtSr2E5BR05mz1CNYXDH9FI0Ckm85SIkzW
T49sunRINXWce/FzwqpmChm3bVaxExI22LHUZPki5Z3+0XxQ4vqKWb/zqcKTbs4M
Lhw9hAeDx3qQwYu2kU3cDrvCVF+HXZ7FWORa7HcnWJ1M8fd3VqzntkK4QhZMTqO2
rouYhfXVNX4QvIBR8wnqceJD163/1yn0OsSvvef2t4xMQSlwOJRKBfS898tY89m7
ps4h3NQXJcuRSpM95NrUq0hD3C25G1kaeTic244nqmAiYkxqAyc=
=Jm0u
-----END PGP SIGNATURE-----

--j6zkAHxOZJkiczrA--
