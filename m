Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 11:22:29 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:48877 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009081AbaLRKVsulKkR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 11:21:48 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 13:21:43 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 06/12] MIPS: OCTEON: Implement the core-16057 workaround
Date:   Thu, 18 Dec 2014 13:17:58 +0300
Message-ID: <1418897888-17669-7-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Disable ICache prefetch for certian Octeon II processors.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index 1668ee5..21732c3 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -63,6 +63,28 @@ skip:
 	li	v1, ~(7 << 7)
 	and	v0, v0, v1
 	ori	v0, v0, (6 << 7)
+
+	mfc0	v1, CP0_PRID_REG
+	and	t1, v1, 0xfff8
+	xor	t1, t1, 0x9000		# 63-P1
+	beqz	t1, 4f
+	and	t1, v1, 0xfff8
+	xor	t1, t1, 0x9008		# 63-P2
+	beqz	t1, 4f
+	and	t1, v1, 0xfff8
+	xor	t1, t1, 0x9100		# 68-P1
+	beqz	t1, 4f
+	and	t1, v1, 0xff00
+	xor	t1, t1, 0x9200		# 66-PX
+	bnez	t1, 5f			# Skip WAR for others.
+	and	t1, v1, 0x00ff
+	slti	t1, t1, 2		# 66-P1.2 and later good.
+	beqz	t1, 5f
+
+4:	# core-16057 work around
+	or	v0, v0, 0x2000		# Set IPREF bit.
+
+5:	# No core-16057 work around
 	# Write the cavium control register
 	dmtc0	v0, CP0_CVMCTL_REG
 	sync
-- 
2.1.3
