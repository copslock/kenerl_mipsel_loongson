Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 19:16:52 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:47240 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491984Ab0DGRQo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Apr 2010 19:16:44 +0200
Received: by smtp.gentoo.org (Postfix, from userid 2181)
        id A32DF1B4026; Wed,  7 Apr 2010 17:16:32 +0000 (UTC)
Date:   Wed, 7 Apr 2010 17:16:32 +0000
From:   Zhang Le <r0bertz@gentoo.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 2/4] Loongson-2F: Enable fixups of the latest
        binutils
Message-ID: <20100407171632.GA1137@woodpecker.gentoo.org>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <cover.1270645413.git.wuzhangjin@gmail.com> <cf5a00449fa910daf1d1313d6b4d1df1e7a85a24.1270645413.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5a00449fa910daf1d1313d6b4d1df1e7a85a24.1270645413.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 21:11 Wed 07 Apr     , Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Changes from old revision:
> 
>   o Incorporated with the feedbacks from Ralf and used the options
>   introduced from "Loongson: Add CPU_LOONGSON2F_WORKAROUNDS".
> 
> As the "Fixups of Loongson2F" patch[1] to binutils have been applied
> into binutils 2.20.1. It's time to enable the options provided by the
> patch to compile the kernel.
> 
> Without these fixups, the system will hang unexpectedly for the bug of
> processor.
> 
> To learn more about these fixups, please refer to the following
> references.
> 
> [1] "Fixups of Loongson2F" patch for binutils(actually for gas)
> http://sourceware.org/ml/binutils/2009-11/msg00387.html
> [2] Chapter 15 of "Loongson2F User Manual"(Chinese Version)
> http://www.loongson.cn/uploadfile/file/200808211
> [3] English Version of the above chapter 15
> http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source
> 
> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Makefile |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 2f2eac2..14f12bc 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -136,6 +136,19 @@ cflags-$(CONFIG_CPU_LOONGSON2E) += \
>  	$(call cc-option,-march=loongson2e,-march=r4600)
>  cflags-$(CONFIG_CPU_LOONGSON2F) += \
>  	$(call cc-option,-march=loongson2f,-march=r4600)
> +# enable the workarounds for loongson2f
> +ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
> +  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
> +    $(error gcc does not support needed option -mfix-loongson2f-nop)

    Again, this is an as option. :)
    So this error msg is a little miss leading.
    Maybe we should tell user at least which version of binutils is needed.

> +  else
> +    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-nop
> +  endif
> +  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-jump,),)
> +    $(error gcc does not support needed option -mfix-loongson2f-jump)

    Same here.

Zhang, Le

> +  else
> +    cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-jump
> +  endif
> +endif
>  
>  cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
>  			-Wa,-mips32 -Wa,--trap
> -- 
> 1.7.0.1
> 
