Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2007 23:49:13 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:14320 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021662AbXCGXtI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Mar 2007 23:49:08 +0000
Received: (qmail 13091 invoked by uid 101); 7 Mar 2007 23:47:45 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 7 Mar 2007 23:47:45 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l27NleTc024449;
	Wed, 7 Mar 2007 15:47:45 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCP3JFP>; Wed, 7 Mar 2007 15:47:40 -0800
Message-ID: <45EF4F0E.50303@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] drivers: PMC MSP71xx GPIO char driver
Date:	Wed, 7 Mar 2007 15:47:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 07 Mar 2007 23:47:36.0611 (UTC) FILETIME=[FBDB5730:01C76112]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
>  > On Fri, 23 Feb 2007 17:28:19 -0600 Marc St-Jean 
> <stjeanma@pmc-sierra.com> wrote:
>  > [PATCH] drivers: PMC MSP71xx GPIO char driver
>  >
>  > Patch to add a GPIO char driver for the PMC-Sierra
>  > MSP71xx devices.
>  >
>  > This patch references some platform support files previously
>  > submitted to the linux-mips@linux-mips.org list.
>  >

Thanks for the feedback Andrew. I've implemented all your recommendations
other than the kernel thread handling, which I still have to look into.

[...]

> 
>  > +/* -- Module functions -- */
>  > +
>  > +static int msp_gpio_blinkthread( void *none )
> 
> Why is this a "module function"?

The reason is likely because it's only called by msp_gpio_init so it was
considered part of the module code. I'll move the comment to only cover
msp_gpio_init/exit.

[...]

>  > +module_init(msp_gpio_init);
>  > +module_exit(msp_gpio_exit);
>  > +
>  > +EXPORT_SYMBOL(msp_gpio_in);
>  > +EXPORT_SYMBOL(msp_gpio_out);
>  > +EXPORT_SYMBOL(msp_gpio_mode);
>  > +EXPORT_SYMBOL(msp_gpio_blink);
>  > +EXPORT_SYMBOL(msp_gpio_noblink);
> 
> What uses these exports?

These exports are needed for other drivers compiled as modules can control
the GPIO pins through this driver.

[...]

Marc
