Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Jan 2007 18:11:23 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:48873 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20038287AbXA1SLT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Jan 2007 18:11:19 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1HBERj-0004xA-CW; Sun, 28 Jan 2007 13:08:07 -0500
Date:	Sun, 28 Jan 2007 13:08:07 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	linux-mips@linux-mips.org
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>, ralf@linux-mips.org
Subject: RFC: Sentosa boot fix
Message-ID: <20070128180807.GA18890@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

From: Daniel Jacobowitz <dan@codesourcery.com>

Always support CKSEG0 for 64-bit kernels.

This prevents an early exception when used without a ramdisk.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

---

Here's a crude patch that lets my Sentosa boot using GIT HEAD.
The problem is __pa_symbol(&_end); the kernel is linked at
0xffffffff80xxxxxx, so subtracting a PAGE_OFFSET of 0xa800000000000000
does not do anything useful to this address at all.

This may be the wrong fix, but if so, I don't understand what's going
on.  What does CKSEG0 have to do with !CONFIG_BUILD_ELF64?

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 2f9e1a9..81dc8a6 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -132,7 +132,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
+#if defined(CONFIG_64BIT)
 #define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
 #else
 #define __pa_page_offset(x)	PAGE_OFFSET

-- 
Daniel Jacobowitz
CodeSourcery
