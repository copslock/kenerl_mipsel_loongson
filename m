Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 19:32:30 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:55589 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903659Ab2EKRcX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 19:32:23 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4BHWFxl017436;
        Fri, 11 May 2012 10:32:16 -0700
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.01.0270.001; Fri, 11 May 2012
 10:32:11 -0700
From:   "Yegoshin, Leonid" <yegoshin@mips.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Add MIPS64R2 core support.
Thread-Topic: [PATCH v2] Add MIPS64R2 core support.
Thread-Index: AQHNLz96CllJsX0FZEaOw1mYtE0YCZbFTREA//+MbJA=
Date:   Fri, 11 May 2012 17:32:09 +0000
Message-ID: <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>
References: <1336717784-853-1-git-send-email-sjhill@mips.com>,<4FAD4B9E.70803@mvista.com>
In-Reply-To: <4FAD4B9E.70803@mvista.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: M2JPTvUstxbSveHWuXv2PA==
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-archive-position: 33264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Not exactly - it adds 64R2 support in Malta, plus small verification that build kernel could run 32bit binaries.

I don't think it has sense to multiply patches here, there is no sense to have this separated.

5KEc is just test-bed.


Sergei Shtylyov <sshtylyov@mvista.com> wrote:


On 05/11/2012 10:29 AM, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

    Looks like the subject is incorrect. Should be "Add MIPS 5KE support"?

> Signed-off-by: Leonid Yegoshin<yegoshin@mips.com>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
[...]

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index d0570f4..862a9c3 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -282,6 +282,7 @@ config MIPS_MALTA
>       select SYS_HAS_CPU_MIPS32_R1
>       select SYS_HAS_CPU_MIPS32_R2
>       select SYS_HAS_CPU_MIPS64_R1
> +     select SYS_HAS_CPU_MIPS64_R2
>       select SYS_HAS_CPU_NEVADA
>       select SYS_HAS_CPU_RM7000
>       select SYS_HAS_EARLY_PRINTK
> @@ -2488,6 +2489,7 @@ config TRAD_SIGNALS
>   config MIPS32_COMPAT
>       bool "Kernel support for Linux/MIPS 32-bit binary compatibility"
>       depends on 64BIT
> +     default y if CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
>       help
>         Select this option if you want Linux/MIPS 32-bit binary
>         compatibility. Since all software available for Linux/MIPS is
> @@ -2507,6 +2509,7 @@ config SYSVIPC_COMPAT
>   config MIPS32_O32
>       bool "Kernel support for o32 binaries"
>       depends on MIPS32_COMPAT
> +     default y if CPU_SUPPORTS_32BIT_KERNEL&&  SYS_SUPPORTS_32BIT_KERNEL
>       help
>         Select this option if you want to run o32 binaries.  These are pure
>         32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
> @@ -2525,6 +2528,10 @@ config MIPS32_N32
>
>         If unsure, say N.
>
> +comment "64bit kernel, but support of 32bit applications is disabled!"
> +     depends on 64BIT&&  !MIPS32_O32&&  !MIPS32_N32
> +     depends on CPU_SUPPORTS_32BIT_KERNEL&&  SYS_SUPPORTS_32BIT_KERNEL
> +

    The above looks like a material for separate patch...

WBR, Sergei
