Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 13:26:15 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34068 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030739AbcEXL0OJP5MM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2016 13:26:14 +0200
Received: by mail-lb0-f196.google.com with SMTP id t6so776430lbv.1
        for <linux-mips@linux-mips.org>; Tue, 24 May 2016 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJRrRHXsUMq1jklLTtXibsdp1Jl0GAX4Mw2mauH+tK8=;
        b=w32ayvEaAaNuXzbnqAOd90iLgIdQ44dBWdoEiSmq/aZ/l7X8i6Rti1rLJz7E0acB+Q
         e+3FMKioyw9GxBKwaGlQk0ZZTmjSgicNEgjBXbkMozfr8GkTFoYK0LhKK+hA9H0F5f5w
         xXop6iQiIOS/FLs+mKNMSNaSCisbJVUwgOeUWl0ip1OovHyy1vbKp0Y9MLndN1MlR7ph
         CoC/7KcL+92Ds4ZPf+ssib73Zh1uTLW5aMu9hThAVgOHZHQ71q4jnmBUcepeiMQelrCG
         XbmPZfgozZmL22tJztVV/lczeiCUsFR+Yh9gr6hKJw2BvGvL5YjA6rXS5dlWNRjPAHu7
         gxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJRrRHXsUMq1jklLTtXibsdp1Jl0GAX4Mw2mauH+tK8=;
        b=aW10uybW64jFnEiTfYSO3iMejobsOWFsGXIv2GHMhJkvx8hA/qt+nqQCMetHPUYP4R
         KJLrKZYwbJtFDbSURlIyB0XyiW+ZS/qoF6YV0GRY3ksnuNqpOHvifKesQtSqal3vd/hJ
         pVxuAoUCFdFXUkrUM001Ohgr6pJZkFvIDDub3paxGpOc8tynPSYhGOx1RksBbrATcoGg
         39+MHoi50/oZe1hoBUgjJ0K49geCwnl8+Oa+fCSoljAaBZ+JJUgelDi7SYxw1eAabMlM
         RtNOH9nPXiiJgmiC1j/3eK7mHcyXgOnLk0wdTmObo517cAtsVfqzK+B/GS4eicMixXsc
         7bUg==
X-Gm-Message-State: AOPr4FX6Y3X51k/NTXit5Nmm1rqDFN+6sOhNLxbT5Rj1m4za6GhvPqh+hSZ6gAmM1BPE8w==
X-Received: by 10.112.172.199 with SMTP id be7mr7657234lbc.49.1464089168552;
        Tue, 24 May 2016 04:26:08 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id ez1sm400936lbc.29.2016.05.24.04.26.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 04:26:07 -0700 (PDT)
Date:   Tue, 24 May 2016 14:27:11 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Subject: Re: [RFC PATCH] Re: Adding support for device tree and command line
Message-Id: <20160524142711.58a6bf90f3adbe18a28973b3@gmail.com>
In-Reply-To: <1464067930.27173.7.camel@chimera>
References: <574372CD.1060201@hauke-m.de>
        <5743777F.9060801@hauke-m.de>
        <1464041521.5475.18.camel@chimera>
        <1464067930.27173.7.camel@chimera>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53636
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

On Mon, 23 May 2016 22:32:10 -0700
Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us> wrote:

> From 464df9cb918d46fcbe5552b46b2fe7f916fdd0b4 Mon Sep 17 00:00:00 2001
> From: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
> Date: Mon, 23 May 2016 22:19:42 -0700
> Subject: [RFC PATCH] Re: Adding support for device tree and command line
> 
> On Mon, 2016-05-23 at 15:12 -0700, Daniel Gimpelevich wrote:
> > On Mon, 2016-05-23 at 23:34 +0200, Hauke Mehrtens wrote:
> > > On 05/23/2016 11:14 PM, Hauke Mehrtens wrote:
> > > > Section 3 of this document defines some interfaces how a boot loader
> > > > could forward a command line *or* a device tree to the kernel:
> > > > http://wiki.prplfoundation.org/w/images/4/42/UHI_Reference_Manual.pdf
> > > > This allows only a device tree *or* a command line, not both.
> > > > 
> > > > The Linux kernel also supports an appended device tree. In this case the
> > > > early code overwrites the fw_args to look like the boot loader added a
> > > > device tree. This is done when CONFIG_MIPS_RAW_APPENDED_DTB is activated.
> > > > 
> > > > The problem is when we use an appended device tree and the boot loader
> > > > adds some important information in the kernel command line. In this case
> > > > the command line gets overwritten and we do not get this information.
> > > > This is the case for some lantiq devices were the boot loader provides
> > > > the mac address to the kernel via the kernel command line.
> > > > 
> > > > My proposal to solve this problem is to extend the interface and add a
> > > > option to provide the kernel command line *and* a device tree from the
> > > > boot loader to the kernel.
> > > > 
> > > > a) use fw_arg0 ($a0) = -2 and fill the unused registers fw_arg2 ($a2)
> > > > and fw_arg3 ($a3) with argv and envp.
> > > > 
> > > > b) add a new boot protocol $a0 = -3 with $a1 = DT address, $a2 = argv
> > > > and $a3 = envp.
> > > 
> > > I just looked a little bit more closely and saw that the command line
> > > uses 3 args. One for the count, one argv and one envp.
> > > 
> > > I would then only support device tree + count and argv, so the new
> > > interface would not support envp.
> > > 
> > > > 
> > > > I would prefer solution b).
> > > > 
> > > > This way we would not loose the kernel command line when appending a
> > > > device tree and this could also be used by the boot loader if someone
> > > > wants to.
> > > > 
> > > > Should I send a patch for this?
> > > > 
> > > > Hauke
> > 
> > It was because I looked through the above-linked UHI spec that I became
> > concerned about CONFIG_MIPS_RAW_APPENDED_DTB only mimicking, rather than
> > fully implementing, real UHI. In the upstream kernel, the new $a0 == -2
> > code can be a starting point for adding UHI argv/envp parsing for when a
> > UHI-compliant bootloader is used. However, on the head.S side, what I
> > propose for the lantiq target is to remove CONFIG_MIPS_RAW_APPENDED_DTB
> > from the kernel config, and reintroduce this as a platform patch:
> > https://github.com/openwrt/openwrt/blob/b3158f781f24ac2ec1c0da86479bfc156c52c80b/target/linux/lantiq/patches-4.4/0036-owrt-generic-dtb-image-hack.patch
> > The brcm63xx target could then retain CONFIG_MIPS_RAW_APPENDED_DTB, or
> > not, depending on bootloader specifics there, which I have not
> > investigated, and likewise the various other targets to which
> > CONFIG_MIPS_RAW_APPENDED_DTB has since been extended even though it was
> > apparently initially only an expedient hack only for brcm63xx.
> > 
> > Using $a0 = -3 is expressly prohibited in the above UHI document, and
> > using $a2/$a3 "would risk becoming incompatible with existing UHI
> > compliant implementations."
> 
> I have come up with a more elegant solution: Simply move the register
> substitution from head.S to just before it matters. You can still
> override the boot args using CONFIG_MIPS_CMDLINE_FROM_DTB.
> 
> Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
> ---
>  arch/mips/bmips/setup.c          |  7 +++++++
>  arch/mips/boot/compressed/head.S | 16 ----------------
>  arch/mips/include/asm/prom.h     |  5 +++++
>  arch/mips/kernel/head.S          | 16 ----------------
>  arch/mips/lantiq/prom.c          |  7 +++++++
>  5 files changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index f146d12..2711c36 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -160,6 +160,13 @@ void __init plat_mem_setup(void)
>  	ioport_resource.end = ~0;
>  
>  	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
> +#if defined(CONFIG_MIPS_RAW_APPENDED_DTB) ||\
> +		defined(CONFIG_MIPS_ZBOOT_APPENDED_DTB)
> +	if (be32_to_cpup((__be32 *)__appended_dtb) == 0xd00dfeed) {

We have too many 0xd00dfeed.
Can we introduce some macro aliases, like arch/arm/kernel/head-common.S does?
Something like this

#define OF_DT_MAGIC 0xd00dfeed

> +		fw_arg0 = -2;
> +		fw_arg1 = (unsigned long)__appended_dtb;
> +	}
> +#endif
>  	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
>  		dtb = phys_to_virt(fw_arg2);
>  	else if (fw_arg0 == -2) /* UHI interface */
> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index c580e85..409cb48 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -25,22 +25,6 @@ start:
>  	move	s2, a2
>  	move	s3, a3
>  
> -#ifdef CONFIG_MIPS_ZBOOT_APPENDED_DTB
> -	PTR_LA	t0, __appended_dtb
> -#ifdef CONFIG_CPU_BIG_ENDIAN
> -	li	t1, 0xd00dfeed
> -#else
> -	li	t1, 0xedfe0dd0
> -#endif
> -	lw	t2, (t0)
> -	bne	t1, t2, not_found
> -	 nop
> -
> -	move	s1, t0
> -	PTR_LI	s0, -2
> -not_found:
> -#endif
> -
>  	/* Clear BSS */
>  	PTR_LA	a0, _edata
>  	PTR_LA	a2, _end
> diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
> index 0b4b668..bd0c5fd 100644
> --- a/arch/mips/include/asm/prom.h
> +++ b/arch/mips/include/asm/prom.h
> @@ -28,6 +28,11 @@ extern int __dt_register_buses(const char *bus0, const char *bus1);
>  static inline void device_tree_init(void) { }
>  #endif /* CONFIG_OF */
>  
> +#if defined(CONFIG_MIPS_RAW_APPENDED_DTB) ||\
> +		defined(CONFIG_MIPS_ZBOOT_APPENDED_DTB)
> +extern const char __appended_dtb[];
> +#endif
> +
>  extern char *mips_get_machine_name(void);
>  extern void mips_set_machine_name(const char *name);
>  
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index 56e8fed..766205c 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -93,22 +93,6 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>  	jr	t0
>  0:
>  
> -#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
> -	PTR_LA		t0, __appended_dtb
> -
> -#ifdef CONFIG_CPU_BIG_ENDIAN
> -	li		t1, 0xd00dfeed
> -#else
> -	li		t1, 0xedfe0dd0
> -#endif
> -	lw		t2, (t0)
> -	bne		t1, t2, not_found
> -	 nop
> -
> -	move		a1, t0
> -	PTR_LI		a0, -2
> -not_found:
> -#endif
>  	PTR_LA		t0, __bss_start		# clear .bss
>  	LONG_S		zero, (t0)
>  	PTR_LA		t1, __bss_stop - LONGSIZE
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 5f693ac..f454b9d 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -74,6 +74,13 @@ void __init plat_mem_setup(void)
>  
>  	set_io_port_base((unsigned long) KSEG1);
>  
> +#if defined(CONFIG_MIPS_RAW_APPENDED_DTB) ||\
> +		defined(CONFIG_MIPS_ZBOOT_APPENDED_DTB)
> +	if (be32_to_cpup((__be32 *)__appended_dtb) == 0xd00dfeed) {
> +		fw_arg0 = -2;
> +		fw_arg1 = (unsigned long)__appended_dtb;
> +	}
> +#endif
>  	if (fw_arg0 == -2) /* UHI interface */
>  		dtb = (void *)fw_arg1;
>  	else if (__dtb_start != __dtb_end)
> -- 
> 1.9.1
> 

-- 
Best regards,
  Antony Pavlov
