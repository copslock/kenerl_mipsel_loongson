Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 07:53:35 +0000 (GMT)
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:25094 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20022013AbXCQHxa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Mar 2007 07:53:30 +0000
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with SMTP id B3F7840E31;
	Sat, 17 Mar 2007 08:52:59 +0100 (CET)
Date:	Sat, 17 Mar 2007 08:52:44 +0100
From:	Jean Delvare <khali@linux-fr.org>
To:	200703162139.l2GLdpuH001568@pasqua.pmc-sierra.bc.ca
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Marc St-Jean <stjeanma@pmc-sierra.com>,
	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	i2c@lm-sensors.org
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver]
Message-Id: <20070317085244.f99aad86.khali@linux-fr.org>
In-Reply-To: <20070316230333.GA17478@linux-mips.org>
References: <20070316230333.GA17478@linux-mips.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Marc,

> ----- Forwarded message from Marc St-Jean <stjeanma@pmc-sierra.com> -----
> 
> From:	Marc St-Jean <stjeanma@pmc-sierra.com>
> Date:	Fri, 16 Mar 2007 15:39:51 -0600
> To:	akpm@linux-foundation.org
> Cc:	linux-mips@linux-mips.org
> Subject: [PATCH 8/12] drivers: PMC MSP71xx TWI driver
> 
> [PATCH 8/12] drivers: PMC MSP71xx TWI driver
> 
> Patch to add TWI driver for the PMC-Sierra MSP71xx devices.
> 
> Reposting patches as a single set at the request of akpm.
> Only 9 of 12 will be posted at this time, 3 more to follow
> when cleanups are complete.
> 
> CCing linux-mips.org since minor changes have occured
> during cleanup of driver patches for other lists.
> 
> Thanks,
> Marc
> 
> Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
> ---
> Re-posting patch with recommended changes:
> -No changes.
> 
>  drivers/i2c/algos/Kconfig           |    9 
>  drivers/i2c/algos/Makefile          |    1 
>  drivers/i2c/algos/i2c-algo-pmctwi.c |  197 ++++++++++++++++
>  drivers/i2c/busses/Kconfig          |    7 
>  drivers/i2c/busses/Makefile         |    1 
>  drivers/i2c/busses/i2c-pmcmsp.c     |  419 ++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-algo-pmctwi.h     |  135 +++++++++++
>  7 files changed, 768 insertions(+), 1 deletion(-)

Why are you making a separate algorithm driver? This should really only
be done when the algorithm is very generic. This is the exception, not
the rule. These days I tend to move algorithm code back into the only
bus driver that uses them (i2c-algo-sibyte done recently, i2c-algo-sgi
is next on my list.)

> 
> diff --git a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
> index af02034..794f7bb 100644
> --- a/drivers/i2c/algos/Kconfig
> +++ b/drivers/i2c/algos/Kconfig
> @@ -49,5 +49,12 @@ config I2C_ALGO_SGI
>  	  Supports the SGI interfaces like the ones found on SGI Indy VINO
>  	  or SGI O2 MACE.
>  
> -endmenu
> +config I2C_ALGO_PMCTWI
> +	tristate "I2C PMC TWI interfaces"
> +	depends on I2C && PMC_MSP

As a matter of fact, each time an algorithm depends on specific
hardware, you can be reasonably certain that it should NOT be made a
generic algorithm driver.

> +	help
> +	  Implements the PMC TWI SoC algorithm for various implementations.
>  
> +	  Be sure to select the proper bus for your platform below.
> +
> +endmenu

-- 
Jean Delvare
