Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 21:34:01 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:42937
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994645AbeJXTd0ZJ0jL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 21:33:26 +0200
Received: by mail-pg1-x543.google.com with SMTP id i4-v6so2795867pgq.9
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8Yi7ueBJYSGPnl2J+y90jQpIuvIYmkZHV1ezCwJjgw=;
        b=X8qXYx98KGASUvBgWDX6YL5T5CXdOj9tEbpP9mF3RNRaqdyFJEAmLF/tiJ1T6tZp5P
         xo2FwK/+6fRXFOlSr3/5oKxJEbkMiAC/rPixr8RJVQHB0skYXcyYdKIm4Wy0uA1jyR0q
         54jqHeFW1gM37iOa3thSYCISwEHX+Ywz/mKKq86R/QCkdfHLhJpOkIG/rzxNz62KXS8E
         MId8IvqDn7ul+QgH8eB9mc0rGiO++2J1ElANQqB6Gg5GIIo9e6zTMewMomAl5+9xK2ST
         fqPADGlW6WfjNzJ9dPp/PjKY5qi/3exxxoy6Vm0QdefqSYNoAwoT5FFFlbSPJM4jst6E
         a8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v8Yi7ueBJYSGPnl2J+y90jQpIuvIYmkZHV1ezCwJjgw=;
        b=fsw26MoCn/xKilf7OCHeIuitBEr4WVnPvJhXtzXnRLQnyiGuQto/AVCiwFaWLdO7Sj
         z1QZFjL3xZDNgpxmSt6OHg4Kd2Er8mnDpwCsrCGvFn1xqZdXamXssQeGxPT3ZzZDxG4j
         fhy90Trp//s5fXPITymAaXTWJRVZt4zVDG4C6ov1XIRuqyON72tVZmnvD2Uh8DiHJikp
         jrRVGJ+ck+LU8XCE4/gHS+Xkl6345IrDoImjPZOAnxKZTiD74mlCnXFD78CXjtm7IFPX
         W8TJwXcdFcjC/uTxuiTbB7lEEF8HVl13YBxZz0z2GZqk3vIln06fXFvbkBdARQlW6Gg7
         G1nA==
X-Gm-Message-State: AGRZ1gIj1blk47uIhNparlvUh+WLD7et7fBXy1QhQDVTRepQlpGaPbrt
        IERkCabUqsrcXal3X5bLJjw=
X-Google-Smtp-Source: AJdET5e3oklkZJl6VLmc9P+CGQ6GZjw475mB8zXT96bhabntKvO9g5ltPujlD6PYuuoSOZoG7K1pwQ==
X-Received: by 2002:a62:e80c:: with SMTP id c12-v6mr3920623pfi.124.1540409599360;
        Wed, 24 Oct 2018 12:33:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j187-v6sm9818878pfc.39.2018.10.24.12.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:33:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        linux-alpha@vger.kernel.org (open list:ALPHA PORT),
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-c6x-dev@linux-c6x.org (open list:C6X ARCHITECTURE),
        uclinux-h8-devel@lists.sourceforge.jp (moderated list:H8/300
        ARCHITECTURE),
        linux-hexagon@vger.kernel.org (open list:QUALCOMM HEXAGON ARCHITECTURE),
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE),
        linux-mips@linux-mips.org (open list:MIPS),
        nios2-dev@lists.rocketboards.org (moderated list:NIOS2 ARCHITECTURE),
        openrisc@lists.librecores.org (open list:OPENRISC ARCHITECTURE),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT)),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-s390@vger.kernel.org (open list:S390),
        linux-sh@vger.kernel.org (open list:SUPERH),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64)),
        linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 1/2] arch: Add asm-generic/initrd.h and make use of it for most architectures
Date:   Wed, 24 Oct 2018 12:32:55 -0700
Message-Id: <20181024193256.23734-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024193256.23734-1-f.fainelli@gmail.com>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

In preparation for separating the definition of
__early_init_dt_declare_initrd() on ARM64 in order to cut the amount of
files that require a rebuild when CONFIG_BLK_DEV_INITRD value is
changed, introduce an empty asm-generic initrd.h file and update all
architectures but arm64 to make use of it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/alpha/include/asm/Kbuild      | 1 +
 arch/arc/include/asm/Kbuild        | 1 +
 arch/arm/include/asm/Kbuild        | 1 +
 arch/c6x/include/asm/Kbuild        | 1 +
 arch/h8300/include/asm/Kbuild      | 1 +
 arch/hexagon/include/asm/Kbuild    | 1 +
 arch/ia64/include/asm/Kbuild       | 1 +
 arch/m68k/include/asm/Kbuild       | 1 +
 arch/microblaze/include/asm/Kbuild | 1 +
 arch/mips/include/asm/Kbuild       | 1 +
 arch/nds32/include/asm/Kbuild      | 1 +
 arch/nios2/include/asm/Kbuild      | 1 +
 arch/openrisc/include/asm/Kbuild   | 1 +
 arch/parisc/include/asm/Kbuild     | 1 +
 arch/powerpc/include/asm/Kbuild    | 1 +
 arch/riscv/include/asm/Kbuild      | 1 +
 arch/s390/include/asm/Kbuild       | 1 +
 arch/sh/include/asm/Kbuild         | 1 +
 arch/sparc/include/asm/Kbuild      | 1 +
 arch/um/include/asm/Kbuild         | 1 +
 arch/unicore32/include/asm/Kbuild  | 1 +
 arch/x86/include/asm/Kbuild        | 1 +
 arch/xtensa/include/asm/Kbuild     | 1 +
 include/asm-generic/initrd.h       | 1 +
 24 files changed, 24 insertions(+)
 create mode 100644 include/asm-generic/initrd.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 0580cb8c84b2..cd6f723aed1b 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += compat.h
 generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
+generic-y += initrd.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index feed50ce89fa..ba18632aa493 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -10,6 +10,7 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kmap_types.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 1d66db9c9db5..b91d5b32e64f 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += local.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 33a2c94fed0d..9e14cf6e89b4 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += extable.h
 generic-y += fb.h
 generic-y += futex.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += io.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index a5d0b2991f47..7d4e06a757c8 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -19,6 +19,7 @@ generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hash.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 47c4da3d64a4..0be62abf2123 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += iomap.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 557bbc8ba9f5..1a1f1e4ba0d5 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += compat.h
 generic-y += exec.h
+generic-y += initrd.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index a4b8d3331a9e..9903551e0c9c 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += futex.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 569ba9e670c1..ec37e6304be5 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -11,6 +11,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
 generic-y += hardirq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 9a81e72119da..005ef04a4c73 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += device.h
 generic-y += dma-contiguous.h
 generic-y += emergency-restart.h
 generic-y += export.h
+generic-y += initrd.h
 generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index dbc4e5422550..1400aaf0c840 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += ftrace.h
 generic-y += gpio.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += ioctl.h
 generic-y += ioctls.h
 generic-y += irq.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 8fde4fa2c34f..d89de02549ee 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -18,6 +18,7 @@ generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index eb87cd8327c8..296fd55e8473 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -15,6 +15,7 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 2013d639e735..1382d78a2477 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 3196d227e351..e3ea67c30605 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += div64.h
 generic-y += export.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += local64.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index efdbe311e936..0e67ed69c423 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hash.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += ioctl.h
 generic-y += ioctls.h
 generic-y += ipcbuf.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e3239772887a..dc618745d427 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += export.h
 generic-y += fb.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kmap_types.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 6a5609a55965..c006a7cf3a43 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += div64.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += local.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 410b263ef5c8..a5772c2a96c8 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += export.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += linkage.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b10dde6cb793..032cfe1b530b 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -12,6 +12,7 @@ generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += io.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1372553dc0a9..32e7dea45fcd 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index a0ab9ab61c75..290bd1c3ee2d 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -9,5 +9,6 @@ generated-y += xen-hypercalls.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += export.h
+generic-y += initrd.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 82c756431b49..f2c363f2d22a 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
 generic-y += hardirq.h
+generic-y += initrd.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/include/asm-generic/initrd.h b/include/asm-generic/initrd.h
new file mode 100644
index 000000000000..40a8c178f10d
--- /dev/null
+++ b/include/asm-generic/initrd.h
@@ -0,0 +1 @@
+/* empty */
-- 
2.17.1
