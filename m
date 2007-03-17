Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 00:05:25 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:36859 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022633AbXCQAFU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Mar 2007 00:05:20 +0000
Received: (qmail 14721 invoked by uid 101); 17 Mar 2007 00:04:13 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 17 Mar 2007 00:04:13 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2H04CPX005540;
	Fri, 16 Mar 2007 16:04:12 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPXZZ0>; Fri, 16 Mar 2007 17:04:09 -0800
Message-ID: <45FB3076.4080403@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Date:	Fri, 16 Mar 2007 16:04:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 17 Mar 2007 01:03:59.0937 (UTC) FILETIME=[25732310:01C76830]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:
> On Fri, Mar 16, 2007 at 03:32:56PM -0600, Marc St-Jean wrote:
> 
>  > [PATCH 1/12] mips: PMC MSP71xx core platform
>  >
>  > Patch to add core platform support for the PMC-Sierra
>  > MSP71xx devices.
> 
> When I first reviewed this patch I requested removal of prom_printf and
> all stuff like prom_getchar, prom_putchar that was associated with it
> because I was about to remove prom_printf.  Well, prom_printf is gone
> now which means this patch will no longer work ...
> 
>   Ralf
> 

I read your original comment as this option being the least desirable of
the two options you presented, but still available. I will rewrite it
using the other option  and resubmit this patch.

Thanks for the heads up,
Marc
