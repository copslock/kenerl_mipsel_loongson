Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 18:42:58 +0100 (BST)
Received: from pfepb.post.tele.dk ([195.41.46.236]:46599 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20027248AbZEARmv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 18:42:51 +0100
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepb.post.tele.dk (Postfix) with ESMTP id DAE74F8404D;
	Fri,  1 May 2009 19:42:47 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 09233580D0; Fri,  1 May 2009 19:44:58 +0200 (CEST)
Date:	Fri, 1 May 2009 19:44:57 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	"H. Peter Anvin" <hpa@zytor.com>
Cc:	Tim Abbott <tabbott@MIT.EDU>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Waseem Daher <wdaher@MIT.EDU>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@MIT.EDU>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bryan Wu <cooloney@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@uclinux.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	Mikael Starvik <starvik@axis.com>,
	Paul Mackerras <paulus@samba.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@twiddle.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	user-mode-linux-devel@lists.sourceforge.net,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss sections.
Message-ID: <20090501174457.GA26559@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu> <1241121253-32341-2-git-send-email-tabbott@mit.edu> <20090501091848.GB18326@uranus.ravnborg.org> <alpine.DEB.1.10.0905010951100.3955@vinegar-pot.mit.edu> <49FB2449.1010301@zytor.com> <20090501171717.GA26401@uranus.ravnborg.org> <49FB2EDC.9050300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49FB2EDC.9050300@zytor.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Fri, May 01, 2009 at 10:18:20AM -0700, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> > On Fri, May 01, 2009 at 09:33:13AM -0700, H. Peter Anvin wrote:
> >> Tim Abbott wrote:
> >>> On Fri, 1 May 2009, Sam Ravnborg wrote:
> >>>
> >>>> On Thu, Apr 30, 2009 at 03:54:08PM -0400, Tim Abbott wrote:
> >>>>> +#define __PAGE_ALIGNED_DATA	.section ".data.page_aligned", "aw", @progbits
> >>>>> +#define __PAGE_ALIGNED_BSS	.section ".bss.page_aligned", "aw", @nobits
> >>>> It is my understanding that the linker will automatically
> >>>> assume nobits for section names starting with .bss and likewise
> >>>> progbits for section names starting with .data - so we can leave them out?
> >>> I believe that is correct.
> >>>
> >> ... but that doesn't mean it's the right thing to do.
> >>
> >> It's better to be fully explicit when macroizing this kind of stuff.
> >> This is part of why macroizing it is good: it means we end up with *one*
> >> place that determines this stuff, not some magic heuristics in the linker.
> > 
> > Do you know if we can use % in place of @?
> > I could see that gas supports both - at least in trunk in cvs.
> > 
> 
> I think it might depend on the architecture(!)... but it would
> definitely have to be an issue with testing a bunch of different versions.
> 
> What's wrong with @?
arm does not support it :-(
I recall it denote a comment in arm assembler.

I could do some magic to detect the ARM case but I'm reluctant to do so.
I could also ignore the arm issue for now as it is not used by arm,
but that strikes me as the wrong approach.


	Sam
