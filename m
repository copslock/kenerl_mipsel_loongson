Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 05:23:54 +0000 (GMT)
Received: from smtp002.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.126]:18081
	"HELO smtp002.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8224771AbVBUFXi>; Mon, 21 Feb 2005 05:23:38 +0000
Received: from unknown (HELO ?10.2.2.62?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp002.bizmail.yahoo.com with SMTP; 21 Feb 2005 05:23:35 -0000
Message-ID: <4219704E.8000207@embeddedalley.com>
Date:	Sun, 20 Feb 2005 21:23:26 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Josh Green <jgreen@users.sourceforge.net>
CC:	linux-mips@linux-mips.org
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
References: <1108962105.6611.24.camel@SillyPuddy.localdomain>
In-Reply-To: <1108962105.6611.24.camel@SillyPuddy.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Josh Green wrote:
> Hello, I found a couple compile problems with the
> drivers/mtd/maps/db1x00-flash.c MTD driver.  I'm using linux-mips CVS
> from a few weeks back, corresponding to 2.6.11rc2.  I noticed some
> recent CVS traffic in regards to this driver, but I didn't see them in
> cvsweb on the linux-mips site.  My apologies if this is something that
> has already been reported.  Fixes in the patch below:
> 
> - Specify proper paths for #include of au1000.h and db1x00.h
> - Cast return value of ioremap to (void __iomem *) to get rid of warning
> concerning conversion of integer to pointer
> - Setup DB1X00_BOTH_BANKS, DB1X00_BOOT_ONLY, and DB1X00_USER_ONLY
> defines in db1x00.h (used pb1550.h as an example) since they seemed to
> be missing which was causing the following to be triggered:
> 
> #error MTD_DB1X00 define combo error /* should never happen */
> 
> I can see the partitions in /dev/mtd now, but I have not thoroughly
> tested it yet to see if there are any other problems.

The latest mtd driver(s) are in the mtd tree and the db1x00 driver 
there should work. Ralf pulls the mtd code from kernel.org and .. 
I'm not sure when and how the code gets in kernel.org. The problem 
is that if I pull from the mtd tree and push the latest drivers in 
linux-mips, they'll still get overwritten with the code from 
kernel.org. I'm not sure what's the best way to maintain these 
drivers and avoid the confusion.

Pete

> 
> Best regards,
> 	Josh Green
> 
> 
> ---------------
> 
> 
> diff -ruN a/drivers/mtd/maps/db1x00-flash.c b/drivers/mtd/maps/db1x00-flash.c
> --- a/drivers/mtd/maps/db1x00-flash.c	2005-02-20 20:29:30.268844944 -0800
> +++ b/drivers/mtd/maps/db1x00-flash.c	2005-02-20 20:29:36.025969728 -0800
> @@ -18,8 +18,8 @@
>  #include <linux/mtd/partitions.h>
>  
>  #include <asm/io.h>
> -#include <asm/au1000.h>
> -#include <asm/db1x00.h>
> +#include <asm/mach-au1x00/au1000.h>
> +#include <asm/mach-db1x00/db1x00.h>
>  
>  #ifdef 	DEBUG_RW
>  #define	DBG(x...)	printk(x)
> @@ -192,7 +192,7 @@
>  	 */
>  	printk(KERN_NOTICE "Db1xxx flash: probing %d-bit flash bus\n", 
>  			db1xxx_mtd_map.bankwidth*8);
> -	db1xxx_mtd_map.virt = (unsigned long)ioremap(window_addr, window_size);
> +	db1xxx_mtd_map.virt = (void __iomem *)ioremap(window_addr, window_size);
>  	db1xxx_mtd = do_map_probe("cfi_probe", &db1xxx_mtd_map);
>  	if (!db1xxx_mtd) return -ENXIO;
>  	db1xxx_mtd->owner = THIS_MODULE;
> diff -ruN a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-db1x00/db1x00.h
> --- a/include/asm-mips/mach-db1x00/db1x00.h	2005-02-20 20:30:51.710463936 -0800
> +++ b/include/asm-mips/mach-db1x00/db1x00.h	2005-02-20 20:31:00.671101712 -0800
> @@ -134,6 +134,14 @@
>  #define SET_VCC_VPP(VCC, VPP, SLOT)\
>  	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
>  
> +#if defined(CONFIG_MTD_DB1X00_BOOT) && defined(CONFIG_MTD_DB1X00_USER)
> +#define DB1X00_BOTH_BANKS
> +#elif defined(CONFIG_MTD_DB1X00_BOOT) && !defined(CONFIG_MTD_DB1X00_USER)
> +#define DB1X00_BOOT_ONLY
> +#elif !defined(CONFIG_MTD_DB1X00_BOOT) && defined(CONFIG_MTD_DB1X00_USER)
> +#define DB1X00_USER_ONLY
> +#endif
> +
>  /* SD controller macros */
>  /*
>   * Detect card.
> 
> 
