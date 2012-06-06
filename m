Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 14:10:27 +0200 (CEST)
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1110 "EHLO
        smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903702Ab2FFMKX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 14:10:23 +0200
Received: (qmail 14120 invoked by uid 0); 6 Jun 2012 12:10:13 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 14017
Received: from p5491e52a.dip.t-dialin.net (HELO ?192.168.0.176?) [84.145.229.42]
  by 217.119.54.77 with AES256-SHA encrypted SMTP; 6 Jun 2012 12:10:12 -0000
Message-ID: <4FCF4973.8090907@metafoo.de>
Date:   Wed, 06 Jun 2012 14:13:39 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 12/35] MIPS: jz4740: Cleanup firmware support for the
 JZ4740 platform.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-13-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-13-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33570
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
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  arch/mips/jz4740/prom.c |   25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index 4a70407..c5071ab 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -20,33 +20,12 @@
>  
>  #include <linux/serial_reg.h>
>  
> -#include <asm/bootinfo.h>
> +#include <asm/fw/fw.h>
>  #include <asm/mach-jz4740/base.h>
>  
> -static __init void jz4740_init_cmdline(int argc, char *argv[])
> -{
> -	unsigned int count = COMMAND_LINE_SIZE - 1;
> -	int i;
> -	char *dst = &(arcs_cmdline[0]);
> -	char *src;
> -
> -	for (i = 1; i < argc && count; ++i) {
> -		src = argv[i];
> -		while (*src && count) {
> -			*dst++ = *src++;
> -			--count;
> -		}
> -		*dst++ = ' ';
> -	}
> -	if (i > 1)
> -		--dst;
> -
> -	*dst = 0;
> -}
> -
>  void __init prom_init(void)
>  {
> -	jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
> +	fw_init_cmdline();
>  	mips_machtype = MACH_INGENIC_JZ4740;
>  }
>  
