Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 01:08:38 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:34734 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492880Ab0ASAIe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jan 2010 01:08:34 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NX1e2-0002tC-2p
        for linux-mips@linux-mips.org; Tue, 19 Jan 2010 01:08:30 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2010 01:08:30 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2010 01:08:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject:  [PATCH] MIPS: fix vmlinuz build when only 32bit math shell is available
Date:   Mon, 18 Jan 2010 23:17:27 +0000
Message-ID:  <7p6f27-emk.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
X-archive-position: 25605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12164

Counter to the documentation for the dash shell, it seems that on my
x86_64 filth under Debian only does 32bit math.  As I have configured
my lapdog to use 'dash' for non-interactive tasks I run into problems
when compiling a compressed kernel.

I play with the AR7 platform, so VMLINUX_LOAD_ADDRESS is
0xffffffff94100000, and for a (for example) 4MiB kernel
VMLINUZ_LOAD_ADDRESS is made out to be:
----
alex@berk:~$ bash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
ffffffff94500000
alex@berk:~$ dash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
80000000003fffff
----

The former is obviously correct whilst the later breaks things royally.

This patch fixes vmlinuz kernel builds on systems where only a 32bit
math enabled shell is a available.  It does this by bringing 'bc' back
in as a build dependency (Wu Zhangjin had orginally used 'bc' but I had
suggested he 'fixes' the original dependency *sigh*) but things now seem
to work as expected.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/boot/compressed/Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 671d344..65d1adf 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -14,8 +14,10 @@
 
 # compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
 VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
-VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
-VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
+VMLINUX_SIZE := $(shell printf %X $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
+VMLINUZ_LOAD_ADDRESS := $(shell A=$(VMLINUX_LOAD_ADDRESS); A=$${A\#0xffffffff}; echo $${A\#0x} | tr a-f A-F)
+VMLINUZ_LOAD_ADDRESS := $(shell echo "obase=16; ibase=16; $(VMLINUZ_LOAD_ADDRESS) + $(VMLINUX_SIZE)" | bc)
+VMLINUZ_LOAD_ADDRESS := $(shell A=$(VMLINUX_LOAD_ADDRESS); [ "$${A\#0xffffffff}" = "$${A}" ] && echo 0x$(VMLINUZ_LOAD_ADDRESS) || echo 0xffffffff$(VMLINUZ_LOAD_ADDRESS))
 
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
-- 
1.6.6
