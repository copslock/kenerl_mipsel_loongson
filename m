Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2010 22:08:42 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:44892 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492612Ab0ATVIi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2010 22:08:38 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NXhmx-0001LZ-8s
        for linux-mips@linux-mips.org; Wed, 20 Jan 2010 22:08:31 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 Jan 2010 22:08:31 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 Jan 2010 22:08:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject:  [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
Date:   Wed, 20 Jan 2010 20:50:07 +0000
Message-ID:  <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
X-archive-position: 25621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13549

Counter to the documentation for the dash shell, it seems that on my
x86_64 filth under Debian only does 32bit math.  As I have configured my
lapdog to use 'dash' for non-interactive tasks I run into problems when
compiling a compressed kernel.

I play with the AR7 platform, so VMLINUX_LOAD_ADDRESS is
0xffffffff94100000, and for an example 4MiB kernel
VMLINUZ_LOAD_ADDRESS is made out to be:
----
alex@berk:~$ bash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
ffffffff94500000
alex@berk:~$ dash -c 'printf "%x\n" $((0xffffffff94100000 + 0x400000))'
80000000003fffff
----

The former is obviously correct whilst the later breaks things royally.

Fortunately working with only the lower 32bit's works for both bash and
dash:
----
$ bash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
94500000
$ dash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
94500000
----

So, we can split the original 64bit string to two parts, and only
calculate the low 32bit part, which is big enough (1GiB kernel sizes
anyone?) for a normal Linux kernel image file, now, we calculate the
VMLINUZ_LOAD_ADDRESS like this:

1. if present, append top 32bit of VMLINUX_LOAD_ADDRESS" as a prefix
2. get the sum of the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE

This patch fixes vmlinuz kernel builds on systems where only a 
32bit-only math shell is available.

Patch Changelog:
  Version 2
    - simplified method by using 'expr' for 'substr' and making it work 
	with dash once again
  Version 1
    - Revert the removals of '-n "$(VMLINUX_SIZE)"' to avoid the error  
        of "make clean"
    - Consider more cases of the VMLINUX_LOAD_ADDRESS
  Version 0
    - initial release

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
Acked-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 671d344..ab78095 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -14,8 +14,11 @@
 
 # compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
 VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
-VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
-VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
+VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo -n $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
+# VMLINUZ_LOAD_ADDRESS = concat "high32 of VMLINUX_LOAD_ADDRESS" and "(low32 of VMLINUX_LOAD_ADDRESS) + VMLINUX_SIZE"
+HIGH32 := $(shell A=$(VMLINUX_LOAD_ADDRESS); [ $${\#A} -gt 10 ] && expr substr "$(VMLINUX_LOAD_ADDRESS)" 3 $$(($${\#A} - 10)))
+LOW32 := $(shell [ -n "$(HIGH32)" ] && A=11 || A=3; expr substr "$(VMLINUX_LOAD_ADDRESS)" $${A} 8)
+VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" -a -n "$(LOW32)" ] && printf "$(HIGH32)%08x" $$(($(VMLINUX_SIZE) + 0x$(LOW32))))
 
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
-- 
1.6.6
