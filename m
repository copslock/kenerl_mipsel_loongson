Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2012 15:51:36 +0100 (CET)
Received: from imr3.ericy.com ([198.24.6.13]:46517 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904104Ab2ALOva (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jan 2012 15:51:30 +0100
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id q0CEp46X021921
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 12 Jan 2012 08:51:16 -0600
Received: from localhost (147.117.20.214) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.3.137.0; Thu, 12 Jan 2012
 09:51:05 -0500
Date:   Thu, 12 Jan 2012 06:49:38 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH RESEND 16/17] MIPS: make oprofile use cp0_perfcount_irq
 if it is set
Message-ID: <20120112144938.GA17168@ericsson.com>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
 <1326314674-9899-16-git-send-email-blogic@openwrt.org>
 <4F0EFE6E.3080503@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4F0EFE6E.3080503@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jan 12, 2012 at 10:38:22AM -0500, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/11/2012 11:44 PM, John Crispin wrote:
> 
> > The patch makes the oprofile code use the performance counters irq.
> 
> > This patch is written by Felix Fietkau.
> 
> > Signed-off-by: Felix Fietkau<nbd@openwrt.org>
> > Signed-off-by: John Crispin<blogic@openwrt.org>
> 
> > @@ -374,6 +379,10 @@ static int __init mipsxx_init(void)
> >   	save_perf_irq = perf_irq;
> >   	perf_irq = mipsxx_perfcount_handler;
> >
> > +	if (cp0_perfcount_irq>= 0)
> 
>     BTW, I just noticed. IRQ0 is not a valid IRQ in Linux, request_irq() should 
> fail when passed 0, so this and following check should be '> 0'.
> 
There is also the little matter of coding style. Watch out for chapter 3.

Guenter

> > +		return request_irq(cp0_perfcount_irq, mipsxx_perfcount_int,
> > +			IRQF_SHARED, "Perfcounter", save_perf_irq);
> > +
> >   	return 0;
> >   }
> >
> > @@ -381,6 +390,9 @@ static void mipsxx_exit(void)
> >   {
> >   	int counters = op_model_mipsxx_ops.num_counters;
> >
> > +	if (cp0_perfcount_irq>= 0)
> > +		free_irq(cp0_perfcount_irq, save_perf_irq);
> > +
> >   	counters = counters_per_cpu_to_total(counters);
> >   	on_each_cpu(reset_counters, (void *)(long)counters, 1);
> >
> 
> WBR, Sergei
> 
