Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2003 21:21:36 +0100 (BST)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:4754
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225513AbTJGUVY>; Tue, 7 Oct 2003 21:21:24 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1A6yKg-0003g6-00
	for <linux-mips@linux-mips.org>; Tue, 07 Oct 2003 15:21:22 -0500
Message-ID: <3F832040.7070606@realitydiluted.com>
Date: Tue, 07 Oct 2003 16:21:20 -0400
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] Proposed NMI handling interface...
Content-Type: multipart/mixed;
 boundary="------------070004050009030404040309"
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070004050009030404040309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings.

I wanted to propose an NMI handling interface. I have attached
the header file and patches to 'arch/mips/kernel/traps.c'. The
user need only specify the offset address for the NMI vector
code and then they can also specify their own desired NMI
function. Comments?

-Steve

--------------070004050009030404040309
Content-Type: text/x-chdr;
 name="nmi.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi.h"

/*
 * linux/include/asm-mips/nmi.h
 *
 * NMI interface definitions
 *
 * Copyright (C) 2003 TimeSys Corp.
 *                    S. James Hill (James.Hill@timesys.com)
 *                                  (sjhill@realitydiluted.com)
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
 *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
 *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 */
#ifndef _ASM_NMI_H
#define _ASM_NMI_H

/*
 * NMI vector address offset.
 */
extern unsigned long nmi_addr;

/*
 * User-defined NMI function.
 */
extern void (*nmi_user_handler)(struct pt_regs *regs);

#endif

--------------070004050009030404040309
Content-Type: text/plain;
 name="traps.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps.c.diff"

--- traps.c.orig	Tue Oct  7 15:08:43 2003
+++ traps.c	Tue Oct  7 15:10:28 2003
@@ -64,6 +66,11 @@
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 
+#ifdef CONFIG_NMI
+unsigned long nmi_addr = 0;
+void (*nmi_user_handler)(struct pt_regs *regs);
+#endif
+
 int kstack_depth_to_print = 24;
 
 /*
@@ -841,6 +1095,8 @@
  */
 void nmi_exception_handler(struct pt_regs *regs)
 {
+	if (nmi_user_handler)
+		nmi_user_handler(regs);
 	printk("NMI taken!!!!\n");
 	die("NMI", regs);
 	while(1) ;
@@ -1009,6 +1265,14 @@
 		restore_fp_context = fpu_emulator_restore_context;
 	}
 
+#ifdef CONFIG_NMI
+	{
+		extern char except_vec_nmi;
+
+		memcpy((void *)(KSEG0 + nmi_addr), &except_vec_nmi, 0x8);
+	}
+#endif
+
 	flush_icache_range(KSEG0, KSEG0 + 0x400);
 
 	atomic_inc(&init_mm.mm_count);	/* XXX UP?  */

--------------070004050009030404040309--
