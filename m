Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2006 14:52:55 +0100 (BST)
Received: from pasmtp.tele.dk ([193.162.159.95]:6931 "HELO pasmtp.tele.dk")
	by ftp.linux-mips.org with SMTP id S8133570AbWDPNwq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2006 14:52:46 +0100
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 2852F1EC320;
	Sun, 16 Apr 2006 16:04:03 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 4BF0C43C21C; Sun, 16 Apr 2006 16:03:59 +0200 (CEST)
Date:	Sun, 16 Apr 2006 16:03:59 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	Paul Mackerras <paulus@samba.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, benedict.gaster@superh.com,
	lethal@linux-sh.org, Chris Zankel <chris@zankel.net>,
	Marc Gauthier <marc@tensilica.com>,
	Joe Taylor <joe@tensilica.com>,
	David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
	spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, grundler@parisc-linux.org,
	parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux390@de.ibm.com, davem@davemloft.net, rusty@rustcorp.com.au
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-ID: <20060416140359.GA15091@mars.ravnborg.org>
References: <1145049535.1336.128.camel@localhost.localdomain> <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com> <4441B02D.4000405@yahoo.com.au> <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com> <17473.60411.690686.714791@cargo.ozlabs.ibm.com> <1145194804.27407.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145194804.27407.103.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 16, 2006 at 09:40:04AM -0400, Steven Rostedt wrote:
 
> The per_cpu variables are defined with the macro 
>     DEFINE_PER_CPU(type, var)
> 
> This macro just places the variable into the section .data.percpu and
> prepends the prefix "per_cpu__" to the variable.
> 
> To use this variable in another .c file the declaration is used by the
> macro
>     DECLARE_PER_CPU(type, var)
> 
> This macro is simply the extern declaration of the variable with the
> prefix added.
Suprisingly this macro shows up in ~19 .c files. Only valid usage is
forward declaration of a later static definition with DEFINE_PER_CPU.
arch/m32r/kernel/smp.c + arch/m32r/kernel/smpboot.c is jsut one example.

Just a random comment not related to Steven's patches.

	Sam
