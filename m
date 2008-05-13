Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 12:34:37 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:40307 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20029925AbYEMLee (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 12:34:34 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1JvtiQ-00035m-FA
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Tue, 13 May 2008 14:34:46 +0200
Date:	Tue, 13 May 2008 13:34:16 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] RTC: SWARM I2C board initialization (#2)
Message-ID: <20080513133416.59a8d943@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805130249230.535@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130249230.535@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Tue, 13 May 2008 04:27:10 +0100 (BST), Maciej W. Rozycki wrote:
>  The standard rtc-m41t80.c driver cannot be used with the SWARM as it is,
> because the board does not provide setup information for the I2C core.  
> As a result the bus and the address to probe for the M41T80 chip is not
> known.
> 
>  Here is a set of changes that fix the problem:
> 
> 1. swarm-i2c.c -- SWARM I2C board setup, currently for the M41T80 chip on 
>    the bus #1 only (there is a MAX6654 temperature sensor on the bus #0 
>    which may be added in the future if we have a driver for that chip).

We don't have a driver yet, however the datasheet for that chip is
publicly available and writing a driver would be easy. Or maybe just
reuse an existing driver - from a quick look at the datasheet I suspect
that this device is essentially compatible with the LM90 and ADM1032
chips supported by the lm90 driver.

> 
> 2. The i2c-sibyte.c BCM1250A SMBus controller driver now registers its 
>    buses as numbered so that board setup is correctly applied.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  I have renamed i2c-swarm.c to swarm-i2c.c for consistency with names 
> of other files under arch/mips/.

But you forgot to update the log message accordingly...

>  Please note this patch trivially depends on
> patch-2.6.26-rc1-20080505-swarm-core-16 -- 2/6 of this set.

OK, so I should just wait for patch 2/6 to get upstream before I add
this one to my i2c tree?

> 
>   Maciej
> 
> patch-2.6.26-rc1-20080505-swarm-i2c-17
> diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile
> --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile	2008-05-06 01:18:21.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile	2008-05-13 03:11:43.000000000 +0000
> @@ -1,3 +1,4 @@
>  obj-y				:= setup.o rtc_xicor1241.o rtc_m41t81.o
>  
> +obj-$(CONFIG_I2C_BOARDINFO)	+= swarm-i2c.o
>  obj-$(CONFIG_KGDB)		+= dbg_io.o
> diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/swarm-i2c.c linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/swarm-i2c.c
> --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/swarm-i2c.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/swarm-i2c.c	2008-05-13 03:11:26.000000000 +0000
> @@ -0,0 +1,37 @@
> +/*
> + *	arch/mips/sibyte/swarm/swarm-i2c.c
> + *
> + *	Broadcom BCM91250A (SWARM), etc. I2C platform setup.
> + *
> + *	Copyright (c) 2008  Maciej W. Rozycki
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +
> +
> +static struct i2c_board_info swarm_i2c_info1[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("m41t81", 0x68),
> +	},
> +};
> +
> +static int __init swarm_i2c_init(void)
> +{
> +	int err;
> +
> +	err = i2c_register_board_info(1, swarm_i2c_info1,
> +				      ARRAY_SIZE(swarm_i2c_info1));
> +	if (err < 0)
> +		printk(KERN_ERR
> +		       "i2c-swarm: cannot register board I2C devices\n");
> +	return err;
> +}
> +
> +arch_initcall(swarm_i2c_init);
> diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c
> --- linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c	2008-05-05 02:55:25.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c	2008-05-11 01:21:45.000000000 +0000
> @@ -143,7 +143,7 @@ int __init i2c_sibyte_add_bus(struct i2c
>  	csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
>  	csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
>  
> -	return i2c_add_adapter(i2c_adap);
> +	return i2c_add_numbered_adapter(i2c_adap);
>  }
>  
>  
> @@ -159,6 +159,7 @@ static struct i2c_adapter sibyte_board_a
>  		.class		= I2C_CLASS_HWMON,
>  		.algo		= NULL,
>  		.algo_data	= &sibyte_board_data[0],
> +		.nr		= 0,
>  		.name		= "SiByte SMBus 0",
>  	},
>  	{
> @@ -167,6 +168,7 @@ static struct i2c_adapter sibyte_board_a
>  		.class		= I2C_CLASS_HWMON,
>  		.algo		= NULL,
>  		.algo_data	= &sibyte_board_data[1],
> +		.nr		= 1,
>  		.name		= "SiByte SMBus 1",
>  	},
>  };


-- 
Jean Delvare
