Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Oct 2004 09:51:24 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:14084
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224990AbUJIIvT>;
	Sat, 9 Oct 2004 09:51:19 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i998pDu19426;
	Sat, 9 Oct 2004 01:51:13 -0700
Message-ID: <4167A676.9050503@embeddedalley.com>
Date: Sat, 09 Oct 2004 01:51:02 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: charles.eidsness@ieee.org
CC: linux-mips@linux-mips.org
Subject: Re: DB1x00 FLASH and Kernel 2.6.8.1
References: <41640DFE.8050609@ieee.org>
In-Reply-To: <41640DFE.8050609@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Charles Eidsness wrote:

> Hi All,
>
> I had to make a minor change to the db1x00 flash's memory map 
> definition file in version 2.6.8.1 of the kernel in order to get flash 
> support to compile. See attached patch if interested.

I fixed this recently and pushed the patch in linux-mips and the mtd tree.

Pete

>
> Cheers,
> Charles
>
> --- linux-2.6.8.1-mips/drivers/mtd/maps/db1x00-flash.c    2004-01-30 
> 02:34:34.000000000 -0500
> +++ linux-2.6.8.1-mips/drivers/mtd/maps/db1x00-flash.c    2004-10-06 
> 10:39:20.950558416 -0400
> @@ -164,9 +164,9 @@
>              return 1;
>      }
>      db1xxx_mtd_map.size = window_size;
> -    db1xxx_mtd_map.buswidth = flash_buswidth;
> +    db1xxx_mtd_map.bankwidth = flash_buswidth;
>      db1xxx_mtd_map.phys = window_addr;
> -    db1xxx_mtd_map.buswidth = flash_buswidth;
> +    db1xxx_mtd_map.bankwidth = flash_buswidth;
>      return 0;
>  }
>
> @@ -189,7 +189,7 @@
>       * specific machine settings might have been set above.
>       */
>      printk(KERN_NOTICE "Db1xxx flash: probing %d-bit flash bus\n",
> -            db1xxx_mtd_map.buswidth*8);
> +            db1xxx_mtd_map.bankwidth*8);
>      db1xxx_mtd_map.virt = (unsigned long)ioremap(window_addr, 
> window_size);
>      db1xxx_mtd = do_map_probe("cfi_probe", &db1xxx_mtd_map);
>      if (!db1xxx_mtd) return -ENXIO;
>
