Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2011 01:18:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58554 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492183Ab1HSXSj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Aug 2011 01:18:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7JNIWgO023432;
        Sat, 20 Aug 2011 00:18:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7JNIU0D023424;
        Sat, 20 Aug 2011 00:18:30 +0100
Date:   Sat, 20 Aug 2011 00:18:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jason Kwon <jason.kwon@ericsson.com>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        David Daney <david.daney@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Octeon: Select CONFIG_HOLES_IN_ZONE
Message-ID: <20110819231830.GA22981@linux-mips.org>
References: <1313779440-12522-1-git-send-email-david.daney@cavium.com>
 <1313781191.3235.96.camel@groeck-laptop>
 <4E4ED4F5.2050002@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E4ED4F5.2050002@ericsson.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14809

On Fri, Aug 19, 2011 at 02:26:13PM -0700, Jason Kwon wrote:
> Date:   Fri, 19 Aug 2011 14:26:13 -0700
> From: Jason Kwon <jason.kwon@ericsson.com>
> To: Guenter Roeck <guenter.roeck@ericsson.com>
> CC: David Daney <david.daney@cavium.com>, "linux-mips@linux-mips.org"
>  <linux-mips@linux-mips.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>
> Subject: Re: [PATCH] MIPS: Octeon: Select CONFIG_HOLES_IN_ZONE
> Content-Type: text/plain; charset="UTF-8"; format=flowed
> 
> On 08/19/2011 12:13 PM, Guenter Roeck wrote:
> >On Fri, 2011-08-19 at 14:44 -0400, David Daney wrote:
> >>Current Octeon systems do in fact have holes in their memory zones.
> >>We need to select HOLES_IN_ZONE.  If we do not, some memory
> >>configurations will result in crashes at boot time like this:
> >>
> >>.
> >>.
> >>.
> >>CPU 6 Unable to handle kernel paging request at virtual address 0000000000700000, epc == ffffffff8118fe00, ra == ffffffff8118fe9c
> >>Oops[#1]:
> >>Cpu 6
> >>.
> >>.
> >>.
> >>         ...
> >>Call Trace:
> >>[<ffffffff8118fe00>] setup_per_zone_wmarks+0x1b0/0x338
> >>[<ffffffff815cd738>] init_per_zone_wmark_min+0x64/0xd0
> >>[<ffffffff81100438>] do_one_initcall+0x38/0x160
> >>.
> >>.
> >>.
> >>
> >>Reported-by: Jason Kwon<jason.kwon@ericsson.com>
> >>Signed-off-by: David Daney<david.daney@cavium.com>
> >>Cc: Jason Kwon<jason.kwon@ericsson.com>
> >>---
> >>Jason, can you test this patch?
> >>
> >>Ralf, if Jason reports that it fixes his problem, it probably is
> >>needed for 3.0 and 3.1.
> >>
> >Your patch fixes the problem for the board with CN38xx and 2GB RAM that
> >crashed previously.
> >
> >Tested-by: Guenter Roeck<guenter.roeck@ericsson.com>
> >
> >Thanks a lot for looking into this.
> >
> >Guenter
> >
> >
> 
> I applied the patch to 3.0.3 and was able to boot the CN58XX system
> without any memory restrictions.  The same patched kernel booted on
> CN38XX ran into a different problem, which I'm looking into.

Applied.  Thanks, folks!

  Ralf
