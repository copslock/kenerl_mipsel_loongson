Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 10:03:19 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33515 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006967AbcAHJDRHf29M convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Jan 2016 10:03:17 +0100
Received: by mail-lf0-f47.google.com with SMTP id m198so23817792lfm.0;
        Fri, 08 Jan 2016 01:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DTxBgG5fRnSYX1VJD1pAywbDQFmU3qnha6FhpnT7Bpw=;
        b=EWGsHb3OjJlTT+Tz4RXss8BtR+uj/wie01/O20LljA4C8yLRz65/2l8t5YUxzqSETO
         PG+Za7rgLje8qCnUJL046VE3BsxDSQ3pnWcFJHOdDTEsdfy8jUk+UFaFmK2+DxdOw35t
         TW95ULxzBWIdTZlgeT6747nHhHZUHl4k7VmTpAXMpKZJ7SRdJCAXZOPBz+TiDcVXibej
         3GFudkc30o1ny74+cdCRrGzVFopl3DAYo4FapGVsx7pjKvGBeNzigCMDGnKvZuGgGxuE
         8APH3UrtDsMosLWUXwsGBS+aDcpoxKcloDjxdUg/KxdLotuYWmY4MmisGMtxZZxCZYqS
         gsoA==
X-Received: by 10.25.22.167 with SMTP id 39mr3089514lfw.153.1452243791630;
        Fri, 08 Jan 2016 01:03:11 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id h196sm18867617lfb.48.2016.01.08.01.03.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jan 2016 01:03:10 -0800 (PST)
Date:   Fri, 8 Jan 2016 12:28:00 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: ath79: Add zboot debug serial support
Message-Id: <20160108122800.fd116b9c2f74c72be9ac4d05@gmail.com>
In-Reply-To: <1449741444-29110-3-git-send-email-albeu@free.fr>
References: <1449741444-29110-1-git-send-email-albeu@free.fr>
        <1449741444-29110-3-git-send-email-albeu@free.fr>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Thu, 10 Dec 2015 10:57:22 +0100
Alban Bedel <albeu@free.fr> wrote:

> Reuse the early printk code to support the serial in zboot. We copy
> early_printk.c instead of referencing it because we need to build a
> different object file for the normal kernel and zboot.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/Kconfig                  | 2 +-
>  arch/mips/boot/compressed/Makefile | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ef1d665..bb2987b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -138,7 +138,7 @@ config ATH79
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select SYS_SUPPORTS_MIPS16
> -	select SYS_SUPPORTS_ZBOOT
> +	select SYS_SUPPORTS_ZBOOT_UART_PROM
>  	select USE_OF
>  	help
>  	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 4eff1ef..f648bf7 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -37,8 +37,12 @@ vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
>  vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
>  vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
>  vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
> +vmlinuzobjs-$(CONFIG_ATH79)			   += $(obj)/uart-ath79.o
>  endif
>  
> +$(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
> +	$(call cmd,shipped)
> +
>  vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
>  
>  $(obj)/ashldi3.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
> -- 
> 2.0.0
> 

This patch has a side effect: git untracked file arch/mips/boot/compressed/uart-ath79.c after build.
This untracked file is not removed by 'make mrproper'.

Here is my build log:

    $ git clone -b ath79 https://github.com/AlbanBedel/linux
    ...
    $ cd linux
    linux$ make ARCH=mips ath79_defconfig
    ...
    linux$ grep -w CONFIG_DEBUG_ZBOOT .config
    # CONFIG_DEBUG_ZBOOT is not set
    linux$ sed -i "s/^# \(CONFIG_DEBUG_ZBOOT\) .*$/\1=y/" .config
    linux$ make ARCH=mips oldconfig
    linux$ grep -w CONFIG_DEBUG_ZBOOT .config
    CONFIG_DEBUG_ZBOOT=y
    linux$ git status
    On branch ath79
    Your branch is up-to-date with 'origin/ath79'.
    nothing to commit, working directory clean
    
    linux$ make -s ARCH=mips CROSS_COMPILE=mips-linux-gnu- vmlinuz
    ...
    
    linux$ git status
    On branch ath79
    Your branch is up-to-date with 'origin/ath79'.
    Untracked files:
      (use "git add <file>..." to include in what will be committed)
    
            arch/mips/boot/compressed/uart-ath79.c
    
    nothing added to commit but untracked files present (use "git add" to track)
    
    linux$ make ARCH=mips mrproper
    ...

    linux$ git status
    On branch ath79
    Your branch is up-to-date with 'origin/ath79'.
    Untracked files:
      (use "git add <file>..." to include in what will be committed)
    
            arch/mips/boot/compressed/uart-ath79.c
    
    nothing added to commit but untracked files present (use "git add" to track)

-- 
Best regards,
  Antony Pavlov
