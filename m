Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 18:19:36 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:55172 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021743AbXF2RTb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Jun 2007 18:19:31 +0100
Received: (qmail 10538 invoked by uid 101); 29 Jun 2007 17:19:22 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 29 Jun 2007 17:19:22 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5THIJkj032068;
	Fri, 29 Jun 2007 10:19:03 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW8ZCF>; Fri, 29 Jun 2007 10:18:18 -0700
Message-ID: <46853ED1.6050600@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	ralf@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	linux-mips@linux-mips.org, Rod Sillett <Rod_Sillett@pmc-sierra.com>
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Date:	Fri, 29 Jun 2007 10:18:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 29 Jun 2007 17:18:09.0481 (UTC) FILETIME=[770DC390:01C7BA71]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Yoichi Yuasa wrote:
> Hi,
> 
> On Thu, 28 Jun 2007 19:05:30 -0600
> Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> 
>  > diff --git a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c 
> b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
>  > new file mode 100644
>  > index 0000000..6fa8572
>  > --- /dev/null
>  > +++ b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
>  > @@ -0,0 +1,179 @@
>  > +/*
>  > + * Sets up interrupt handlers for various hardware switches which are
>  > + * connected to interrupt lines.
>  > + *
>  > + * Copyright 2005-2207 PMC-Sierra, Inc.

Hi Yoichi,
I'm just making sure future updates are accounted for! ;)

>  > +
>  > +#ifdef CONFIG_PMC_MSP7120_GW
> 
> You have already set "obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o" in 
> Makefile.
> It is not necessary.
> 
>  > +
>  > +static int __init msp_hwbutton_setup(void)
>  > +{
>  > +#ifdef CONFIG_PMC_MSP7120_GW
> 
> same.

The file was actually coded so boards other than the MSP7120_GW can make use of 
it. At some point the "obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o" will be 
removed from the Makefile. I'd prefer to leave the board dependent code in the 
source at this time, but of course if this will gate acceptance I will remove it.

Thanks,
Marc
