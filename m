Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 01:08:57 +0100 (CET)
Received: from imr2.ericy.com ([198.24.6.3]:45779 "EHLO imr2.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492244Ab0BBAIx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 01:08:53 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o1209naA019019;
        Mon, 1 Feb 2010 18:09:51 -0600
Received: from localhost (147.117.20.212) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.1.375.2; Mon, 1 Feb 2010
 19:08:43 -0500
Date:   Mon, 1 Feb 2010 16:10:26 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v3] Virtual memory size detection for 64 bit MIPS CPUs
Message-ID: <20100202001026.GA6883@ericsson.com>
References: <1265064686-31278-1-git-send-email-guenter.roeck@ericsson.com> <4B676755.10600@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4B676755.10600@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 01, 2010 at 06:44:21PM -0500, David Daney wrote:
> Guenter Roeck wrote:
> > Linux kernel 2.6.32 and later allocates memory from the top of virtual memory
> > space.
> > 
> > This patch implements virtual memory size detection for 64 bit MIPS CPUs
> > to avoid resulting crashes.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> [...]
> >  
> > +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> > +{
> > +	if (cpu_has_64bits) {
> > +		write_c0_entryhi(0xfffffffffffff000ULL);
> 
> macro indicated that we need to avoid hazards here on R4000.
> 
> Perhaps adding:
> 
>   	back_to_back_c0_hazard();
> 
Compiler already added a nop, so I thought it wasn't necessary.
Doesn't hurt either, so I'll put it in.

Guenter
