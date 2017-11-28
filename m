Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:26:53 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:41167 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990490AbdK1P0rMSrcY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:26:47 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 15:25:40 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 28 Nov 2017 07:22:29 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-serial@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "stable # 4 . 14" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2] MIPS: Add custom serial.h with BASE_BAUD override for generic kernel
Date:   Tue, 28 Nov 2017 15:22:20 +0000
Message-ID: <1511882540-25743-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1511882738-321458-29292-53256-7
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 3.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187380
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        2.50 BSF_SC0_MV0249         META: Custom rule MV0249 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=3.10 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MV0249, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Add a custom serial.h header for MIPS, allowing platforms to override
the asm-generic version if required.

The generic platform uses this header to set BASE_BAUD to 0. The
generic platform supports multiple boards, which may have different
UART clocks. Also one of the boards supported is the Boston FPGA board,
where the UART clock depends on the loaded FPGA bitfile. As such there
is no way that the generic kernel can set a compile time default
BASE_BAUD.

Commit 31cb9a8575ca ("earlycon: initialise baud field of earlycon device
structure") changed the behavior of of_setup_earlycon such that any baud
rate set in the device tree is now set in the earlycon structure. The
UART driver will then calculate a divisor based on BASE_BAUD and set it.
With MIPS generic kernels this resulted in garbage output due to the
incorrect uart clock rate being used to calculate a divisor. This
commit, combined with "serial: 8250_early: Only set divisor if valid clk
& baud" prevents the earlycon code setting a bad divisor and restores
earlycon output.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Cc: stable <stable@vger.kernel.org> # 4.14
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v2:
GPL v2

 arch/mips/include/asm/Kbuild   |  1 -
 arch/mips/include/asm/serial.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/serial.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7c8aab23bce8..b1f66699677d 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -16,7 +16,6 @@ generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += sections.h
 generic-y += segment.h
-generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += user.h
diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
new file mode 100644
index 000000000000..1d830c6666c2
--- /dev/null
+++ b/arch/mips/include/asm/serial.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017 MIPS Tech, LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __ASM__SERIAL_H
+#define __ASM__SERIAL_H
+
+#ifdef CONFIG_MIPS_GENERIC
+/*
+ * Generic kernels cannot know a correct value for all platforms at
+ * compile time. Set it to 0 to prevent 8250_early using it
+ */
+#define BASE_BAUD 0
+#else
+#include <asm-generic/serial.h>
+#endif
+
+#endif /* __ASM__SERIAL_H */
-- 
2.7.4
