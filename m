Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 05:34:18 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:44550 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490950Ab1FNDeO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jun 2011 05:34:14 +0200
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p5E3Y4Ri023387
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 13 Jun 2011 22:34:07 -0500
Received: from localhost (147.117.20.214) by eusaamw0712.eamcs.ericsson.se
 (147.117.20.182) with Microsoft SMTP Server id 8.3.137.0; Mon, 13 Jun 2011
 23:34:04 -0400
Date:   Mon, 13 Jun 2011 20:34:03 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Linux 2.6.39 on Cavium CN38xx
Message-ID: <20110614033403.GA4582@ericsson.com>
References: <1307653714.8271.130.camel@groeck-laptop>
 <4DF13E25.2060502@caviumnetworks.com>
 <20110609220614.GA13583@ericsson.com>
 <4DF15068.30906@caviumnetworks.com>
 <1307751642.8271.315.camel@groeck-laptop>
 <20110612164155.GA30615@ericsson.com>
 <4DF67CAE.1040804@caviumnetworks.com>
 <20110613215111.GA3484@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110613215111.GA3484@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11176

On Mon, Jun 13, 2011 at 05:51:11PM -0400, Guenter Roeck wrote:
[ ... ]
> > >
> > > The actual interrupt causing trouble and spurious interrupts in my case is,
> > > oddly enough, STATUSF_IP0. So far I have been unable to track down how that
> > > is triggered; I don't see the bit being set set in C0_CAUSE anywhere.
> > >
> > > Are there any means to trigger an IP0 interrupt other than by writing STATUSF_IP0
> > > into the C0_CAUSE register ?
> > >
> > 
> > No.  Nothing that I know of ever uses IP0 and IP1, so they should always 
> > be cleared.
> > 
> Exactly what I figured, yet I still get those spurious interrupts if IP0 is enabled.
> Something odd is definitely going on in my system.
> 
> Besides the above, my hopefully final problem is that timer interrupts are only
> received by CPU 0. Any idea what to look for to fix this problem ?
> 
Found the problem. Apparently the BIOS resets CvmCtl[IPTI] to 0. This causes both
the spurious interrupt on IP0 without setting C0_CAUSE, and the (perceived)
lack of timer interrupts. In other words, it _is_ possible to trigger IP0 interrupts
without setting STATUSF_IP0 in C0_CAUSE ... the interrupt will happen, but C0_CAUSE
will not be set.

Interesting learning experience...

Thanks,
Guenter
