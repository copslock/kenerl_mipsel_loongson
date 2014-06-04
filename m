Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 09:58:20 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:43253 "HELO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6843095AbaFDH6PEeVnU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jun 2014 09:58:15 +0200
X-QQ-mid: bizesmtp1t1401868653t493t322
Received: from mail-la0-f46.google.com (unknown [209.85.215.46])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 04 Jun 2014 15:57:29 +0800 (CST)
X-QQ-SSF: 0110000000200020F522B00A0000000
X-QQ-FEAT: zFT4+k5Nwkry/NEVk3UnPa2NH0Cy4WtV/twbgcX4EuBP6k64iBaUxVTRr96Xj
        oo9NDRMV6/4QnzMjJDfZiW22yPXPbX4+daI7ECDc5mxSy18Htp2W3zOAvSqZgThDoSC+QyB
        phLTo4byD2xpXhVTFRYWmuJrVePQnefkkR6G04c=
X-QQ-GoodBg: 0
Received: by mail-la0-f46.google.com with SMTP id ec20so4175334lab.33
        for <multiple recipients>; Wed, 04 Jun 2014 00:57:27 -0700 (PDT)
X-Received: by 10.112.129.202 with SMTP id ny10mr37232533lbb.14.1401868647963;
 Wed, 04 Jun 2014 00:57:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.63.198 with HTTP; Wed, 4 Jun 2014 00:57:07 -0700 (PDT)
In-Reply-To: <20140603184414.GT17197@linux-mips.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com> <20140603184414.GT17197@linux-mips.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Wed, 4 Jun 2014 15:57:07 +0800
Message-ID: <CAGXxSxUUOGK5HCX5F3AUv9UpS2hUx5xThWyrZLyQOD_cVNXL0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

I've tested the patch:
1. arch/mips/net/bpf_jit.c is missing in master branch of linux-mips,
so it was ignored.
2. Other things are fine.

2014-06-04 2:44 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
> diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
> index ac9a8f9..b2ab2cf 100644
> --- a/arch/mips/include/uapi/asm/swab.h
> +++ b/arch/mips/include/uapi/asm/swab.h
> @@ -13,7 +13,8 @@
>
>  #define __SWAB_64_THRU_32__
>
> -#if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
> +#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||              \
> +    defined(_MIPS_ARCH_LOONGSON3A)
>
>  static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
>  {
> @@ -55,5 +56,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
Should we add ".set arch=mips64r2" for using of wsbh/dsbh?
I can compile 3.15-rc8 with the patch applied, but when I tried the
patch on 3.10, it reported "unrecognized op dsbh..."

> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
> index 9901237..4c721e2 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -277,9 +277,12 @@ LEAF(csum_partial)
>  #endif
>
>         /* odd buffer alignment? */
> -#ifdef CONFIG_CPU_MIPSR2
> +#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
Should above line be replaced with the following line?
"#if cpu_has_wsbh"
