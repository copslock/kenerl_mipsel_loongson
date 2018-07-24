Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 13:52:19 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:37316 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXLwQU9MIS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 13:52:16 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3E43920756; Tue, 24 Jul 2018 13:52:10 +0200 (CEST)
Received: from localhost (unknown [109.29.199.176])
        by mail.bootlin.com (Postfix) with ESMTPSA id F03462072B;
        Tue, 24 Jul 2018 13:52:09 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] mips: use asm-generic version of msi.h
Date:   Tue, 24 Jul 2018 13:52:08 +0200
Message-Id: <20180724115208.11199-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
Return-Path: <thomas.petazzoni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@bootlin.com
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

This is necessary to be able to include <linux/msi.h> when
CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:

   In file included from include/linux/kvm_host.h:20:0,
                    from arch/mips/kernel/asm-offsets.c:24:
>> include/linux/msi.h:197:10: fatal error: asm/msi.h: No such file or directory
    #include <asm/msi.h>
             ^~~~~~~~~~~
   compilation terminated.
   make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/mips/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 45d541baf359..58351e48421e 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
-- 
2.14.4
