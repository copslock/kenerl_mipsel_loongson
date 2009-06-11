Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 17:29:25 +0200 (CEST)
Received: from rv-out-0708.google.com ([209.85.198.251]:19171 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493033AbZFKP3T (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2009 17:29:19 +0200
Received: by rv-out-0708.google.com with SMTP id l33so345541rvb.24
        for <multiple recipients>; Thu, 11 Jun 2009 08:29:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=cOJQDAeyEA7yJC1+AvB5rnac4FG3UcurlbYmyRRIggA=;
        b=ssD1gc4dgEor/eGBz8NGlEZnTyIPoMSncnzXb4PCx5PPIr4qBJBZlY+k9McbhkWi08
         YztNyvUX/p6zYDIFVNZ39u0cNZScoC17XWZExS54Mc8nNxKdJsd+NjQXQcDYte9443co
         WFtrVO2x0VfwV+ogCmdW/9Ny6kUBDfBzRsU/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=TCk5+4p+1TI4nKwPsrpYqWzhEedhpAHZOXOmQEch3uo0IlPmNuUtC2dwrTQw1WZxqF
         odBKD33/EmLkyYvH6zSPKdjcP+Cq8HmOxJQZ0k+uojyKdKXrNgWSQ1LaDiV2nP661Y33
         W5vKQslFhrom40nOqgPirIOVKmrFC3d4WGghY=
Received: by 10.141.42.20 with SMTP id u20mr2125542rvj.136.1244730584709;
        Thu, 11 Jun 2009 07:29:44 -0700 (PDT)
Received: from ?192.168.1.103? ([219.246.59.144])
        by mx.google.com with ESMTPS id k37sm348175rvb.8.2009.06.11.07.29.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 07:29:41 -0700 (PDT)
Subject: Re: [loongson-dev] Re: [loongson-PATCH-v3 17/25] add a machtype
 kernel command line argument
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
In-Reply-To: <20090610203123.GA20906@adriano.hkcable.com.hk>
References: <cover.1244120575.git.wuzj@lemote.com>
	 <d1f4caa360114f843459dc71827b1175232a24be.1244120575.git.wuzj@lemote.com>
	 <20090610154032.GB21877@adriano.hkcable.com.hk>
	 <20090610203123.GA20906@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 11 Jun 2009 22:28:38 +0800
Message-Id: <1244730518.10475.38.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Applied, thanks!

but before you sending this patch, I have tuned the machtype
implementation(mainly remove the duplicated MACHNAME defined in
machine.h) and merged some patches, so, this patch can not be applied
directly, but i have applied it manually. and also, i will merge it to
my previous machtype patches.

thanks!
Wu Zhangjin

On Thu, 2009-06-11 at 04:31 +0800, Zhang Le wrote:
> So this is the patch. I should say this patch is a bit intrusive againt your
> verion. But I think I could justify the changes.
> 
> 1. MACHNAME macro seems to be a little over engineered. And with MACHNAME,
>    system type becomes "lemote-fuloong-2f-unknowninch" which does not make much
>    sense. So I removed it. As a result, include/asm/mach-loongson/machtype.h is
>    not needed anymore. I also modified loongson/yeeloong-2f/{init,reset}.c,
>    because _89INCH and _7INCH no longer exist.
> 
> 2. 3 machine names are defined twice, once in loongson/common/machtype.c, once
>    in include/asm/mach-loongson/machine.h. In my patch, all the system types are
>    defined in loongson/common/machtype.c, as an array called system_types. Other
>    loongson based machine, like Gdium, could add their system type to this array.
> 
> 3. I defined symbolic names for the system_types array's index. In
>    include/asm/mach-loongson/machine.h, I defined macro MACHTYPE using these
>    symbolic names, so that we can get system type from system_types array
>    using MACHTYPE as index.
> 
> 4. Add NULL to the end of system_types array, so MACHTYPE_TOTAL is not needed.
> 
> 5. mips_machtype already has initial value MACH_UNKNOWN, so MACHTYPE_DEFAULT is
>    not needed.
> 
> 6. modified the for loop in machtype_setup accordingly.
> 
> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> ---
>  arch/mips/include/asm/bootinfo.h               |   11 +++++
>  arch/mips/include/asm/mach-loongson/machine.h  |    8 ++--
>  arch/mips/include/asm/mach-loongson/machtype.h |   32 ---------------
>  arch/mips/loongson/common/machtype.c           |   50 ++++++++++-------------
>  arch/mips/loongson/yeeloong-2f/init.c          |    3 +-
>  arch/mips/loongson/yeeloong-2f/reset.c         |    7 ++-
>  6 files changed, 42 insertions(+), 69 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson/machtype.h
> 
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
> index 610fe3a..0d9c7ff 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -7,6 +7,7 @@
>   * Copyright (C) 1995, 1996 Andreas Busse
>   * Copyright (C) 1995, 1996 Stoned Elipot
>   * Copyright (C) 1995, 1996 Paul M. Antoine.
> + * Copyright (C) 2009       Zhang Le
>   */
>  #ifndef _ASM_BOOTINFO_H
>  #define _ASM_BOOTINFO_H
> @@ -57,6 +58,16 @@
>  #define	MACH_MIKROTIK_RB532	0	/* Mikrotik RouterBoard 532 	*/
>  #define MACH_MIKROTIK_RB532A	1	/* Mikrotik RouterBoard 532A 	*/
>  
> +/*
> + * Valid machtype for group Loongson
> + */
> +#define MACH_LOONGSON_UNKNOWN	0
> +#define MACH_LEMOTE_FL2E	1
> +#define MACH_LEMOTE_FL2F	2
> +#define MACH_LEMOTE_YL2F89	3
> +#define MACH_LEMOTE_YL2F7	4
> +#define MACH_LOONGSON_END	5
> +
>  #define CL_SIZE			COMMAND_LINE_SIZE
>  
>  extern char *system_type;
> diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
> index 8109a9e..e168625 100644
> --- a/arch/mips/include/asm/mach-loongson/machine.h
> +++ b/arch/mips/include/asm/mach-loongson/machine.h
> @@ -2,6 +2,7 @@
>   * board-specific header file
>   *
>   * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
> + * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
>   *
>   * This program is free software; you can redistribute it
>   * and/or modify it under the terms of the GNU General
> @@ -15,7 +16,7 @@
>  
>  #ifdef CONFIG_LEMOTE_FULOONG2E
>  
> -#define MACH_NAME	MACHNAME(LEMOTE, FULOONG, LOONGSON_2E, UNKNOWN)
> +#define MACHTYPE	MACH_LEMOTE_FL2E
>  
>  #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x3f8)
>  #define	LOONGSON_UART_BAUD		1843200
> @@ -29,7 +30,7 @@
>  
>  #elif defined(CONFIG_LEMOTE_FULOONG2F)
>  
> -#define MACH_NAME	MACHNAME(LEMOTE, FULOONG, LOONGSON_2F, UNKNOWN)
> +#define MACHTYPE	MACH_LEMOTE_FL2F
>  
>  #define LOONGSON_UART_BASE		(LOONGSON_PCIIO_BASE + 0x2f8)
>  #define LOONGSON_UART_BAUD		1843200
> @@ -37,8 +38,7 @@
>  
>  #else /* CONFIG_CPU_YEELOONG2F */
>  
> -/* by default, set it as 8.9INCH? or UNKNOWN? */
> -#define MACH_NAME	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _89INCH)
> +#define MACHTYPE	MACH_LEMOTE_YL2F89
>  
>  /* yeeloong use the CPU serial port of Loongson2F */
>  #define LOONGSON_UART_BASE		(LOONGSON_LIO1_BASE + 0x3f8)
> diff --git a/arch/mips/include/asm/mach-loongson/machtype.h b/arch/mips/include/asm/mach-loongson/machtype.h
> deleted file mode 100644
> index 9f96926..0000000
> --- a/arch/mips/include/asm/mach-loongson/machtype.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/*
> - * machine type header file
> - */
> -
> -#ifndef _MACHTYPE_H
> -#define _MACHTYPE_H
> -
> -#define UNKNOWN		"unknown"
> -
> -/* company */
> -#define LEMOTE		"lemote"
> -#define DEXOON		"dexoon"
> -
> -/* product */
> -#define FULOONG		"fuloong"
> -#define YEELOONG	"yeeloong"
> -#define	GDIUM		"gdium"
> -
> -/* cpu revision */
> -#define LOONGSON_2E			"2e"
> -#define LOONGSON_2F 		"2f"
> -
> -/* size */
> -#define _7INCH			"7"
> -#define	_89INCH			"8.9"
> -
> -#define MACHNAME_LEN	50
> -
> -#define MACHNAME(company, product, cpu, size) \
> -	(company "-" product "-" cpu "-" size "inch\0")
> -
> -#endif /* ! _MACHTYPE_H */
> diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
> index d469dc7..34417cf 100644
> --- a/arch/mips/loongson/common/machtype.c
> +++ b/arch/mips/loongson/common/machtype.c
> @@ -2,6 +2,8 @@
>   * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
>   * Author: Wu Zhangjin, wuzj@lemote.com
>   *
> + * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
> + *
>   * This program is free software; you can redistribute  it and/or modify it
>   * under  the terms of  the GNU General  Public License as published by the
>   * Free Software Foundation;  either version 2 of the  License, or (at your
> @@ -10,49 +12,41 @@
>  
>  #include <linux/errno.h>
>  #include <asm/cpu.h>
> -
>  #include <asm/bootinfo.h>
>  
>  #include <loongson.h>
> -#include <machtype.h>
>  #include <machine.h>
>  
> -static char machname[][MACHNAME_LEN] = {
> -	MACHNAME(LEMOTE, FULOONG, LOONGSON_2E, UNKNOWN),
> -	MACHNAME(LEMOTE, FULOONG, LOONGSON_2F, UNKNOWN),
> -	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _89INCH),
> -	MACHNAME(LEMOTE, YEELOONG, LOONGSON_2F, _7INCH),
> +static const char *system_types[] = {
> +	[MACH_LOONGSON_UNKNOWN]		"unknown loongson machine",
> +	[MACH_LEMOTE_FL2E]		"lemote-fuloong-2e-box",
> +	[MACH_LEMOTE_FL2F]		"lemote-fuloong-2f-box",
> +	[MACH_LEMOTE_YL2F89]		"lemote-yeeloong-2f-8.9inches",
> +	[MACH_LEMOTE_YL2F7]		"lemote-yeeloong-2f-7inches",
> +	[MACH_LOONGSON_END]		NULL,
>  };
>  
> -#define MACHTYPE_TOTAL	(sizeof(machname)/MACHNAME_LEN)
> -#define MACHTYPE_DEFAULT	-1
> -
>  const char *get_system_type(void)
>  {
> -	if (mips_machtype == MACHTYPE_DEFAULT)
> -		return MACH_NAME;
> -	else
> -		return machname[mips_machtype];
> +	if (mips_machtype == MACH_UNKNOWN)
> +		mips_machtype = MACHTYPE;
> +
> +	return system_types[mips_machtype];
>  }
>  
> -static __init int machname_setup(char *str)
> +static __init int machtype_setup(char *str)
>  {
> -	int index;
> +	int machtype = MACH_LEMOTE_FL2E;
>  
>  	if (!str)
> -			return -EINVAL;
> -
> -	mips_machtype = MACHTYPE_DEFAULT;
> +		return -EINVAL;
>  
> -	for (index = 0;
> -	     index < MACHTYPE_TOTAL;
> -	     index++) {
> -		if (strstr(str, machname[index]) != NULL) {
> -			mips_machtype = index;
> -			return 0;
> +	for (; system_types[machtype]; machtype++)
> +		if (strstr(str, system_types[machtype])) {
> +			mips_machtype = machtype;
> +			break;
>  		}
> -	}
> -	return -1;
> +	return 0;
>  }
>  
> -__setup("machtype=", machname_setup);
> +__setup("machtype=", machtype_setup);
> diff --git a/arch/mips/loongson/yeeloong-2f/init.c b/arch/mips/loongson/yeeloong-2f/init.c
> index 80f8c5e..5d16e66 100644
> --- a/arch/mips/loongson/yeeloong-2f/init.c
> +++ b/arch/mips/loongson/yeeloong-2f/init.c
> @@ -18,7 +18,6 @@
>  #include <asm/bootinfo.h>
>  
>  #include <cs5536/cs5536.h>
> -#include <machtype.h>
>  
>  void __init mach_prom_init_cmdline(void)
>  {
> @@ -77,6 +76,6 @@ void __init mach_prom_init_cmdline(void)
>  
>  	if ((strstr(arcs_cmdline, "vga") == NULL)
>  			&& (strstr(arcs_cmdline, "machtype") != NULL)
> -				&& (strstr(arcs_cmdline, _7INCH) != NULL))
> +				&& (strstr(arcs_cmdline, "7inch") != NULL))
>  		strcat(arcs_cmdline, " vga=800x480x24");
>  }
> diff --git a/arch/mips/loongson/yeeloong-2f/reset.c b/arch/mips/loongson/yeeloong-2f/reset.c
> index 124cf99..46394c2 100644
> --- a/arch/mips/loongson/yeeloong-2f/reset.c
> +++ b/arch/mips/loongson/yeeloong-2f/reset.c
> @@ -15,7 +15,6 @@
>  
>  #include <loongson.h>
>  #include <machine.h>
> -#include <machtype.h>
>  
>  /*
>   * The following registers are determined by the EC index configuration.
> @@ -59,12 +58,14 @@ void mach_prepare_reboot(void)
>  
>  void mach_prepare_shutdown(void)
>  {
> -	if (strstr(get_system_type(), _89INCH)) {
> +	char *system_type = get_system_type();
> +
> +	if (strstr(system_type, "8.9inch")) {
>  		/* cpu-gpio0 output low */
>  		LOONGSON_GPIODATA &= ~0x00000001;
>  		/* cpu-gpio0 as output */
>  		LOONGSON_GPIOIE &= ~0x00000001;
> -	} else if (strstr(get_system_type(), _7INCH)) {
> +	} else if (strstr(system_type, "7inch")) {
>  		u8 val;
>  		u64 i;
>  
> -- 
> 1.6.3.1
> 
> 
