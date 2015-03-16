Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 11:08:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45388 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008837AbbCPKIOI7V0S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 11:08:14 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5873041F8DC0;
        Mon, 16 Mar 2015 10:08:09 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 16 Mar 2015 10:08:09 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 16 Mar 2015 10:08:09 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BE0DF6F32636B;
        Mon, 16 Mar 2015 10:08:07 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Mar 2015 10:08:09 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 16 Mar
 2015 10:08:08 +0000
Message-ID: <5506AB82.4050001@imgtec.com>
Date:   Mon, 16 Mar 2015 10:08:02 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 1/5] MIPS: Create a common <asm/mach-generic/war.h>
References: <1426287249-27185-1-git-send-email-abrestic@chromium.org> <1426287249-27185-2-git-send-email-abrestic@chromium.org>
In-Reply-To: <1426287249-27185-2-git-send-email-abrestic@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="Qe6usvsV1LWXWbvjvSDLjXr94msGd4pkR"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--Qe6usvsV1LWXWbvjvSDLjXr94msGd4pkR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 13/03/15 22:54, Andrew Bresticker wrote:
> From: Kevin Cernekee <cernekee@gmail.com>
>=20
> 11 platforms require at least one of these workarounds to be enabled; 2=
2
> platforms do not.  In the latter case we can fall back to a generic ver=
sion.
>=20
> Note that this also deletes an orphaned reference to RM9000_CDEX_SMP_WA=
R.
>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> No changes from v1.
> Changes from Kevin's v6:
>  - Left cavium-octeon's war.h in-tact

Based on the content of mach-generic/war.h and the list of files in the
diffstat with some grepping/hashing/diffing to verify correctness &
completeness, this looks good to me.

Reviewed-by: James Hogan <james.hogan@imgtec.com>

I suppose some possible future clean ups would be to convert the
remaining ones to #include_next <war.h> after defining only overrides
(like irq.h does, assuming that's an idiom people are happy with), and
for mach-generic/war.h to have #ifndef guards around each WAR
definition. That way they could all share the common definitions,
including cavium-octeon which only adds octeon specific ones rather than
changing any of the ones defined in mach-generic/war.h.

Cheers
James

> ---
>  arch/mips/include/asm/mach-ar7/war.h       | 24 ----------------------=
--
>  arch/mips/include/asm/mach-ath25/war.h     | 25 ----------------------=
---
>  arch/mips/include/asm/mach-ath79/war.h     | 24 ----------------------=
--
>  arch/mips/include/asm/mach-au1x00/war.h    | 24 ----------------------=
--
>  arch/mips/include/asm/mach-bcm3384/war.h   | 24 ----------------------=
--
>  arch/mips/include/asm/mach-bcm47xx/war.h   | 24 ----------------------=
--
>  arch/mips/include/asm/mach-bcm63xx/war.h   | 24 ----------------------=
--
>  arch/mips/include/asm/mach-cobalt/war.h    | 24 ----------------------=
--
>  arch/mips/include/asm/mach-dec/war.h       | 24 ----------------------=
--
>  arch/mips/include/asm/mach-emma2rh/war.h   | 24 ----------------------=
--
>  arch/mips/include/asm/mach-generic/war.h   | 24 ++++++++++++++++++++++=
++
>  arch/mips/include/asm/mach-jazz/war.h      | 24 ----------------------=
--
>  arch/mips/include/asm/mach-jz4740/war.h    | 24 ----------------------=
--
>  arch/mips/include/asm/mach-lantiq/war.h    | 23 ----------------------=
-
>  arch/mips/include/asm/mach-lasat/war.h     | 24 ----------------------=
--
>  arch/mips/include/asm/mach-loongson/war.h  | 24 ----------------------=
--
>  arch/mips/include/asm/mach-loongson1/war.h | 24 ----------------------=
--
>  arch/mips/include/asm/mach-netlogic/war.h  | 25 ----------------------=
---
>  arch/mips/include/asm/mach-paravirt/war.h  | 25 ----------------------=
---
>  arch/mips/include/asm/mach-pnx833x/war.h   | 24 ----------------------=
--
>  arch/mips/include/asm/mach-ralink/war.h    | 24 ----------------------=
--
>  arch/mips/include/asm/mach-tx39xx/war.h    | 24 ----------------------=
--
>  arch/mips/include/asm/mach-vr41xx/war.h    | 24 ----------------------=
--
>  23 files changed, 24 insertions(+), 530 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-ar7/war.h
>  delete mode 100644 arch/mips/include/asm/mach-ath25/war.h
>  delete mode 100644 arch/mips/include/asm/mach-ath79/war.h
>  delete mode 100644 arch/mips/include/asm/mach-au1x00/war.h
>  delete mode 100644 arch/mips/include/asm/mach-bcm3384/war.h
>  delete mode 100644 arch/mips/include/asm/mach-bcm47xx/war.h
>  delete mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h
>  delete mode 100644 arch/mips/include/asm/mach-cobalt/war.h
>  delete mode 100644 arch/mips/include/asm/mach-dec/war.h
>  delete mode 100644 arch/mips/include/asm/mach-emma2rh/war.h
>  create mode 100644 arch/mips/include/asm/mach-generic/war.h
>  delete mode 100644 arch/mips/include/asm/mach-jazz/war.h
>  delete mode 100644 arch/mips/include/asm/mach-jz4740/war.h
>  delete mode 100644 arch/mips/include/asm/mach-lantiq/war.h
>  delete mode 100644 arch/mips/include/asm/mach-lasat/war.h
>  delete mode 100644 arch/mips/include/asm/mach-loongson/war.h
>  delete mode 100644 arch/mips/include/asm/mach-loongson1/war.h
>  delete mode 100644 arch/mips/include/asm/mach-netlogic/war.h
>  delete mode 100644 arch/mips/include/asm/mach-paravirt/war.h
>  delete mode 100644 arch/mips/include/asm/mach-pnx833x/war.h
>  delete mode 100644 arch/mips/include/asm/mach-ralink/war.h
>  delete mode 100644 arch/mips/include/asm/mach-tx39xx/war.h
>  delete mode 100644 arch/mips/include/asm/mach-vr41xx/war.h
>=20
> diff --git a/arch/mips/include/asm/mach-ar7/war.h b/arch/mips/include/a=
sm/mach-ar7/war.h
> deleted file mode 100644
> index 99071e5..0000000
> --- a/arch/mips/include/asm/mach-ar7/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_AR7_WAR_H
> -#define __ASM_MIPS_MACH_AR7_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_AR7_WAR_H */
> diff --git a/arch/mips/include/asm/mach-ath25/war.h b/arch/mips/include=
/asm/mach-ath25/war.h
> deleted file mode 100644
> index e3a5250..0000000
> --- a/arch/mips/include/asm/mach-ath25/war.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2008 Felix Fietkau <nbd@openwrt.org>
> - */
> -#ifndef __ASM_MACH_ATH25_WAR_H
> -#define __ASM_MACH_ATH25_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define RM9000_CDEX_SMP_WAR		0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MACH_ATH25_WAR_H */
> diff --git a/arch/mips/include/asm/mach-ath79/war.h b/arch/mips/include=
/asm/mach-ath79/war.h
> deleted file mode 100644
> index 0bb3090..0000000
> --- a/arch/mips/include/asm/mach-ath79/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MACH_ATH79_WAR_H
> -#define __ASM_MACH_ATH79_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MACH_ATH79_WAR_H */
> diff --git a/arch/mips/include/asm/mach-au1x00/war.h b/arch/mips/includ=
e/asm/mach-au1x00/war.h
> deleted file mode 100644
> index 72e260d..0000000
> --- a/arch/mips/include/asm/mach-au1x00/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_AU1X00_WAR_H
> -#define __ASM_MIPS_MACH_AU1X00_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_AU1X00_WAR_H */
> diff --git a/arch/mips/include/asm/mach-bcm3384/war.h b/arch/mips/inclu=
de/asm/mach-bcm3384/war.h
> deleted file mode 100644
> index 59d7599..0000000
> --- a/arch/mips/include/asm/mach-bcm3384/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_BCM3384_WAR_H
> -#define __ASM_MIPS_MACH_BCM3384_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_BCM3384_WAR_H */
> diff --git a/arch/mips/include/asm/mach-bcm47xx/war.h b/arch/mips/inclu=
de/asm/mach-bcm47xx/war.h
> deleted file mode 100644
> index a3d2f44..0000000
> --- a/arch/mips/include/asm/mach-bcm47xx/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_BCM47XX_WAR_H
> -#define __ASM_MIPS_MACH_BCM47XX_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_BCM47XX_WAR_H */
> diff --git a/arch/mips/include/asm/mach-bcm63xx/war.h b/arch/mips/inclu=
de/asm/mach-bcm63xx/war.h
> deleted file mode 100644
> index 05ee867..0000000
> --- a/arch/mips/include/asm/mach-bcm63xx/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_BCM63XX_WAR_H
> -#define __ASM_MIPS_MACH_BCM63XX_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_BCM63XX_WAR_H */
> diff --git a/arch/mips/include/asm/mach-cobalt/war.h b/arch/mips/includ=
e/asm/mach-cobalt/war.h
> deleted file mode 100644
> index 34ae404..0000000
> --- a/arch/mips/include/asm/mach-cobalt/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_COBALT_WAR_H
> -#define __ASM_MIPS_MACH_COBALT_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_COBALT_WAR_H */
> diff --git a/arch/mips/include/asm/mach-dec/war.h b/arch/mips/include/a=
sm/mach-dec/war.h
> deleted file mode 100644
> index d29996f..0000000
> --- a/arch/mips/include/asm/mach-dec/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_DEC_WAR_H
> -#define __ASM_MIPS_MACH_DEC_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_DEC_WAR_H */
> diff --git a/arch/mips/include/asm/mach-emma2rh/war.h b/arch/mips/inclu=
de/asm/mach-emma2rh/war.h
> deleted file mode 100644
> index 79ae82d..0000000
> --- a/arch/mips/include/asm/mach-emma2rh/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_EMMA2RH_WAR_H
> -#define __ASM_MIPS_MACH_EMMA2RH_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_EMMA2RH_WAR_H */
> diff --git a/arch/mips/include/asm/mach-generic/war.h b/arch/mips/inclu=
de/asm/mach-generic/war.h
> new file mode 100644
> index 0000000..a1bc2e7
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-generic/war.h
> @@ -0,0 +1,24 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General=
 Public
> + * License.  See the file "COPYING" in the main directory of this arch=
ive
> + * for more details.
> + *
> + * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> + */
> +#ifndef __ASM_MACH_GENERIC_WAR_H
> +#define __ASM_MACH_GENERIC_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR	0
> +#define R4600_V1_HIT_CACHEOP_WAR	0
> +#define R4600_V2_HIT_CACHEOP_WAR	0
> +#define R5432_CP0_INTERRUPT_WAR		0
> +#define BCM1250_M3_WAR			0
> +#define SIBYTE_1956_WAR			0
> +#define MIPS4K_ICACHE_REFILL_WAR	0
> +#define MIPS_CACHE_SYNC_WAR		0
> +#define TX49XX_ICACHE_INDEX_INV_WAR	0
> +#define ICACHE_REFILLS_WORKAROUND_WAR	0
> +#define R10000_LLSC_WAR			0
> +#define MIPS34K_MISSED_ITLB_WAR		0
> +
> +#endif /* __ASM_MACH_GENERIC_WAR_H */
> diff --git a/arch/mips/include/asm/mach-jazz/war.h b/arch/mips/include/=
asm/mach-jazz/war.h
> deleted file mode 100644
> index 5b18b9a..0000000
> --- a/arch/mips/include/asm/mach-jazz/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_JAZZ_WAR_H
> -#define __ASM_MIPS_MACH_JAZZ_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_JAZZ_WAR_H */
> diff --git a/arch/mips/include/asm/mach-jz4740/war.h b/arch/mips/includ=
e/asm/mach-jz4740/war.h
> deleted file mode 100644
> index 9b511d3..0000000
> --- a/arch/mips/include/asm/mach-jz4740/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_JZ4740_WAR_H
> -#define __ASM_MIPS_MACH_JZ4740_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_JZ4740_WAR_H */
> diff --git a/arch/mips/include/asm/mach-lantiq/war.h b/arch/mips/includ=
e/asm/mach-lantiq/war.h
> deleted file mode 100644
> index 358ca97..0000000
> --- a/arch/mips/include/asm/mach-lantiq/war.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - */
> -#ifndef __ASM_MIPS_MACH_LANTIQ_WAR_H
> -#define __ASM_MIPS_MACH_LANTIQ_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif
> diff --git a/arch/mips/include/asm/mach-lasat/war.h b/arch/mips/include=
/asm/mach-lasat/war.h
> deleted file mode 100644
> index 741ae72..0000000
> --- a/arch/mips/include/asm/mach-lasat/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_LASAT_WAR_H
> -#define __ASM_MIPS_MACH_LASAT_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_LASAT_WAR_H */
> diff --git a/arch/mips/include/asm/mach-loongson/war.h b/arch/mips/incl=
ude/asm/mach-loongson/war.h
> deleted file mode 100644
> index f2570df..0000000
> --- a/arch/mips/include/asm/mach-loongson/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MACH_LOONGSON_WAR_H
> -#define __ASM_MACH_LOONGSON_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MACH_LEMOTE_WAR_H */
> diff --git a/arch/mips/include/asm/mach-loongson1/war.h b/arch/mips/inc=
lude/asm/mach-loongson1/war.h
> deleted file mode 100644
> index 8fb50d0..0000000
> --- a/arch/mips/include/asm/mach-loongson1/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MACH_LOONGSON1_WAR_H
> -#define __ASM_MACH_LOONGSON1_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MACH_LOONGSON1_WAR_H */
> diff --git a/arch/mips/include/asm/mach-netlogic/war.h b/arch/mips/incl=
ude/asm/mach-netlogic/war.h
> deleted file mode 100644
> index 2c72168..0000000
> --- a/arch/mips/include/asm/mach-netlogic/war.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2011 Netlogic Microsystems.
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_NLM_WAR_H
> -#define __ASM_MIPS_MACH_NLM_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_NLM_WAR_H */
> diff --git a/arch/mips/include/asm/mach-paravirt/war.h b/arch/mips/incl=
ude/asm/mach-paravirt/war.h
> deleted file mode 100644
> index 36d3afb..0000000
> --- a/arch/mips/include/asm/mach-paravirt/war.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - * Copyright (C) 2013 Cavium Networks <support@caviumnetworks.com>
> - */
> -#ifndef __ASM_MIPS_MACH_PARAVIRT_WAR_H
> -#define __ASM_MIPS_MACH_PARAVIRT_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_PARAVIRT_WAR_H */
> diff --git a/arch/mips/include/asm/mach-pnx833x/war.h b/arch/mips/inclu=
de/asm/mach-pnx833x/war.h
> deleted file mode 100644
> index e410df4..0000000
> --- a/arch/mips/include/asm/mach-pnx833x/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_PNX833X_WAR_H
> -#define __ASM_MIPS_MACH_PNX833X_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_PNX833X_WAR_H */
> diff --git a/arch/mips/include/asm/mach-ralink/war.h b/arch/mips/includ=
e/asm/mach-ralink/war.h
> deleted file mode 100644
> index c074b5d..0000000
> --- a/arch/mips/include/asm/mach-ralink/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MACH_RALINK_WAR_H
> -#define __ASM_MACH_RALINK_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MACH_RALINK_WAR_H */
> diff --git a/arch/mips/include/asm/mach-tx39xx/war.h b/arch/mips/includ=
e/asm/mach-tx39xx/war.h
> deleted file mode 100644
> index 6a52e65..0000000
> --- a/arch/mips/include/asm/mach-tx39xx/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_TX39XX_WAR_H
> -#define __ASM_MIPS_MACH_TX39XX_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_TX39XX_WAR_H */
> diff --git a/arch/mips/include/asm/mach-vr41xx/war.h b/arch/mips/includ=
e/asm/mach-vr41xx/war.h
> deleted file mode 100644
> index ffe31e7..0000000
> --- a/arch/mips/include/asm/mach-vr41xx/war.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General=
 Public
> - * License.  See the file "COPYING" in the main directory of this arch=
ive
> - * for more details.
> - *
> - * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org=
>
> - */
> -#ifndef __ASM_MIPS_MACH_VR41XX_WAR_H
> -#define __ASM_MIPS_MACH_VR41XX_WAR_H
> -
> -#define R4600_V1_INDEX_ICACHEOP_WAR	0
> -#define R4600_V1_HIT_CACHEOP_WAR	0
> -#define R4600_V2_HIT_CACHEOP_WAR	0
> -#define R5432_CP0_INTERRUPT_WAR		0
> -#define BCM1250_M3_WAR			0
> -#define SIBYTE_1956_WAR			0
> -#define MIPS4K_ICACHE_REFILL_WAR	0
> -#define MIPS_CACHE_SYNC_WAR		0
> -#define TX49XX_ICACHE_INDEX_INV_WAR	0
> -#define ICACHE_REFILLS_WORKAROUND_WAR	0
> -#define R10000_LLSC_WAR			0
> -#define MIPS34K_MISSED_ITLB_WAR		0
> -
> -#endif /* __ASM_MIPS_MACH_VR41XX_WAR_H */
>=20


--Qe6usvsV1LWXWbvjvSDLjXr94msGd4pkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVBquIAAoJEGwLaZPeOHZ6T6oP/jyLSFo+AzB32vD+ikmH2Nn/
6D6a435eLF+VEQ7D+Vu4wjd8NZYKT2CTGyY9Z8aD96OqQO1IvctU83CbK9CRg6jt
JMJ3W3KhCU9vjfWW7w2B6LLXLyWbAgPqPYC/wru7bjiDmdkmeD/QjoyF29nzLUOe
hhauAXmIv82oTwvr3hqP+c/0eoVRLvv2f5B+8tOxXgerQJ3yK9Lwftgybed7KSPm
yxA8FAHlzjzgNxwSiSXv7xkuZDWnQFu2/iQd+/2phj82X/2+kRcpAPqFRIi338nr
XfYlbskvic+c9QGBP/WSRnBVpndMXG1xbhZ4aArzsfwp/VCobg3jwa490a7owtSE
EMz30hFG26lZLZ0oaTQ4tPzWAd6/ViQPNi2P1ek0bNIodMkLQsrKDbkKc3Mp/fLS
pKukTprv8GVNBM8mnvXC6NxtuegAsu/0eCtG5S0m3MfjfBfLlm7WqfX7IHJCXKEV
9wqaUHygpLXe0/n6+bH/h7dtlZ+5UaKviWNtoxRsOlOYaP5u8IO5TG0TU82MHKfT
uJ+OPRs/GM/cimM5Re4EjZPOd2ms3NCzYfn9CB5n4jJBWkgrIHsAb32icDUhNbex
6+wxkHvftzdL0DGbcnWgzt75258H41Fl2qNv6ovBguSqG8FtdXC9Ettd1m8ugRCq
4lGUouAauS5EDpqzzU+Q
=1rPg
-----END PGP SIGNATURE-----

--Qe6usvsV1LWXWbvjvSDLjXr94msGd4pkR--
