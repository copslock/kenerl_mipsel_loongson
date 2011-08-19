Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 21:13:40 +0200 (CEST)
Received: from imr4.ericy.com ([198.24.6.9]:51472 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492171Ab1HSTNc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2011 21:13:32 +0200
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p7JJDMYC029638;
        Fri, 19 Aug 2011 14:13:24 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0706.eamcs.ericsson.se (147.117.20.91) with Microsoft SMTP Server id
 8.3.137.0; Fri, 19 Aug 2011 15:13:18 -0400
Subject: Re: [PATCH] MIPS: Octeon: Select CONFIG_HOLES_IN_ZONE
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: <guenter.roeck@ericsson.com>
To:     David Daney <david.daney@cavium.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Jason Kwon <jason.kwon@ericsson.com>
In-Reply-To: <1313779440-12522-1-git-send-email-david.daney@cavium.com>
References: <1313779440-12522-1-git-send-email-david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Fri, 19 Aug 2011 12:13:11 -0700
Message-ID: <1313781191.3235.96.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14650

On Fri, 2011-08-19 at 14:44 -0400, David Daney wrote:
> Current Octeon systems do in fact have holes in their memory zones.
> We need to select HOLES_IN_ZONE.  If we do not, some memory
> configurations will result in crashes at boot time like this:
> 
> .
> .
> .
> CPU 6 Unable to handle kernel paging request at virtual address 0000000000700000, epc == ffffffff8118fe00, ra == ffffffff8118fe9c
> Oops[#1]:
> Cpu 6
> .
> .
> .
>         ...
> Call Trace:
> [<ffffffff8118fe00>] setup_per_zone_wmarks+0x1b0/0x338
> [<ffffffff815cd738>] init_per_zone_wmark_min+0x64/0xd0
> [<ffffffff81100438>] do_one_initcall+0x38/0x160
> .
> .
> .
> 
> Reported-by: Jason Kwon <jason.kwon@ericsson.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Jason Kwon <jason.kwon@ericsson.com>
> ---
> Jason, can you test this patch?
> 
> Ralf, if Jason reports that it fixes his problem, it probably is
> needed for 3.0 and 3.1.
> 

Your patch fixes the problem for the board with CN38xx and 2GB RAM that
crashed previously.

Tested-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks a lot for looking into this.

Guenter
