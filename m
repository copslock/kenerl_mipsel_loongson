Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2016 02:47:29 +0200 (CEST)
Received: from smtpproxy19.qq.com ([184.105.206.84]:49248 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992226AbcIEArWwXki0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Sep 2016 02:47:22 +0200
X-QQ-mid: bizesmtp15t1473036427tys248jp
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 05 Sep 2016 08:46:47 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72B00A0000000
X-QQ-FEAT: /A5Igf99+LSJIxmnJR8hAHFGvrBj5CoMXOu6BMcptsFnerFqSRBI9RxPbw0S5
        AGQ2LPuKAn6Q3CGfZU6vcrRXHjc2FeroLvjEk+Fz003FKFBhdgMW+I2lAsUlHsQ7W49lP7x
        W7kbbN2nssaqS8smbawiKx2isuDcxaCQh7HMDJPz4X3oQSTdvP/R4mzMP+GhfRHtOuKEk54
        8V+288Ve4UfLhHWpRLqjAT+9gmIZ5vmVgYIEOkMHNrInrFFNkEs1VDp/PYYq7VDLmPOOdEB
        qUINT3lD99dyd+
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Add a missing ".set pop" in an early commit
Date:   Mon,  5 Sep 2016 08:48:03 +0800
Message-Id: <1473036483-1876-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Commit 842dfc11ea9a21 ("MIPS: Fix build with binutils 2.24.51+") missing
a ".set pop" in macro fpu_restore_16even, so add it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/asmmacro.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 56584a6..83054f7 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -157,6 +157,7 @@
 	ldc1	$f28, THREAD_FPR28(\thread)
 	ldc1	$f30, THREAD_FPR30(\thread)
 	ctc1	\tmp, fcr31
+	.set	pop
 	.endm
 
 	.macro	fpu_restore_16odd thread
-- 
2.7.0
