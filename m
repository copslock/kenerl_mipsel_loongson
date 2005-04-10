Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2005 14:06:49 +0100 (BST)
Received: from i-83-67-53-76.freedom2surf.net ([IPv6:::ffff:83.67.53.76]:27265
	"EHLO skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225942AbVDJNGd>; Sun, 10 Apr 2005 14:06:33 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1DKc95-0005MS-00; Sun, 10 Apr 2005 14:06:35 +0100
Date:	Sun, 10 Apr 2005 14:06:35 +0100
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH Cobalt 1/3] fix hang on Qube2700 boot
Message-ID: <20050410130635.GA20589@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

The Qube2700 boot hangs because the old "prom" style console is
unconditionally enabled. Drop the "prom" console code from the build. It
would only be used if no "console=" line was supplied and in that case
the current 8250 code defaults to using ttyS0 at 9600 anyway (assuming a
port exists).

--

Index: linux/arch/mips/cobalt/Makefile
===================================================================
--- linux.orig/arch/mips/cobalt/Makefile	2003-11-13 14:30:45.000000000 +0000
+++ linux/arch/mips/cobalt/Makefile	2005-04-10 13:16:58.000000000 +0100
@@ -2,6 +2,6 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y	 := irq.o int-handler.o reset.o setup.o promcon.o
+obj-y	 := irq.o int-handler.o reset.o setup.o
 
 EXTRA_AFLAGS := $(CFLAGS)
