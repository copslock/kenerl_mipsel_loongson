Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 17:43:46 +0000 (GMT)
Received: from blu139-omc1-s2.blu139.hotmail.com ([65.55.175.142]:39560 "EHLO
	blu139-omc1-s2.blu139.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20025054AbXLJRnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Dec 2007 17:43:37 +0000
Received: from BLU127-W16 ([65.55.162.181]) by blu139-omc1-s2.blu139.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Dec 2007 09:43:09 -0800
Message-ID: <BLU127-W1655DCD5A946AF12DE533E8A6B0@phx.gbl>
X-Originating-IP: [157.185.36.161]
From:	Nathan Eggan <nathan_eggan@live.com>
To:	linux-mips mailing list <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Alchemy: fix PCI resource conflict (take 2)
Date:	Mon, 10 Dec 2007 17:43:09 +0000
Importance: Normal
In-Reply-To: <200712102028.51448.sshtylyov@ru.mvista.com>
References: <200712102028.51448.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 10 Dec 2007 17:43:09.0186 (UTC) FILETIME=[20B19620:01C83B54]
Return-Path: <nathan_eggan@live.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan_eggan@live.com
Precedence: bulk
X-list: linux-mips



Any chance this will help fix my Au1x00 serial + USB issues?  I know the old PCI bus code used to not work with the USB - at least the two could not run together.  It's been a while since I looked at those issues, so that may have been resolved long ago.

Just curious,
Thanks!
Nate

----------------------------------------
> From: sshtylyov@ru.mvista.com
> To: ralf@linux-mips.org
> Subject: [PATCH] Alchemy: fix PCI resource conflict (take 2)
> Date: Mon, 10 Dec 2007 20:28:51 +0300
> CC: linux-mips@linux-mips.org
> 
> ... by getting the PCI resources back into the 32-bit range -- there's no need
> therefore for CONFIG_RESOURCES_64BIT either. This makes Alchemy PCI work again
> while currently the kernel skips the bus scan.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
>  arch/mips/au1000/Kconfig              |    9 ---------
>  arch/mips/au1000/common/pci.c         |    8 ++++----
>  include/asm-mips/mach-au1x00/au1000.h |    9 +++++----
>  3 files changed, 9 insertions(+), 17 deletions(-)
> 
> Index: linux-2.6/arch/mips/au1000/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/mips/au1000/Kconfig
> +++ linux-2.6/arch/mips/au1000/Kconfig
> @@ -7,7 +7,6 @@ config MIPS_MTX1
>  	bool "4G Systems MTX-1 board"
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
> -	select RESOURCES_64BIT if PCI
>  	select SOC_AU1500
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
> @@ -22,7 +21,6 @@ config MIPS_DB1000
>  	select SOC_AU1000
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
> -	select RESOURCES_64BIT if PCI
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
>  config MIPS_DB1100
> @@ -44,7 +42,6 @@ config MIPS_DB1500
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
>  	select MIPS_DISABLE_OBSOLETE_IDE
> -	select RESOURCES_64BIT if PCI
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
> @@ -54,7 +51,6 @@ config MIPS_DB1550
>  	select HW_HAS_PCI
>  	select DMA_NONCOHERENT
>  	select MIPS_DISABLE_OBSOLETE_IDE
> -	select RESOURCES_64BIT if PCI
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
>  config MIPS_MIRAGE
> @@ -68,7 +64,6 @@ config MIPS_PB1000
>  	select SOC_AU1000
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
> -	select RESOURCES_64BIT if PCI
>  	select SWAP_IO_SPACE
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
> @@ -77,7 +72,6 @@ config MIPS_PB1100
>  	select SOC_AU1100
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
> -	select RESOURCES_64BIT if PCI
>  	select SWAP_IO_SPACE
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
> @@ -86,7 +80,6 @@ config MIPS_PB1200
>  	select SOC_AU1200
>  	select DMA_NONCOHERENT
>  	select MIPS_DISABLE_OBSOLETE_IDE
> -	select RESOURCES_64BIT if PCI
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
>  config MIPS_PB1500
> @@ -94,7 +87,6 @@ config MIPS_PB1500
>  	select SOC_AU1500
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
> -	select RESOURCES_64BIT if PCI
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
>  config MIPS_PB1550
> @@ -103,7 +95,6 @@ config MIPS_PB1550
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
>  	select MIPS_DISABLE_OBSOLETE_IDE
> -	select RESOURCES_64BIT if PCI
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  
>  config MIPS_XXS1500
> Index: linux-2.6/arch/mips/au1000/common/pci.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/au1000/common/pci.c
> +++ linux-2.6/arch/mips/au1000/common/pci.c
> @@ -39,15 +39,15 @@
>  
>  /* TBD */
>  static struct resource pci_io_resource = {
> -	.start	= (resource_size_t)PCI_IO_START,
> -	.end	= (resource_size_t)PCI_IO_END,
> +	.start	= PCI_IO_START,
> +	.end	= PCI_IO_END,
>  	.name	= "PCI IO space",
>  	.flags	= IORESOURCE_IO
>  };
>  
>  static struct resource pci_mem_resource = {
> -	.start	= (resource_size_t)PCI_MEM_START,
> -	.end	= (resource_size_t)PCI_MEM_END,
> +	.start	= PCI_MEM_START,
> +	.end	= PCI_MEM_END,
>  	.name	= "PCI memory space",
>  	.flags	= IORESOURCE_MEM
>  };
> Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
> ===================================================================
> --- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
> +++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
> @@ -1680,10 +1680,11 @@ enum soc_au1200_ints {
>  #define Au1500_PCI_MEM_START      0x440000000ULL
>  #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
>  
> -#define PCI_IO_START    (Au1500_PCI_IO_START + 0x1000)
> -#define PCI_IO_END      (Au1500_PCI_IO_END)
> -#define PCI_MEM_START   (Au1500_PCI_MEM_START)
> -#define PCI_MEM_END     (Au1500_PCI_MEM_END)
> +#define PCI_IO_START	0x00001000
> +#define PCI_IO_END	0x000FFFFF
> +#define PCI_MEM_START	0x40000000
> +#define PCI_MEM_END	0x4FFFFFFF
> +
>  #define PCI_FIRST_DEVFN (0<<3)
>  #define PCI_LAST_DEVFN  (19<<3)
>  
> 
> 

_________________________________________________________________
Connect and share in new ways with Windows Live.
http://www.windowslive.com/connect.html?ocid=TXT_TAGLM_Wave2_newways_112007
From sshtylyov@ru.mvista.com Mon Dec 10 17:47:46 2007
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 17:47:55 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:61635 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20025092AbXLJRrq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Dec 2007 17:47:46 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 7C24D3ECD; Mon, 10 Dec 2007 09:47:43 -0800 (PST)
Message-ID: <475D7BD4.1050505@ru.mvista.com>
Date:	Mon, 10 Dec 2007 20:48:04 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Nathan Eggan <nathan_eggan@live.com>
Cc:	linux-mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Alchemy: fix PCI resource conflict (take 2)
References: <200712102028.51448.sshtylyov@ru.mvista.com> <BLU127-W1655DCD5A946AF12DE533E8A6B0@phx.gbl>
In-Reply-To: <BLU127-W1655DCD5A946AF12DE533E8A6B0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Nathan Eggan wrote:

> Any chance this will help fix my Au1x00 serial + USB issues?

    I don't think so.

> I know the old PCI bus code used to not work with the USB - at least the two could not run together.

    There are some chip errata connected with USB and PCI...

WBR, Sergei
