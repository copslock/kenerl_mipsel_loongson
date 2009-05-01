Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 10:03:08 +0100 (BST)
Received: from pfepa.post.tele.dk ([195.41.46.235]:49144 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20027053AbZEAJDB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 10:03:01 +0100
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepa.post.tele.dk (Postfix) with ESMTP id F248FA5005B;
	Fri,  1 May 2009 11:02:45 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 35671580D0; Fri,  1 May 2009 11:04:56 +0200 (CEST)
Date:	Fri, 1 May 2009 11:04:56 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Tim Abbott <tabbott@MIT.EDU>
Cc:	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Waseem Daher <wdaher@mit.edu>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@mit.edu>,
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
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jeff Dike <jdike@addtoit.com>,
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
Subject: Re: [PATCH v2 0/6] macros for section name cleanup
Message-ID: <20090501090455.GA18326@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 03:54:07PM -0400, Tim Abbott wrote:
> (this patch series differs from v1 only in the CC list; some of the
> architecture lists I sent the previous one to are moderated against
> non-members; all replies should go to this version).
> 
> Here are the architecture-independent macro definitions needed for
> to clean up the kernel's section names.  The overall diffstat from
> this section name cleanup project is:
> 
>  96 files changed, 261 insertions(+), 503 deletions(-)
> 
> The decrease results from removing a lot of redundancy in the linker
> scripts.
> 
> The long-term goal here is to add support for building the kernel with
> -ffunction-sections -fdata-sections.  This requires renaming all the
> magic section names in the kernel of the form .text.foo, .data.foo,
> .bss.foo, and .rodata.foo to not have collisions with sections
> generated for code like:
> 
> static int nosave = 0; /* -fdata-sections places in .data.nosave */
> static void head(); /* -ffunction-sections places in .text.head */
> 
> Sam Ravnborg proposed that rather than just renaming all the sections
> outright, we should start by first getting more control over the
> section names used in the kernel so that we can later rename sections
> without touching too many files.  These patch series implement that
> cleanup.  Later, there will be another patch series to actually rename
> the sections.
> 
> I'm hoping we can get just these macro definitions into 2.6.30 so that
> the arch maintainers don't have to grab the macro definitions for
> their trees while reviewing the patches for 2.6.31.
> 
> Shortly, I'm going to send one patch series for each of the
> architectures updating those architectures to use these new macros
> (and otherwise cleaning up section names on those architectures).

Hi Tim.

We agreed to get the common stuff and one architecture done before
proceeding with the rest.
Please stick to that plan so we avoid patch-bombing lkml + maintainers.

When we have this ready it will be a simple one-patch-per-arch to cover
the rest.

I will comment on your common patches for now.

	Sam
