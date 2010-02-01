Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 23:03:11 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:59602 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491789Ab0BAWDH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 23:03:07 +0100
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o11M3tnO026896;
        Mon, 1 Feb 2010 16:03:58 -0600
Received: from [155.53.128.103] (147.117.20.212) by
 eusaamw0707.eamcs.ericsson.se (147.117.20.92) with Microsoft SMTP Server id
 8.1.375.2; Mon, 1 Feb 2010 17:02:49 -0500
Subject: Re: [PATCH v2] Virtual memory size detection for 64 bit MIPS CPUs
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4B674ADD.1050306@caviumnetworks.com>
References: <1265058019-21484-1-git-send-email-guenter.roeck@ericsson.com>
         <4B674ADD.1050306@caviumnetworks.com>
Content-Type: text/plain
Organization: Ericsson
Date:   Mon, 1 Feb 2010 14:04:32 -0800
Message-ID: <1265061872.5825.71.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <guenter.roeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, 2010-02-01 at 16:42 -0500, David Daney wrote:
> Guenter Roeck wrote:
> [...]
> >  
> > +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> > +{
> > +	if (cpu_has_64bits) {
> > +		unsigned long zbits;
> > +
> > +		asm volatile(".set mips64\n"
> > +			     "and %0, 0\n"
> > +			     "dsubu %0, 1\n"
> > +			     "dmtc0 %0, $10, 0\n"
> > +			     "dmfc0 %0, $10, 0\n"
> > +			     "dsll %0, %0, 2\n"
> > +			     "dsra %0, %0, 2\n"
> > +			     "dclz %0, %0\n"
> > +			     ".set mips0\n"
> > +			     : "=r" (zbits));
> > +		c->vmbits = 64 - zbits;
> > +	} else
> > +		c->vmbits = 32;
> > +}
> > +
> 
> It should be possible to express this in 'pure' C using 
> read_c0_entryhi()/write_c0_entryhi(), also you need to be sure you are 

Sure, no problem.

> not writing 1s to any reserved bits of the register.
> 
That may be tricky, since the upper bits are reserved in some
architectures. For example, the 20Kc core specification says that bits
61:40 are reserved and must be written with 0.

I can write, say, 0x3fffffffffff0000 to avoid writing into lower
reserved bits, but that won't help for any upper reserved bits. Would
that be acceptable / better ?

Guenter
