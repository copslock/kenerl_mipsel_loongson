Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 02:37:13 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:4033 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1495728AbZLVBhI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 02:37:08 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAFmxL0urRN+J/2dsb2JhbADAI5ZBhC4E
X-IronPort-AV: E=Sophos;i="4.47,434,1257120000"; 
   d="scan'208";a="123481653"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 22 Dec 2009 01:37:01 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBM1b1o9008149;
        Tue, 22 Dec 2009 01:37:01 GMT
Date:   Mon, 21 Dec 2009 17:37:01 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/5] MIPS: simplify powertv prom_init_cmdline() and
        merge to prom_init()
Message-ID: <20091222013701.GE24784@dvomlehn-lnx2.corp.sa.net>
References: <20091218212917.f42e8180.yuasa@linux-mips.org> <20091218213018.79a9fc11.yuasa@linux-mips.org> <20091218213346.01f63eac.yuasa@linux-mips.org> <20091218213632.7d5b0037.yuasa@linux-mips.org> <20091218213837.270d3854.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091218213837.270d3854.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 18, 2009 at 09:38:37PM +0900, Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/powertv/Makefile  |    2 +-
>  arch/mips/powertv/cmdline.c |   47 -------------------------------------------
>  arch/mips/powertv/init.c    |   15 ++++++++-----
>  arch/mips/powertv/init.h    |    2 -
>  4 files changed, 10 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/mips/powertv/cmdline.c
> 
> diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
> index 2c51671..0a0d73c 100644
> --- a/arch/mips/powertv/Makefile
> +++ b/arch/mips/powertv/Makefile
> @@ -23,6 +23,6 @@
>  # under Linux.
>  #
>  
> -obj-y += cmdline.o init.o memory.o reset.o time.o powertv_setup.o asic/ pci/
> +obj-y += init.o memory.o reset.o time.o powertv_setup.o asic/ pci/
>  
>  EXTRA_CFLAGS += -Wall -Werror
> diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
> deleted file mode 100644
> index ee7ab47..0000000
> --- a/arch/mips/powertv/cmdline.c
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -/*
> - * Carsten Langgaard, carstenl@mips.com
> - * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> - * Portions copyright (C) 2009 Cisco Systems, Inc.
> - *
> - * This program is free software; you can distribute it and/or modify it
> - * under the terms of the GNU General Public License (Version 2) as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> - * for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> - *
> - * Kernel command line creation using the prom monitor (YAMON) argc/argv.
> - */
> -#include <linux/init.h>
> -#include <linux/string.h>
> -
> -#include <asm/bootinfo.h>
> -
> -#include "init.h"
> -
> -/*
> - * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
> - * This macro take care of sign extension.
> - */
> -#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
> -
> -void  __init prom_init_cmdline(void)
> -{
> -	int len;
> -
> -	if (prom_argc != 1)
> -		return;
> -
> -	len = strlen(arcs_cmdline);
> -
> -	arcs_cmdline[len] = ' ';
> -
> -	strlcpy(arcs_cmdline + len + 1, (char *)_prom_argv,
> -		COMMAND_LINE_SIZE - len - 1);
> -}
> diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
> index 5f4e4c3..de0e46a 100644
> --- a/arch/mips/powertv/init.c
> +++ b/arch/mips/powertv/init.c
> @@ -34,10 +34,7 @@
>  #include <asm/mips-boards/generic.h>
>  #include <asm/mach-powertv/asic.h>
>  
> -#include "init.h"
> -
> -int prom_argc;
> -int *_prom_argv, *_prom_envp;
> +static int *_prom_envp;
>  unsigned long _prom_memsize;
>  
>  /*
> @@ -109,8 +106,11 @@ static void __init mips_ejtag_setup(void)
>  
>  void __init prom_init(void)
>  {
> +	int prom_argc;
> +	char *prom_argv;
> +
>  	prom_argc = fw_arg0;
> -	_prom_argv = (int *) fw_arg1;
> +	prom_argv = (char *) fw_arg1;
>  	_prom_envp = (int *) fw_arg2;
>  	_prom_memsize = (unsigned long) fw_arg3;
>  
> @@ -118,7 +118,10 @@ void __init prom_init(void)
>  	board_ejtag_handler_setup = mips_ejtag_setup;
>  
>  	pr_info("\nLINUX started...\n");
> -	prom_init_cmdline();
> +
> +	if (prom_argc == 1)
> +		strlcat(arcs_cmdline, prom_argv, COMMAND_LINE_SIZE);
> +
>  	configure_platform();
>  	prom_meminit();
>  
> diff --git a/arch/mips/powertv/init.h b/arch/mips/powertv/init.h
> index 7af6bf2..b194c34 100644
> --- a/arch/mips/powertv/init.h
> +++ b/arch/mips/powertv/init.h
> @@ -22,7 +22,5 @@
>  
>  #ifndef _POWERTV_INIT_H
>  #define _POWERTV_INIT_H
> -extern int prom_argc;
> -extern int *_prom_argv;
>  extern unsigned long _prom_memsize;
>  #endif
> -- 
> 1.6.5.7
> 
> 

And, for the final time, this looks good, too, and thanks! (And sorry for the
duplicate replies)
Reviewed-by: David VomLehn (dvomlehn@cisco.com)
