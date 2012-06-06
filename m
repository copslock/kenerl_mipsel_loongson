Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 14:22:19 +0200 (CEST)
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1053 "EHLO
        smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903708Ab2FFMWN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 14:22:13 +0200
Received: (qmail 19790 invoked by uid 0); 6 Jun 2012 12:15:31 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 18612
Received: from p5491e52a.dip.t-dialin.net (HELO ?192.168.0.176?) [84.145.229.42]
  by 217.119.54.77 with AES256-SHA encrypted SMTP; 6 Jun 2012 12:15:31 -0000
Message-ID: <4FCF4A99.7090501@metafoo.de>
Date:   Wed, 06 Jun 2012 14:18:33 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 13/35] MIPS: jz4740: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-14-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-14-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/05/2012 11:19 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Make headers consistent across the files and make changes based on
> running the checkpatch script.

Why is the cleanup not in the inital patch?

> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/jz4740/prom.c |   25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index c5071ab..ea86605 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -1,23 +1,14 @@
>  /*
> - *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
> - *  JZ4740 SoC prom code
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>   *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under  the terms of the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> + *  JZ4740 SoC prom code
>   *
> + *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
> + *  Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>   */

Please don't randomly change the license of files.

> -
>  #include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/string.h>
> -

Why can't this be in the previous patch which removed the custom fw args parser?

>  #include <linux/serial_reg.h>
>  
>  #include <asm/fw/fw.h>
> @@ -33,7 +24,9 @@ void __init prom_free_prom_memory(void)
>  {
>  }
>  
> -#define UART_REG(_reg) ((void __iomem *)CKSEG1ADDR(JZ4740_UART0_BASE_ADDR + (_reg << 2)))
> +#define UART_REG(_reg)							\
> +	((volatile void __iomem *)CKSEG1ADDR(JZ4740_UART0_BASE_ADDR +	\
> +	(_reg << 2)))
>  

Why did you add volatile here?

>  void prom_putchar(char c)
>  {
