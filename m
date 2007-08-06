Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 21:34:05 +0100 (BST)
Received: from mailgate01.ni.ber.native-instruments.com ([85.158.2.40]:32194
	"EHLO mailgate01.ni.ber.native-instruments.com") by ftp.linux-mips.org
	with ESMTP id S20022011AbXHFUeC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 21:34:02 +0100
Received: (qmail 7131 invoked from network); 6 Aug 2007 20:32:54 -0000
Received: from unknown (HELO florian-schirmers-computer.local) (florian.schirmer@[88.73.95.215])
          (envelope-sender <jolt@tuxbox.org>)
          by 192.168.2.11 (qmail-ldap-1.03) with SMTP
          for <aurelien@aurel32.net>; 6 Aug 2007 20:32:54 -0000
Message-ID: <46B78578.8040605@tuxbox.org>
Date:	Mon, 06 Aug 2007 22:32:56 +0200
From:	Florian Schirmer <jolt@tuxbox.org>
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
MIME-Version: 1.0
To:	Aurelien Jarno <aurelien@aurel32.net>
CC:	Michael Buesch <mb@bu3sch.de>, Felix Fietkau <nbd@openwrt.org>,
	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>
Subject: Re: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig (v2)
References: <20070806150931.GH24308@hall.aurel32.net> <200708062009.14971.mb@bu3sch.de> <46B764D3.2030402@openwrt.org> <200708062024.53952.mb@bu3sch.de> <20070806201650.GA4645@hall.aurel32.net>
In-Reply-To: <20070806201650.GA4645@hall.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jolt@tuxbox.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jolt@tuxbox.org
Precedence: bulk
X-list: linux-mips

Hi,

Aurelien Jarno wrote:
> The patch below against 2.6.23-rc1-mm2 adds a BCM947XX option to 
> Kconfig and modify the SSB Kconfig to select SSB_PCICORE_HOSTMODE by
> default with BCM947XX CPUs.
>
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: Waldemar Brodkorb <wbx@openwrt.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Florian Schirmer <jolt@tuxbox.org>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>
>   

Looks good!

Acked-by: Florian Schirmer <jolt@tuxbox.org>

Best,
  Florian



> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -67,6 +67,20 @@
>  	  note that a kernel built with this option selected will not be
>  	  able to run on normal units.
>  
> +config BCM947XX
> +	bool "BCM947xx based boards"
> +	select DMA_NONCOHERENT
> +	select HW_HAS_PCI
> +	select IRQ_CPU
> +	select SYS_HAS_CPU_MIPS32_R1
> +	select SYS_SUPPORTS_32BIT_KERNEL
> +	select SYS_SUPPORTS_LITTLE_ENDIAN
> +	select SSB
> +	select SSB_DRIVER_MIPS
> +	select GENERIC_GPIO
> +	help
> +	 Support for BCM947xx based boards
> +
>  config MIPS_COBALT
>  	bool "Cobalt Server"
>  	select DMA_NONCOHERENT
> --- a/drivers/ssb/Kconfig
> +++ b/drivers/ssb/Kconfig
> @@ -67,6 +67,7 @@
>  config SSB_PCICORE_HOSTMODE
>  	bool "Hostmode support for SSB PCI core"
>  	depends on SSB_DRIVER_PCICORE && SSB_DRIVER_MIPS
> +	default y if BCM947XX
>  	help
>  	  PCIcore hostmode operation (external PCI bus).
>  
>
>   
