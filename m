Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 16:31:49 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:28598 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039048AbXBPQbr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 16:31:47 +0000
Received: (qmail 25663 invoked by uid 101); 16 Feb 2007 16:30:35 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 16 Feb 2007 16:30:35 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1GGUYC8029448;
	Fri, 16 Feb 2007 08:30:34 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <17WPXC0Y>; Fri, 16 Feb 2007 08:30:34 -0800
Message-ID: <45D5DC24.7090506@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date:	Fri, 16 Feb 2007 08:30:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 16 Feb 2007 16:30:28.0716 (UTC) FILETIME=[C4F6EAC0:01C751E7]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> On Thu, 15 Feb 2007 13:26:29 -0600
> Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> 
>  > +                     status = *(volatile u32 *)up->port.private_data;
> 
> It distresses me that this patch uses a variable which this patch
> doesn't initialise anywhere.  It isn't complete.
> 
> The sub-driver code whch sets up this field shuld be included in the
> patch, no?
> 

OK, I'll re-post with the platform file which initializes the variable.
That file however will reference other files in the platform which has
not been posted yet. I thought it was better to post the driver-only code.

Marc
