Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 16:49:52 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:39378 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133954AbWESOto (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 May 2006 16:49:44 +0200
Received: (qmail 28208 invoked from network); 19 May 2006 18:56:34 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 19 May 2006 18:56:34 -0000
Message-ID: <446DDABE.2040105@ru.mvista.com>
Date:	Fri, 19 May 2006 18:48:30 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	Clem Taylor <clem.taylor@gmail.com>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: I2C troubles with Au1550
References: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com> <20060519143247.GC9596@cosmic.amd.com>
In-Reply-To: <20060519143247.GC9596@cosmic.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Jordan Crouse wrote:
>>Maybe Jordan could try again with a fresh patch because it really does
>>seem to help...

> Here you go, fresh out of the oven.. :)

> ------------------------------------------------------------------------
> 
> ALCHEMY:  AU1200 I2C modifications
> 
> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> Modifications to the existing AU1XXX I2C controller for the Au1200.
> 
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  arch/mips/au1000/db1x00/board_setup.c     |   37 +++++++++++++++++++++++++++++
>  drivers/i2c/busses/Kconfig                |    2 +-
>  drivers/i2c/busses/i2c-au1550.c           |   29 ++++++++++++++++++-----
>  include/asm-mips/mach-au1x00/au1xxx_psc.h |    7 +++++
>  4 files changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/au1000/db1x00/board_setup.c b/arch/mips/au1000/db1x00/board_setup.c
> index f00ec3b..a2638c8 100644
> --- a/arch/mips/au1000/db1x00/board_setup.c
> +++ b/arch/mips/au1000/db1x00/board_setup.c
> @@ -76,6 +76,43 @@ #if defined(CONFIG_IRDA) && (defined(CON
>  #endif
>  	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
>  
> +#if defined(CONFIG_I2C_AU1550) && defined(CONFIG_MIPS_DB1200)
> +	{
> +	u32 freq0, clksrc;
> +
> +	/* Select SMBUS in CPLD */
> +	bcsr->resets &= ~(BCSR_RESETS_PCS0MUX);
> +
> +	pin_func = au_readl(SYS_PINFUNC);
> +	au_sync();
> +	pin_func &= ~(3<<17 | 1<<4);
> +	/* Set GPIOs correctly */
> +	pin_func |= 2<<17;
> +	au_writel(pin_func, SYS_PINFUNC);
> +	au_sync();
> +
> +	/* The i2c driver depends on 50Mhz clock */
> +	freq0 = au_readl(SYS_FREQCTRL0);
> +	au_sync();
> +	freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
> +	freq0 |= (3<<SYS_FC_FRDIV1_BIT);
> +	/* 396Mhz / (3+1)*2 == 49.5Mhz */
> +	au_writel(freq0, SYS_FREQCTRL0);
> +	au_sync();
> +	freq0 |= SYS_FC_FE1;
> +	au_writel(freq0, SYS_FREQCTRL0);
> +	au_sync();
> +
> +	clksrc = au_readl(SYS_CLKSRC);
> +	au_sync();
> +	clksrc &= ~0x01f00000;
> +	/* bit 22 is EXTCLK0 for PSC0 */
> +	clksrc |= (0x3 << 22);
> +	au_writel(clksrc, SYS_CLKSRC);
> +	au_sync();
> +	}
> +#endif
> +
>  #ifdef CONFIG_MIPS_MIRAGE
>  	/* enable GPIO[31:0] inputs */
>  	au_writel(0, SYS_PININPUTEN);

    Alas, I have to NAK this. DBAu1200 code should be in 
arch/mips/au1000/pb1200/...

> diff --git a/include/asm-mips/mach-au1x00/au1xxx_psc.h b/include/asm-mips/mach-au1x00/au1xxx_psc.h
> index faa5ffe..a523079 100644
> --- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
> +++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
> @@ -48,6 +48,11 @@ #define PSC0_BASE_ADDR		0xb1a00000
>  #define PSC1_BASE_ADDR		0xb1b00000
>  #endif
>  
> +#ifdef CONFIG_SOC_AU1200
> +#define PSC0_BASE_ADDR         0xb1a00000
> +#define PSC1_BASE_ADDR         0xb1b00000
> +#endif
> +
>  /* The PSC select and control registers are common to
>   * all protocols.
>   */

    Well, I have already submitted this change this March, here's the patch:

http://www.linux-mips.org/archives/linux-mips/2006-03/msg00245.html

  . As usual, Ralf is not eager to commit my patches... :-/
    Thou wait... that hunk won't even aplly to the current git tree... Looks 
like this patch is trying to redeclare PSC base addresses for Au1200 on top of 
my patch... If it's so, NAK.

WBR, Sergei
