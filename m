Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 17:52:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61284 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861312AbaGPPvzrPEww (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 17:51:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5D22989EF8981;
        Wed, 16 Jul 2014 16:51:46 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 16 Jul 2014 16:51:48 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 16 Jul 2014 16:51:48 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <m.szyprowski@samsung.com>, <mina86@mina86.com>
CC:     <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-arch@vger.kernel.org>
Subject: [PATCH 3/4] x86: use generic dma-contiguous.h
Date:   Wed, 16 Jul 2014 16:51:31 +0100
Message-ID: <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

dma-contiguous.h is now in asm-generic. Use that to avoid code
repetition in x86.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/x86/include/asm/Kbuild           |  1 +
 arch/x86/include/asm/dma-contiguous.h | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)
 delete mode 100644 arch/x86/include/asm/dma-contiguous.h

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 3bf000f..d55a210 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -6,6 +6,7 @@ genhdr-y += unistd_x32.h
 
 generic-y += clkdev.h
 generic-y += cputime.h
+generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += scatterlist.h
diff --git a/arch/x86/include/asm/dma-contiguous.h b/arch/x86/include/asm/dma-contiguous.h
deleted file mode 100644
index b4b38ba..0000000
--- a/arch/x86/include/asm/dma-contiguous.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef ASMX86_DMA_CONTIGUOUS_H
-#define ASMX86_DMA_CONTIGUOUS_H
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-static inline void
-dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
-
-#endif
-#endif
-- 
1.9.1
