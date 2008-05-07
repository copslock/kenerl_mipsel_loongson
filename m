Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 08:00:10 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:20552 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20044497AbYEGHAG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 08:00:06 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1JteZQ-0003ty-I5
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Wed, 07 May 2008 10:00:12 +0200
Date:	Wed, 7 May 2008 08:59:53 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Message-ID: <20080507085953.2c08b854@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Wed, 7 May 2008 01:40:27 +0100 (BST), Maciej W. Rozycki wrote:
> (...)
> 2. The i2c-sibyte.c BCM1250A SMBus controller driver now registers its 
>    buses as numbered so that board setup is correctly applied.  Plus minor 
>    corrections.

Minor corrections which would ideally belong to a separate patch
(there's a whole lot more cleanups that could be done in that driver,
BTW...)

> (...)
> --- linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c	2008-05-05 02:55:25.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c	2008-05-06 23:45:32.000000000 +0000
> @@ -2,6 +2,7 @@
>   * Copyright (C) 2004 Steven J. Hill
>   * Copyright (C) 2001,2002,2003 Broadcom Corporation
>   * Copyright (C) 1995-2000 Simon G. Vogl
> + * Copyright (C) 2008  Maciej W. Rozycki

I don't think that the minor changes below are enough for you to claim
copyright on that driver.

>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -132,18 +133,18 @@ static const struct i2c_algorithm i2c_si
>  /*
>   * registering functions to load algorithms at runtime
>   */
> -int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
> +static int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
>  {
>  	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
>  
> -	/* register new adapter to i2c module... */
> +	/* Register new adapter to i2c module...  */
>  	i2c_adap->algo = &i2c_sibyte_algo;
>  
> -	/* Set the frequency to 100 kHz */
> +	/* Set the requested frequency.  */

Why do you double the space and the end of comments? Never seen that
before, and I can't see the idea.

>  	csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
>  	csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
>  
> -	return i2c_add_adapter(i2c_adap);
> +	return i2c_add_numbered_adapter(i2c_adap);
>  }
>  
>  
> @@ -159,6 +160,7 @@ static struct i2c_adapter sibyte_board_a
>  		.class		= I2C_CLASS_HWMON,
>  		.algo		= NULL,
>  		.algo_data	= &sibyte_board_data[0],
> +		.nr		= 0,
>  		.name		= "SiByte SMBus 0",
>  	},
>  	{
> @@ -167,6 +169,7 @@ static struct i2c_adapter sibyte_board_a
>  		.class		= I2C_CLASS_HWMON,
>  		.algo		= NULL,
>  		.algo_data	= &sibyte_board_data[1],
> +		.nr		= 1,
>  		.name		= "SiByte SMBus 1",
>  	},
>  };

I'm not sure how you intend to push these changes upstream. I would
take a patch only touching drivers/i2c/busses/i2c-sibyte.c in my i2c
tree, however a patch also touching arch code, must be handled be the
maintainer for that architecture or platform.

-- 
Jean Delvare
