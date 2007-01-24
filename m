Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 16:42:23 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:28886 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20043900AbXAXQmS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 16:42:18 +0000
Received: (qmail 8865 invoked by uid 101); 24 Jan 2007 16:41:05 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 24 Jan 2007 16:41:05 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l0OGf5sJ004201;
	Wed, 24 Jan 2007 08:41:05 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <DCB6CQ5F>; Wed, 24 Jan 2007 08:41:05 -0800
Message-ID: <45B78C19.4030408@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	 er
Date:	Wed, 24 Jan 2007 08:40:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 24 Jan 2007 16:40:57.0674 (UTC) FILETIME=[6C5A0AA0:01C73FD6]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Sergei Shtylyov wrote:
> Hello, I wrote:
> 
>  >>>> Here is a serial driver patch for the PMC-Sierra MSP71xx device.
> 
>  >>>> There are three different fixes:
>  >>>> 1. Fix for THRE errata
>  >>>> 2. Fix for Busy Detect on LCR write
>  >>>> 3. Workaround for interrupt/data concurrency issue
> 
>  >>>> The first fix is handled cleanly using a UART_BUG_* flag.
> 
>  >>>    Hm, I wouldn't call it clean...
> 
>  >> Relative to the other two. Any recommended improvements on this one?
> 
>  >    I already told: runtime check.
> 
>     BTW, I've just came accross 2 patches in the -mm tree related to the
> transmitter bug:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-make-probing-for-txen-bug-a-config-option.patch

Thanks. The first of these is not at all what we are seeing. However I guess
there could be a remote chance it's triggering our THRE errata as it did for
the pnx4008 boards.

> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-uart-backup-timer.patch

This second patch failure description is identical to what we are seeing without
the THRE work-around. This must be the timer patch Alan mentioned but it's not
in the linux.git at l-m.o.

Could you please explain what you mean by and where I can find the "-mm tree"?

Marc
