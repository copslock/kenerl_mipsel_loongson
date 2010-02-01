Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 23:39:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59462 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492330Ab0BAWjE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 23:39:04 +0100
Date:   Mon, 1 Feb 2010 22:39:03 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] Virtual memory size detection for 64 bit MIPS CPUs
In-Reply-To: <1265061872.5825.71.camel@groeck-laptop>
Message-ID: <alpine.LFD.2.00.1002012232510.3578@eddie.linux-mips.org>
References: <1265058019-21484-1-git-send-email-guenter.roeck@ericsson.com>         <4B674ADD.1050306@caviumnetworks.com> <1265061872.5825.71.camel@groeck-laptop>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 1 Feb 2010, Guenter Roeck wrote:

> On Mon, 2010-02-01 at 16:42 -0500, David Daney wrote:
> > Guenter Roeck wrote:
> > [...]
> > >  
> > > +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> > > +{
> > > +	if (cpu_has_64bits) {
> > > +		unsigned long zbits;
> > > +
> > > +		asm volatile(".set mips64\n"
> > > +			     "and %0, 0\n"
> > > +			     "dsubu %0, 1\n"
> > > +			     "dmtc0 %0, $10, 0\n"
> > > +			     "dmfc0 %0, $10, 0\n"
> > > +			     "dsll %0, %0, 2\n"
> > > +			     "dsra %0, %0, 2\n"
> > > +			     "dclz %0, %0\n"
> > > +			     ".set mips0\n"
> > > +			     : "=r" (zbits));
> > > +		c->vmbits = 64 - zbits;
> > > +	} else
> > > +		c->vmbits = 32;
> > > +}
> > > +
> > 
> > It should be possible to express this in 'pure' C using 
> > read_c0_entryhi()/write_c0_entryhi(), also you need to be sure you are 
> 
> Sure, no problem.

 Especially as:

1. DCLZ is not a valid MIPS III instruction; some 64-bit CPUs will fault 
   on it.

2. You have to take care of CP0 hazards, e.g. with the R4000 if an MTC0 is 
   immediately followed by an MFC0 accessing the same CP0 register, then 
   the result of the latter instruction is unpredictable.

  Maciej
