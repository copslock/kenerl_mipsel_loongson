Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 19:09:22 +0100 (BST)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:20190
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20021541AbXHFSJT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Aug 2007 19:09:19 +0100
Received: from t000e.t.pppool.de ([89.55.0.14] helo=pbook.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50)
	id 1II717-0006Cv-Be; Mon, 06 Aug 2007 20:09:21 +0200
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig
Date:	Mon, 6 Aug 2007 20:09:14 +0200
User-Agent: KMail/1.9.6
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
References: <20070806150931.GH24308@hall.aurel32.net>
In-Reply-To: <20070806150931.GH24308@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708062009.14971.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Monday 06 August 2007, Aurelien Jarno wrote:
> The patch below against 2.6.23-rc1-mm2 adds a BCM947XX option to 
> Kconfig.
> 
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: Waldemar Brodkorb <wbx@openwrt.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Florian Schirmer <jolt@tuxbox.org>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> 
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -38,6 +38,22 @@
>  	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
>  	  an FPGA northbridge
>  
> +config BCM947XX
> +	bool "Support for BCM947xx based boards"
> +	select DMA_NONCOHERENT
> +	select HW_HAS_PCI

Not sure what this does.
My 47xx machines do _not_ have a PCI bus.

> +	select IRQ_CPU
> +	select SYS_HAS_CPU_MIPS32_R1
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select SSB
> +	select SSB_SERIAL
> +	select SSB_DRIVER_PCICORE
> +	select SSB_PCICORE_HOSTMODE

Shouldn't we leave the PCICORE an option instead of force selecting
it here?
My WRT54G doesn't have a (usable) PCI core. So it would work
without the driver for it.
Especially on the small WAP54G disabling PCIcore support could
be useful to reduce the kernel size.

> +	select GENERIC_GPIO
> +	help
> +	 Support for BCM947xx based boards
> +
>  config MACH_ALCHEMY
>  	bool "Alchemy processor based machines"
>  
