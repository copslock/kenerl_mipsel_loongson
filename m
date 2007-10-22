Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 14:22:55 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19928 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024106AbXJVNWw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 14:22:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9MDLVVg010996;
	Mon, 22 Oct 2007 14:21:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9MDLVFS010995;
	Mon, 22 Oct 2007 14:21:31 +0100
Date:	Mon, 22 Oct 2007 14:21:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Wolfgang Denk <wd@denx.de>, linux-mips@linux-mips.org
Subject: Re: MIPS Makefile not picking up CROSS_COMPILE from environment
	setting
Message-ID: <20071022132131.GA31311@linux-mips.org>
References: <20071018184636.48637242E9@gemini.denx.de> <Pine.LNX.4.64.0710190915130.23164@anakin> <Pine.LNX.4.64.0710211036540.6155@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710211036540.6155@anakin>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 21, 2007 at 10:37:29AM +0200, Geert Uytterhoeven wrote:

> > BTW, currently there's a discussion about such things on lkml under the
> > subject `Make m68k cross compile like every other architecture.'.
> > 
> > As you can probably guess, MIPS is unlike every other architecture, too ;-)
> 
> cc-cross-prefix got into mainline:
> 910b40468a9ce3f2f5d48c5d260329c27d45adb5

So then here is a followup patch also unlike any other ;-)

As a convenience for MIPS hacking I keep ARCH hardweired to mips though.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

 Makefile           |    7 +++++--
 arch/mips/Makefile |    6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 94b8705..6ad9eda 100644
--- a/Makefile
+++ b/Makefile
@@ -165,7 +165,10 @@ export srctree objtree VPATH TOPDIR
 # then ARCH is assigned, getting whatever value it gets normally, and 
 # SUBARCH is subsequently ignored.
 
-SUBARCH := mips
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
+				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
@@ -186,7 +189,7 @@ SUBARCH := mips
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
 
-ARCH		?= $(SUBARCH)
+ARCH		?= mips
 CROSS_COMPILE	?=
 
 # Architecture as present in compile.h
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 14164c2..00a3033 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -42,8 +42,10 @@ tool-prefix		= $(64bit-tool-prefix)
 UTS_MACHINE		:= mips64
 endif
 
-ifdef CONFIG_CROSSCOMPILE
-CROSS_COMPILE		:= $(tool-prefix)
+ifneq ($(SUBARCH),$(ARCH))
+  ifeq ($(CROSS_COMPILE),)
+    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-prefix))
+  endif
 endif
 
 ifdef CONFIG_32BIT
