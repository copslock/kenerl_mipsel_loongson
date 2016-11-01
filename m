Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 18:11:55 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:40000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993206AbcKARLsIJNY6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 18:11:48 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D82646167D; Tue,  1 Nov 2016 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1478020306;
        bh=cvhKjxqqRT8HG2LYlHkU8YYP4pTCyMiv9IdTn2E3UlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTH+aMNqpUwB+ptFvVaqptuao7cSntxXKq1tYRrsfJvfSZl/Vh23COBodFuvOJIqu
         tkKjDVpBTq+UIJAyjTWqvoky98mPsNI4xzZuUKOrTSta4UUPCzfCOe358fhtIteQVQ
         bHlI54s+8IwKXaua08ARRpzi4ehha1CGO23LASPk=
Received: from localhost.localdomain (unknown [198.233.217.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cov@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABCA262346;
        Tue,  1 Nov 2016 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1478020284;
        bh=cvhKjxqqRT8HG2LYlHkU8YYP4pTCyMiv9IdTn2E3UlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOUS5y5+Y22kRMWPPhIUWAcxbMGsfI51mScQLHIjNNBJFb+nC7G573mm/BrMYCBHr
         /2VbQ6ERVVuI+dcLTp5IzSqN68g6caIzVVi62Upz66ts+eXe07KZYbCZBMqVVJzJ3u
         yunccvhIA9WQS8zLLLTaSlhTCVPx4q7+yi7avp9I=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org ABCA262346
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=cov@codeaurora.org
From:   Christopher Covington <cov@codeaurora.org>
To:     criu@openvz.org, Will Deacon <will.deacon@arm.com>,
        linux-mm@kvack.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc:     Christopher Covington <cov@codeaurora.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: [RFC v2 7/7] mm: Remove mm-arch-hooks.h
Date:   Tue,  1 Nov 2016 11:11:01 -0600
Message-Id: <20161101171101.24704-7-cov@codeaurora.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20161101171101.24704-1-cov@codeaurora.org>
References: <20161101171101.24704-1-cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cov@codeaurora.org
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

The only use case, VDSO remap support for PowerPC, has been made generic
instead of architecture-specific. Since the infrastructure is no longer
needed, remove it.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/alpha/include/asm/Kbuild      |  1 -
 arch/arc/include/asm/Kbuild        |  1 -
 arch/arm/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/avr32/include/asm/Kbuild      |  1 -
 arch/blackfin/include/asm/Kbuild   |  1 -
 arch/c6x/include/asm/Kbuild        |  1 -
 arch/cris/include/asm/Kbuild       |  1 -
 arch/frv/include/asm/Kbuild        |  1 -
 arch/h8300/include/asm/Kbuild      |  1 -
 arch/hexagon/include/asm/Kbuild    |  1 -
 arch/ia64/include/asm/Kbuild       |  1 -
 arch/m32r/include/asm/Kbuild       |  1 -
 arch/m68k/include/asm/Kbuild       |  1 -
 arch/metag/include/asm/Kbuild      |  1 -
 arch/microblaze/include/asm/Kbuild |  1 -
 arch/mips/include/asm/Kbuild       |  1 -
 arch/mn10300/include/asm/Kbuild    |  1 -
 arch/nios2/include/asm/Kbuild      |  1 -
 arch/openrisc/include/asm/Kbuild   |  1 -
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/s390/include/asm/Kbuild       |  1 -
 arch/score/include/asm/Kbuild      |  1 -
 arch/sh/include/asm/Kbuild         |  1 -
 arch/sparc/include/asm/Kbuild      |  1 -
 arch/tile/include/asm/Kbuild       |  1 -
 arch/um/include/asm/Kbuild         |  1 -
 arch/unicore32/include/asm/Kbuild  |  1 -
 arch/x86/include/asm/Kbuild        |  1 -
 arch/xtensa/include/asm/Kbuild     |  1 -
 include/asm-generic/mm_hooks.h     | 16 ----------------
 mm/mremap.c                        | 20 +++++++++++++++++---
 32 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index bf8475c..0a5e0ec 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -6,7 +6,6 @@ generic-y += exec.h
 generic-y += export.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index c332604..e6059a8 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -22,7 +22,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += msi.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 0745538..44b717c 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -15,7 +15,6 @@ generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += local.h
 generic-y += local64.h
-generic-y += mm-arch-hooks.h
 generic-y += msgbuf.h
 generic-y += msi.h
 generic-y += param.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 44e1d7f..a42a136 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += msi.h
diff --git a/arch/avr32/include/asm/Kbuild b/arch/avr32/include/asm/Kbuild
index 241b9b9..519810d 100644
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -12,7 +12,6 @@ generic-y += irq_work.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += param.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 91d49c0..c80181e 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -21,7 +21,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += mutex.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 64465e7..1b9cbed 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -27,7 +27,6 @@ generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += mmu.h
 generic-y += mmu_context.h
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 1778805..8e98d03 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -24,7 +24,6 @@ generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += module.h
 generic-y += msgbuf.h
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index 1fa084c..2c987dc 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += cputime.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 373cb23..2a63a32 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -33,7 +33,6 @@ generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += mmu.h
 generic-y += mmu_context.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index db8ddab..0988816 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -28,7 +28,6 @@ generic-y += kmap_types.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += pci.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 502a91d..dc05773 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += exec.h
 generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 860e440..f09a5fd 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -5,7 +5,6 @@ generic-y += exec.h
 generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += module.h
 generic-y += preempt.h
 generic-y += sections.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index eb85bd9..1555bc1 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += mutex.h
 generic-y += percpu.h
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
index 29acb89d..611c0df 100644
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -25,7 +25,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += msgbuf.h
 generic-y += mutex.h
 generic-y += param.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index b0ae88c..cefeaba 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -6,7 +6,6 @@ generic-y += device.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += syscalls.h
 generic-y += trace_clock.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 9740066..f0ce0ae 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -8,7 +8,6 @@ generic-y += emergency-restart.h
 generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mutex.h
 generic-y += parport.h
 generic-y += percpu.h
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index 1c8dd0f..27cbc02 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -5,7 +5,6 @@ generic-y += cputime.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d63330e..e224789 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -30,7 +30,6 @@ generic-y += kmap_types.h
 generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += module.h
 generic-y += msgbuf.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 2832f03..2a2e39b 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -36,7 +36,6 @@ generic-y += kmap_types.h
 generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += module.h
 generic-y += msgbuf.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index f9b3a81..12b341d 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -15,7 +15,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mutex.h
 generic-y += param.h
 generic-y += percpu.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 20f196b..c1ef825 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += clkdev.h
 generic-y += export.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index a05218f..ff19975 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -7,7 +7,6 @@ generic-y += clkdev.h
 generic-y += cputime.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 751c337..7d1fb2c 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += param.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index cfc9180..0867d5a 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += module.h
 generic-y += mutex.h
 generic-y += preempt.h
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index ba35c41..40d22b4 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -19,7 +19,6 @@ generic-y += irq_regs.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += msgbuf.h
 generic-y += mutex.h
 generic-y += param.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 904f3eb..33c1d3e 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -16,7 +16,6 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mutex.h
 generic-y += param.h
 generic-y += pci.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 256c45b..932070c 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -26,7 +26,6 @@ generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += module.h
 generic-y += msgbuf.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 2cfed17..51b3d95 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -15,4 +15,3 @@ generic-y += cputime.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 28cf4c5..bdade99 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += resource.h
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index 73f09f1..f4d43aa 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -3,7 +3,6 @@
  * included in asm-FOO/mmu_context.h for any arch FOO which doesn't need to
  * specially hook these.
  *
- * arch_remap originally from include/linux-mm-arch-hooks.h
  * arch_unmap originally from arch/powerpc/include/asm/mmu_context.h
  * Copyright (C) 2015, IBM Corporation
  * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
@@ -35,21 +34,6 @@ static inline void arch_unmap(struct mm_struct *mm,
 #endif /* CONFIG_GENERIC_VDSO */
 }
 
-static inline void arch_remap(struct mm_struct *mm,
-			      unsigned long old_start, unsigned long old_end,
-			      unsigned long new_start, unsigned long new_end)
-{
-#ifdef CONFIG_GENERIC_VDSO
-	/*
-	 * mremap() doesn't allow moving multiple vmas so we can limit the
-	 * check to old_addr == vdso.
-	 */
-	if (old_addr == mm->context.vdso)
-		mm->context.vdso = new_addr;
-
-#endif /* CONFIG_GENERIC_VDSO */
-}
-
 static inline void arch_bprm_mm_init(struct mm_struct *mm,
 				     struct vm_area_struct *vma)
 {
diff --git a/mm/mremap.c b/mm/mremap.c
index da22ad2..0d0ea14 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -5,6 +5,14 @@
  *
  *	Address space accounting code	<alan@lxorguk.ukuu.org.uk>
  *	(C) Copyright 2002 Red Hat Inc, All Rights Reserved
+ *
+ *	arch_remap originally from include/linux-mm-arch-hooks.h
+ *	Copyright (C) 2015, IBM Corporation
+ *	Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2 as
+ *	published by the Free Software Foundation.
  */
 
 #include <linux/mm.h>
@@ -21,7 +29,6 @@
 #include <linux/syscalls.h>
 #include <linux/mmu_notifier.h>
 #include <linux/uaccess.h>
-#include <linux/mm-arch-hooks.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -293,8 +300,15 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_addr = new_addr;
 		new_addr = err;
 	} else {
-		arch_remap(mm, old_addr, old_addr + old_len,
-			   new_addr, new_addr + new_len);
+#ifdef CONFIG_GENERIC_VDSO
+		/*
+		 * mremap() doesn't allow moving multiple vmas so we can limit
+		 * the check to old_addr == vdso.
+		 */
+		if (old_addr == mm->context.vdso)
+			mm->context.vdso = new_addr;
+
+#endif /* CONFIG_GENERIC_VDSO */
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
