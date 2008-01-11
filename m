Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 08:28:31 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:62160 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20030008AbYAKI2X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 08:28:23 +0000
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1JDFFR-0004re-PS; Fri, 11 Jan 2008 09:28:17 +0100
Date:	Fri, 11 Jan 2008 09:28:17 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] Kconfig fixes for BCM47XX platform
Message-ID: <20080111082817.GR18495@hall.aurel32.net>
References: <20071210102232.GA10145@hall.aurel32.net> <20071211103034.GA11972@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20071211103034.GA11972@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Tue, Dec 11, 2007 at 11:30:34AM +0100, Aurelien Jarno wrote:
> Hi,
> 
> The patch below fixes two problems for Kconfig on the BCM47xx platform:
> - arch/mips/bcm47xx/gpio.c uses ssb_extif_* functions. Selecting 
>   SSB_DRIVER_EXTIF makes sure those functions are available.
> - arch/mips/pci/pci.c needs, when enabled, platform specific functions,
>   which are defined when SSB_PCICORE_HOSTMODE is enabled.
> 
> This patch replaces the one called "Enable SSB_DRIVER_EXTIF on BCM47XX
> platform" posted yesterday.
> 
> Aurelien
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c6fc405..b4ffcae 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -59,6 +59,8 @@ config BCM47XX
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
>  	select SSB
>  	select SSB_DRIVER_MIPS
> +	select SSB_DRIVER_EXTIF
> +	select SSB_PCICORE_HOSTMODE if PCI
>  	select GENERIC_GPIO
>  	select SYS_HAS_EARLY_PRINTK
>  	select CFE
> 

Any news about this patch?

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
