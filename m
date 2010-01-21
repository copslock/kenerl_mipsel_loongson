Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2010 06:24:34 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36335 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491098Ab0AUFY2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2010 06:24:28 +0100
Received: by yxe42 with SMTP id 42so1675695yxe.22
        for <multiple recipients>; Wed, 20 Jan 2010 21:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=F4IB2ehoMbawC2Lr1rwfq/W457KWpmI4qSxxTXd5IWA=;
        b=wpnkKclq6iDvJlxCQp/62jD26NdbbrgUDz4NuBw39hZquwUBfu4l3ze48A0pMTwcSm
         2Aer02T/Bj93Za2yNF7UUZUEi9CxpbIa9GblxSdlCiBvBtfLI/UZrG5lwH8BbJqglUpm
         nhZwhMRa3DwEX0Z3N6YHhEnV69A2zJhPgVYsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=WoD+joUG9Y4vyzdJhLTKqKMZ+AonLasHBscd8wprMakwZqR3MpNsbB8wcfAj9Mca9U
         gaVcrBjTxOxpigTmSQosh2cY/2GkDO6BPDL1dipv2eLyLBuYnYIOpihY7V5UdtFZEhYO
         SzfjFkLKM0sLPDsytz8c8/gbxp5ElktHD+Cp0=
Received: by 10.150.15.42 with SMTP id 42mr1418819ybo.266.1264051462477;
        Wed, 20 Jan 2010 21:24:22 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm289547ywh.30.2010.01.20.21.24.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 21:24:20 -0800 (PST)
Subject: Re: [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Alexander Clouter <alex@digriz.org.uk>
In-Reply-To:  <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
References:  <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 21 Jan 2010 13:23:57 +0800
Message-ID: <1264051437.1814.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13804

Hi, Ralf

This patch is a bugfix, which is necessary for the users who are using
dash(or the other SHELLs not compatible with bash). without it, they
will get a broken compressed kernel image(with wrong load address).

Could you please queue it for 2.6.34 and also 2.6.33?

Thanks & Regards,
	Wu Zhangjin

On Wed, 2010-01-20 at 20:50 +0000, Alexander Clouter wrote:
> Counter to the documentation for the dash shell, it seems that on my
> x86_64 filth under Debian only does 32bit math.  As I have configured my
> lapdog to use 'dash' for non-interactive tasks I run into problems when
> compiling a compressed kernel.
> 
> I play with the AR7 platform, so VMLINUX_LOAD_ADDRESS is
> 0xffffffff94100000, and for an example 4MiB kernel
> VMLINUZ_LOAD_ADDRESS is made out to be:
> ----
> alex@berk:~$ bash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
> ffffffff94500000
> alex@berk:~$ dash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
> 80000000003fffff
> ----
> 
> The former is obviously correct whilst the later breaks things royally.
> 
> Fortunately working with only the lower 32bit's works for both bash and
> dash:
> ----
> $ bash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
> 94500000
> $ dash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
> 94500000
> ----
> 
> So, we can split the original 64bit string to two parts, and only
> calculate the low 32bit part, which is big enough (1GiB kernel sizes
> anyone?) for a normal Linux kernel image file, now, we calculate the
> VMLINUZ_LOAD_ADDRESS like this:
> 
> 1. if present, append top 32bit of VMLINUX_LOAD_ADDRESS" as a prefix
> 2. get the sum of the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
> 
> This patch fixes vmlinuz kernel builds on systems where only a 
> 32bit-only math shell is available.
> 
> Patch Changelog:
>   Version 2
>     - simplified method by using 'expr' for 'substr' and making it work 
> 	with dash once again
>   Version 1
>     - Revert the removals of '-n "$(VMLINUX_SIZE)"' to avoid the error  
>         of "make clean"
>     - Consider more cases of the VMLINUX_LOAD_ADDRESS
>   Version 0
>     - initial release
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> Acked-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/compressed/Makefile |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 671d344..ab78095 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -14,8 +14,11 @@
>  
>  # compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
>  VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
> -VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
> -VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
> +VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo -n $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
> +# VMLINUZ_LOAD_ADDRESS = concat "high32 of VMLINUX_LOAD_ADDRESS" and "(low32 of VMLINUX_LOAD_ADDRESS) + VMLINUX_SIZE"
> +HIGH32 := $(shell A=$(VMLINUX_LOAD_ADDRESS); [ $${\#A} -gt 10 ] && expr substr "$(VMLINUX_LOAD_ADDRESS)" 3 $$(($${\#A} - 10)))
> +LOW32 := $(shell [ -n "$(HIGH32)" ] && A=11 || A=3; expr substr "$(VMLINUX_LOAD_ADDRESS)" $${A} 8)
> +VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" -a -n "$(LOW32)" ] && printf "$(HIGH32)%08x" $$(($(VMLINUX_SIZE) + 0x$(LOW32))))
>  
>  # set the default size of the mallocing area for decompressing
>  BOOT_HEAP_SIZE := 0x400000
