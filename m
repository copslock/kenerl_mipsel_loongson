Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 11:14:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:3426 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825879AbaBGKN4UiYKR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Feb 2014 11:13:56 +0100
Date:   Fri, 7 Feb 2014 10:13:49 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [RFC PATCH] MIPS: fix CONFIG_* error in fpu code
Message-ID: <20140207101346.GP54230@pburton-linux.le.imgtec.org>
References: <1391746972-25277-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1391746972-25277-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2014_02_07_10_13_50
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, Feb 07, 2014 at 12:22:52PM +0800, Huacai Chen wrote:
> Commit 597ce1723e0f (MIPS: Support for 64-bit FP with O32 binaries)
> brings some CONFIG_MIPS64, but CONFIG_MIPS64 doesn't exist in any
> Kconfig file. I guess the correct thing is CONFIG_64BIT, so fix it.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/asmmacro.h |    4 ++--
>  arch/mips/include/asm/fpu.h      |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index 3220c93..69a9a22 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -106,7 +106,7 @@
>  	.endm
>  
>  	.macro	fpu_save_double thread status tmp
> -#if defined(CONFIG_MIPS64) || defined(CONFIG_CPU_MIPS32_R2)
> +#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
>  	sll	\tmp, \status, 5
>  	bgez	\tmp, 10f
>  	fpu_save_16odd \thread
> @@ -159,7 +159,7 @@
>  	.endm
>  
>  	.macro	fpu_restore_double thread status tmp
> -#if defined(CONFIG_MIPS64) || defined(CONFIG_CPU_MIPS32_R2)
> +#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
>  	sll	\tmp, \status, 5
>  	bgez	\tmp, 10f				# 16 register mode?
>  
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index cfe092f..f80a07e 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -57,7 +57,7 @@ static inline int __enable_fpu(enum fpu_mode mode)
>  		return 0;
>  
>  	case FPU_64BIT:
> -#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_MIPS64))
> +#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_64BIT))
>  		/* we only have a 32-bit FPU */
>  		return SIGFPE;
>  #endif
> -- 
> 1.7.7.3
> 
> 

Oops, right you are - looks good to me.

Thanks,
    Paul
