Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 18:19:39 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:57498 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20022716AbXDHRTh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Apr 2007 18:19:37 +0100
Received: (qmail 29981 invoked from network); 8 Apr 2007 17:19:32 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2007 17:19:32 -0000
Message-ID: <4619245F.4030704@ru.mvista.com>
Date:	Sun, 08 Apr 2007 21:20:31 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
References: <20070408113457.GB7553@alpha.franken.de>
In-Reply-To: <20070408113457.GB7553@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> PCI host bridge setup for SNI RM machines with PCI is quite broken, now that
> Linux does it's resource setup own its own. It will use IO addresses,
> which are needed by the EISA config detection and assigns PCI memory
> addresses, which overlap with ISA legacy addresses (video ram). Below
> is a patch, which changes the way how the PCI memory addresses are
> used and sets the minimum IO address to give enough IO space for
> 8 EISA slots). This patch needs the other PCI resource change, I've
> posted.

> diff --git a/arch/mips/sni/pcit.c b/arch/mips/sni/pcit.c
> index 1dfc3f0..00d151f 100644
> --- a/arch/mips/sni/pcit.c
> +++ b/arch/mips/sni/pcit.c
> @@ -43,7 +43,7 @@ static struct platform_device pcit_serial8250_device = {
>  };
>  
>  static struct plat_serial8250_port pcit_cplus_data[] = {
> -	PORT(0x3f8, 4),
> +	PORT(0x3f8, 0),
>  	PORT(0x2f8, 3),
>  	PORT(0x3e8, 4),
>  	PORT(0x2e8, 3),

    Hm, what is that -- UART #1 without IRQ?

> @@ -59,9 +59,9 @@ static struct platform_device pcit_cplus_serial8250_device = {
>  };
> 
>  static struct resource sni_io_resource = {
> -	.start	= 0x00001000UL,
> +	.start	= 0x00000000UL,
>  	.end	= 0x03bfffffUL,
> -	.name	= "PCIT IO MEM",
> +	.name	= "PCIT IO",
>  	.flags	= IORESOURCE_IO,
>  };

    Why us this necessary, only beacuse compatible peripherals are behind PCI?
EISA is behind PCI as well, yet you're setting PCIBIOS_MIN_IO to 0x9000. Does 
this all really make sense? :-/

> @@ -92,6 +92,11 @@ static struct resource pcit_io_resources[] = {
>  		.name	= "dma2",
>  		.flags	= IORESOURCE_BUSY
>  	}, {
> +		.start	=  0xcf8,
> +		.end	= 0xcfb,
> +		.name	= "PCI config addr",
> +		.flags	= IORESOURCE_BUSY
> +	}, {

    This is certainly *not* a PCI or [E]ISA resource. It's decoded by the 
*host* bridge.

>  		.start	=  0xcfc,
>  		.end	= 0xcff,
>  		.name	= "PCI config data",

    Well, why not just join them into one?

>  void sni_pcit_init(void)
>  {
> -	sni_pcit_resource_init();
>  	rtc_mips_get_time = mc146818_get_cmos_time;
>  	rtc_mips_set_time = mc146818_set_rtc_mmss;
>  	board_time_init = sni_cpu_time_init;
> +	ioport_resource.end = sni_io_resource.end;
>  #ifdef CONFIG_PCI
> +	PCIBIOS_MIN_IO = 0x9000;
>  	register_pci_controller(&sni_pcit_controller);
>  #endif
> +	sni_pcit_resource_init();
>  }

WBR, Sergei
