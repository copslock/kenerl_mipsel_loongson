Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 10:51:48 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225204AbTEMJvp>; Tue, 13 May 2003 10:51:45 +0100
Date: Tue, 13 May 2003 10:51:45 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: memory for exception vectors
Message-ID: <20030513105145.D22288@ftp.linux-mips.org>
References: <20030512115641.F17151@ftp.linux-mips.org> <20030512104408.C24045@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512104408.C24045@mvista.com>; from jsun@mvista.com on Mon, May 12, 2003 at 10:44:08AM -0700
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2003 at 10:44:08AM -0700, Jun Sun wrote:
> On Mon, May 12, 2003 at 11:56:41AM +0100, Ladislav Michl wrote:
> > Could anyone tell me where is space for exception vectors reserved? Many boards
> > (for example Alchemy Pb1000, Galileo EV96100 or Galileo EV64120A) simply
> > registers all available RAM with add_memory_region call, but I didn't find code
> > which reserves first 0x200 (on most CPUs) for exceptions vectors anywhere. I'd
> > guess there is something obvious what I'm missing. Can you help me to see it?
> 
> Kernel only uses memory after the end of kernel image.  In that sense, all
> memory before LOADADDR (see arch/mips/Makefile) is reserved.

I'm afraid, I didn't find any code which does what you're describing here.
But in arch/mips/mm/init.c is function setup_zero_pages which allocates
first (or first eight if CPU has VCE) page(s). Does it do the trick?

	ladis
