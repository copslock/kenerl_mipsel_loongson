Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 00:44:17 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:52919 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022979AbXCUAoN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 00:44:13 +0000
Received: (qmail 15507 invoked by uid 101); 21 Mar 2007 00:43:02 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 21 Mar 2007 00:43:02 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2L0gkjX005438;
	Tue, 20 Mar 2007 16:42:50 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCP6HKT>; Tue, 20 Mar 2007 17:42:42 -0800
Message-ID: <46007F7F.9030604@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Jean Delvare <khali@linux-fr.org>
Cc:	linux-mips@linux-mips.org, i2c@lm-sensors.org
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver]
Date:	Tue, 20 Mar 2007 16:42:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 21 Mar 2007 01:42:33.0953 (UTC) FILETIME=[325CF510:01C76B5A]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Jean Delvare wrote:
> Marc,
> 
>  > ----- Forwarded message from Marc St-Jean <stjeanma@pmc-sierra.com> 
> -----
>  >
>  > From: Marc St-Jean <stjeanma@pmc-sierra.com>
>  > Date: Fri, 16 Mar 2007 15:39:51 -0600
>  > To:   akpm@linux-foundation.org
>  > Cc:   linux-mips@linux-mips.org
>  > Subject: [PATCH 8/12] drivers: PMC MSP71xx TWI driver
>  >
>  > [PATCH 8/12] drivers: PMC MSP71xx TWI driver
>  >
>  > Patch to add TWI driver for the PMC-Sierra MSP71xx devices.
>  >
>  > Reposting patches as a single set at the request of akpm.
>  > Only 9 of 12 will be posted at this time, 3 more to follow
>  > when cleanups are complete.
>  >
>  > CCing linux-mips.org since minor changes have occured
>  > during cleanup of driver patches for other lists.
>  >
>  > Thanks,
>  > Marc
>  >
>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
>  > ---
>  > Re-posting patch with recommended changes:
>  > -No changes.
>  >
>  >  drivers/i2c/algos/Kconfig           |    9
>  >  drivers/i2c/algos/Makefile          |    1
>  >  drivers/i2c/algos/i2c-algo-pmctwi.c |  197 ++++++++++++++++
>  >  drivers/i2c/busses/Kconfig          |    7
>  >  drivers/i2c/busses/Makefile         |    1
>  >  drivers/i2c/busses/i2c-pmcmsp.c     |  419 
> ++++++++++++++++++++++++++++++++++++
>  >  include/linux/i2c-algo-pmctwi.h     |  135 +++++++++++
>  >  7 files changed, 768 insertions(+), 1 deletion(-)
> 
> Why are you making a separate algorithm driver? This should really only
> be done when the algorithm is very generic. This is the exception, not
> the rule. These days I tend to move algorithm code back into the only
> bus driver that uses them (i2c-algo-sibyte done recently, i2c-algo-sgi
> is next on my list.)

I believe it was done to separate the algorithm for the TWI sub-system,
which is used in several devices, from the device family code. If this
is no longer acceptable I will merge the algo code with the adapter.


>  > diff --git a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
>  > index af02034..794f7bb 100644
>  > --- a/drivers/i2c/algos/Kconfig
>  > +++ b/drivers/i2c/algos/Kconfig
>  > @@ -49,5 +49,12 @@ config I2C_ALGO_SGI
>  >         Supports the SGI interfaces like the ones found on SGI Indy VINO
>  >         or SGI O2 MACE.
>  > 
>  > -endmenu
>  > +config I2C_ALGO_PMCTWI
>  > +     tristate "I2C PMC TWI interfaces"
>  > +     depends on I2C && PMC_MSP
> 
> As a matter of fact, each time an algorithm depends on specific
> hardware, you can be reasonably certain that it should NOT be made a
> generic algorithm driver.

OK.

>  > +     help
>  > +       Implements the PMC TWI SoC algorithm for various 
> implementations.
>  > 
>  > +       Be sure to select the proper bus for your platform below.
>  > +
>  > +endmenu
> 
> -- 
> Jean Delvare
> 
