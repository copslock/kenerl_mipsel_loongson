Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 17:52:51 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27385 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225215AbTEMQwt>;
	Tue, 13 May 2003 17:52:49 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h4DGqid27220;
	Tue, 13 May 2003 09:52:44 -0700
Date: Tue, 13 May 2003 09:52:44 -0700
From: Jun Sun <jsun@mvista.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: memory for exception vectors
Message-ID: <20030513095244.B26990@mvista.com>
References: <20030512115641.F17151@ftp.linux-mips.org> <20030512104408.C24045@mvista.com> <20030513105145.D22288@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030513105145.D22288@ftp.linux-mips.org>; from ladis@linux-mips.org on Tue, May 13, 2003 at 10:51:45AM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2003 at 10:51:45AM +0100, Ladislav Michl wrote:
> On Mon, May 12, 2003 at 10:44:08AM -0700, Jun Sun wrote:
> > On Mon, May 12, 2003 at 11:56:41AM +0100, Ladislav Michl wrote:
> > > Could anyone tell me where is space for exception vectors reserved? Many boards
> > > (for example Alchemy Pb1000, Galileo EV96100 or Galileo EV64120A) simply
> > > registers all available RAM with add_memory_region call, but I didn't find code
> > > which reserves first 0x200 (on most CPUs) for exceptions vectors anywhere. I'd
> > > guess there is something obvious what I'm missing. Can you help me to see it?
> > 
> > Kernel only uses memory after the end of kernel image.  In that sense, all
> > memory before LOADADDR (see arch/mips/Makefile) is reserved.
> 
> I'm afraid, I didn't find any code which does what you're describing here.
> But in arch/mips/mm/init.c is function setup_zero_pages which allocates
> first (or first eight if CPU has VCE) page(s). Does it do the trick?
>

Now you are really pushing me. :)

I figured that out a while back.  I think you can find answers in
arch/mips/kernel/setup.c, 

	start_pfn = PFN_UP(__pa(&_end));

I think zero pages are allocated so that all future read-only zero-filled
pages can be mapped to them.  They are allocated at the beginning of
start_pfn, which is also after kernel image.

Jun 
