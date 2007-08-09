Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 21:41:51 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:4997 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20024678AbXHIUln (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Aug 2007 21:41:43 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l79KeU6I023460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 13:40:31 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l79KeM17018423;
	Thu, 9 Aug 2007 13:40:24 -0700
Date:	Thu, 9 Aug 2007 13:40:22 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org, mb@bu3sch.de, nbd@openwrt.org,
	jolt@tuxbox.org
Subject: Re: [PATCH 3/4] RFC: Add BCM947XX to Kconfig
Message-Id: <20070809134022.427376b6.akpm@linux-foundation.org>
In-Reply-To: <20070809004514.GD4682@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net>
	<200708062005.29657.mb@bu3sch.de>
	<20070806183316.GB32465@hall.aurel32.net>
	<200708062037.05995.mb@bu3sch.de>
	<20070806191712.GA2019@hall.aurel32.net>
	<20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp>
	<20070807121638.GA9953@hall.aurel32.net>
	<20070807183302.1e38a4df.akpm@linux-foundation.org>
	<20070809004156.GA4682@hall.aurel32.net>
	<20070809004514.GD4682@hall.aurel32.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 9 Aug 2007 02:45:14 +0200
Aurelien Jarno <aurelien@aurel32.net> wrote:

> The patch below against 2.6.23-rc1-mm2 adds a BCM947XX option to 
> Kconfig.
> 
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Florian Schirmer <jolt@tuxbox.org>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> 
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

I'll consider these to be MIPS patches, so I'll spam Ralf with them.

I dropped the second hunk here, as Ralf has no drivers/ssb.  This will
need to be wired up in some later patch, once these various trees all end
up in the same place, presumably Linus's tree.
