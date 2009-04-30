Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 20:38:07 +0100 (BST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57696 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023930AbZD3TiB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 20:38:01 +0100
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n3UJWq51029598;
	Thu, 30 Apr 2009 15:32:52 -0400 (EDT)
Received: from localhost (c-67-186-133-195.hsd1.ma.comcast.net [67.186.133.195])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n3UJWa9e002278;
	Thu, 30 Apr 2009 15:32:37 -0400 (EDT)
From:	Tim Abbott <tabbott@MIT.EDU>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Anders Kaseorg <andersk@mit.edu>, Waseem Daher <wdaher@mit.edu>,
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
	linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
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
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Tim Abbott <tabbott@mit.edu>
Subject: [PATCH 0/6] macros for section name cleanup
Date:	Thu, 30 Apr 2009 15:32:30 -0400
Message-Id: <1241119956-31453-1-git-send-email-tabbott@mit.edu>
X-Mailer: git-send-email 1.6.2.1
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@MIT.EDU
Precedence: bulk
X-list: linux-mips

Here are the architecture-independent macro definitions needed for
to clean up the kernel's section names.  The overall diffstat from
this section name cleanup project is:

 96 files changed, 261 insertions(+), 503 deletions(-)

The decrease results from removing a lot of redundancy in the linker
scripts.

The long-term goal here is to add support for building the kernel with
-ffunction-sections -fdata-sections.  This requires renaming all the
magic section names in the kernel of the form .text.foo, .data.foo,
.bss.foo, and .rodata.foo to not have collisions with sections
generated for code like:

static int nosave = 0; /* -fdata-sections places in .data.nosave */
static void head(); /* -ffunction-sections places in .text.head */

Sam Ravnborg proposed that rather than just renaming all the sections
outright, we should start by first getting more control over the
section names used in the kernel so that we can later rename sections
without touching too many files.  These patch series implement that
cleanup.  Later, there will be another patch series to actually rename
the sections.

I'm hoping we can get just these macro definitions into 2.6.30 so that
the arch maintainers don't have to grab the macro definitions for
their trees while reviewing the patches for 2.6.31.

Shortly, I'm going to send one patch series for each of the
architectures updating those architectures to use these new macros
(and otherwise cleaning up section names on those architectures).

	-Tim Abbott

Tim Abbott (6):
  Add new macros for page-aligned data and bss sections.
  Add new NOSAVE_DATA linker script macro.
  Add new CACHELINE_ALIGNED_DATA linker script macro.
  Add new INIT_TASK_DATA() linker script macro.
  Add new READ_MOSTLY_DATA(align) linker script macro.
  Add support for __read_mostly to linux/cache.h

 include/asm-generic/vmlinux.lds.h |   27 +++++++++++++++++++++++++++
 include/linux/cache.h             |    6 ++++++
 include/linux/init_task.h         |    3 +++
 include/linux/linkage.h           |    9 +++++++++
 4 files changed, 45 insertions(+), 0 deletions(-)
