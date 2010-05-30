Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2010 05:11:41 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:59572 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0E3DLi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 May 2010 05:11:38 +0200
Received: by pxi1 with SMTP id 1so1160521pxi.36
        for <multiple recipients>; Sat, 29 May 2010 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=r1a2wfbL9Cd90bZX0YXSawnpL5OU8TW+9IlqJgX4Drk=;
        b=sFmch4b5Kq4yVsm2JB1Qzr5xLn3ejLoNIYChTPLaxImhApc9qQvgDqWCMmMcIDr5hk
         ox5PiCEGNJd+KJsl9l0wkb7oaszNTPyshdZOaz2Sgxpv3ULKb6DbSELlSvI5Fih5wVxH
         ICLJIUs19Dxocrj1xXygtyD28QbZzihJbzObw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=pVY2GWbJhSqkW016Ab8Rjf6jRze3Ldb46w3ciKCY1LOBV0MMmtVTIWCnk/YhZm0s9C
         cfZQz46HpJh6pbfq0IkySszIN91J+bm3tOKDTmn16upQafBP3KBr04JBEeRZXBGisLwV
         SdXi1RTpZHzK5OqGS0aHyeMyXpgAK7mnkG1nM=
Received: by 10.115.98.19 with SMTP id a19mr2033212wam.82.1275189091240;
        Sat, 29 May 2010 20:11:31 -0700 (PDT)
Received: from [192.168.2.226] ([202.201.14.140])
        by mx.google.com with ESMTPS id f11sm35286604wai.23.2010.05.29.20.11.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 20:11:30 -0700 (PDT)
Subject: Re: [PATCH] mips: refactor arch/mips/boot/Makefile
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20100529195752.GA19568@merkur.ravnborg.org>
References: <20100529195752.GA19568@merkur.ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 30 May 2010 11:11:25 +0800
Message-ID: <1275189085.4258.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sam

This patch really make the Makefile looks better,

Could you please apply the similar modification to
arch/mips/boot/compressed/Makefile? thanks!

Regards,
	Wu Zhangjin

On Sat, 2010-05-29 at 21:57 +0200, Sam Ravnborg wrote:
> >From 0b95917f21f145d07351fb098b3f4804c4bf6ca1 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 29 May 2010 21:50:50 +0200
> Subject: [PATCH] mips: refactor arch/mips/boot/Makefile
> 
> - remove stuff that is not needed
>   VMLINUX assignment, all: rule, unused assignment
> - use hostprogs-y for the host program
> - use direct assignmnet when possible
> - use kbuild rules for the three targets - to beautify output
> - update clean-files to specify the targets that is built in the top.level dir
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  arch/mips/boot/Makefile |   30 +++++++++++++++---------------
>  1 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
> index de20e81..28dbf92 100644
> --- a/arch/mips/boot/Makefile
> +++ b/arch/mips/boot/Makefile
> @@ -11,32 +11,32 @@
>  # Some DECstations need all possible sections of an ECOFF executable
>  #
>  ifdef CONFIG_MACH_DECSTATION
> -  E2EFLAGS = -a
> -else
> -  E2EFLAGS =
> +  E2EFLAGS := -a
>  endif
>  
>  #
>  # Drop some uninteresting sections in the kernel.
>  # This is only relevant for ELF kernels but doesn't hurt a.out
>  #
> -drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
> -strip-flags	= $(addprefix --remove-section=,$(drop-sections))
> +drop-sections := .reginfo .mdebug .comment .note .pdr .options .MIPS.options
> +strip-flags   := $(addprefix --remove-section=,$(drop-sections))
>  
> -VMLINUX = vmlinux
> -
> -all: vmlinux.ecoff vmlinux.srec
> +hostprogs-y := elf2ecoff
>  
> +quiet_cmd_ecoff = ECOFF   $@
> +      cmd_ecoff = $(obj)/elf2ecoff $(VMLINUX) $(obj)/vmlinux.ecoff $(E2EFLAGS)
>  vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX)
> -	$(obj)/elf2ecoff $(VMLINUX) $(obj)/vmlinux.ecoff $(E2EFLAGS)
> -
> -$(obj)/elf2ecoff: $(obj)/elf2ecoff.c
> -	$(HOSTCC) -o $@ $^
> +	$(call cmd,ecoff)
>  
> +quiet_cmd_bin = OBJCOPY $@
> +      cmd_bin = $(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
>  vmlinux.bin: $(VMLINUX)
> -	$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
> +	$(call cmd,bin)
>  
> +quiet_cmd_srec = OBJCOPY $@
> +      cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
>  vmlinux.srec: $(VMLINUX)
> -	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
> +	$(call cmd,srec)
>  
> -clean-files += elf2ecoff
> +# clean files created in top-level directory
> +clean-files := $(objtree)/vmlinux.*
