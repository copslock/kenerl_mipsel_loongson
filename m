Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 10:43:51 +0100 (CET)
Received: from mail-iw0-f196.google.com ([209.85.223.196]:61856 "EHLO
        mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491791Ab0ASJno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2010 10:43:44 +0100
Received: by iwn34 with SMTP id 34so2645451iwn.21
        for <multiple recipients>; Tue, 19 Jan 2010 01:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=h250tB2N8sBORvWQ71mv+I2+itppLEeSoyl1wH35Bf4=;
        b=Uk49XRL+7gWYKb0fxTKGKcbnBvPTzsSAB1xT0cr8dGQVuW6W+DpP7jrmrd9TwgB0pb
         7JPz2399QJOY82aq2s1expoPKEjWHPsRbJhNkeerN5da0SNbxORNYPZgymm7C+ql57Cn
         C7wXk+bSRqCdyDp7yCFqFE2TahDDtG8JOtQmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=j24BVsLuEbp0BTEJbaj/yv3LLhx4/6XwGDGozCAsb0itdhPe2W7G8s50xJYDypXxcj
         YUt1RMMIiDZt+mW/isvKRUoM2XIIbZRbUyqW7epKHoHxVpnzCqZ8qTLPgIKA1xmUlHGM
         wtPR7LJ/WOiUhZyL8/GWbhBoaLHePg3jXHnuU=
Received: by 10.231.147.70 with SMTP id k6mr1192810ibv.55.1263894216467;
        Tue, 19 Jan 2010 01:43:36 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm5193800iwn.14.2010.01.19.01.43.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 01:43:35 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Alexander Clouter <alex@digriz.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH v1] MIPS: fix vmlinuz build when only 32bit math shell is available
Date:   Tue, 19 Jan 2010 17:43:09 +0800
Message-Id: <42fa29d2007a40a31a0bb8fbf1091e11eb9b5ac2.1263893871.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
X-archive-position: 25608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12377

Hi, Alexander Clouter

Does this revision work for you?

Regards,
		Wu Zhangjin

-------------------------------

Changes from v0:

	- Revert the '-n "$(VMLINUX_SIZE)"' to avoid the error of "make clean"
	- Consider more situations of the VMLINUX_LOAD_ADDRESS

Counter to the documentation for the dash shell, it seems that on my
x86_64 filth under Debian only does 32bit math.  As I have configured my
lapdog to use 'dash' for non-interactive tasks I run into problems when
compiling a compressed kernel.

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

But fortunately, this works for both bash and dash:

----
$ bash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
94500000
$ dash -c 'printf "%x\n" $((0x94100000 + 0x400000))'
94500000
----

So, we can split the original 64bit string to two parts, and only
calculate the low 32bit part, which is big enough(about 4095 M) for a
normal linux kernel image file, now, we calculate the
VMLINUZ_LOAD_ADDRESS like this:

1. Append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it
exists.

2. Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
with printf "%08x" (08 herein is used to prefix the result with 0...)

The corresponding shell script is:

  A=$VMLINUX_LOAD_ADDRESS;
  # Append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it exists.
  [ "${A:0:10}" != "${A}" ] && echo -n ${A:2:8};
  # Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
  printf "%08x" $(($VMLINUX_SIZE + 0x${A:(-8)}))

This patch fixes vmlinuz kernel builds on systems where only a 32bit
math enabled shell is a available.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 569b6ad..0c4eb01 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -15,7 +15,11 @@
 # compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
 VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
 VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
-VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
+# VMLINUZ_LOAD_ADDRESS = concat "high32 of VMLINUX_LOAD_ADDRESS" and "(low32 of VMLINUX_LOAD_ADDRESS) + VMLINUX_SIZE"
+VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && ( \
+				A=$(VMLINUX_LOAD_ADDRESS); \
+				[ "$${A:0:10}" != "$${A}" ] && echo -n $${A:2:8}; \
+				printf "%08x" $$(($(VMLINUX_SIZE) + 0x$${A:(-8)})) ))
 
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
-- 
1.6.5.6
