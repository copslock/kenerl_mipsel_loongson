Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:39:15 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58424 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeKUWiE7c0e- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:04 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id A4439200BC;
        Thu, 22 Nov 2018 00:38:04 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 23/24] MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused macros
Date:   Thu, 22 Nov 2018 00:37:44 +0200
Message-Id: <20181121223745.22792-24-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Delete unused macros.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/octeon/cvmx-ciu2-defs.h | 177 ------------------
 1 file changed, 177 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu2-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu2-defs.h
index 148bc9a0085d..9cce35cddaf6 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu2-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu2-defs.h
@@ -28,199 +28,22 @@
 #ifndef __CVMX_CIU2_DEFS_H__
 #define __CVMX_CIU2_DEFS_H__
 
-#define CVMX_CIU2_ACK_IOX_INT(block_id) (CVMX_ADD_IO_SEG(0x00010701080C0800ull) + ((block_id) & 1) * 0x200000ull)
 #define CVMX_CIU2_ACK_PPX_IP2(block_id) (CVMX_ADD_IO_SEG(0x00010701000C0000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_ACK_PPX_IP3(block_id) (CVMX_ADD_IO_SEG(0x00010701000C0200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_ACK_PPX_IP4(block_id) (CVMX_ADD_IO_SEG(0x00010701000C0400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070108097800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_GPIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B7800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_GPIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A7800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070108094800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_IO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B4800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_IO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A4800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070108098800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MBOX_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B8800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MBOX_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A8800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070108095800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MEM_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B5800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MEM_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A5800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070108093800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B3800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_MIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A3800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070108096800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_PKT_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B6800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_PKT_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A6800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070108092800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_RML_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B2800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_RML_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A2800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070108091800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_WDOG_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B1800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_WDOG_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A1800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070108090800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_WRKQ_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701080B0800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_IOX_INT_WRKQ_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701080A0800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100097000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_GPIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B7000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_GPIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A7000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100094000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_IO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B4000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_IO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A4000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070100098000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MBOX_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B8000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MBOX_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A8000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100095000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MEM_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B5000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MEM_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A5000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100093000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B3000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_MIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A3000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100096000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_PKT_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B6000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_PKT_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A6000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP2_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100092000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_RML_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B2000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_RML_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A2000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP2_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100091000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_WDOG_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B1000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP2_WDOG_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A1000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP2_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100090000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP2_WRKQ_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B0000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP2_WRKQ_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A0000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100097200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_GPIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B7200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_GPIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A7200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100094200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_IO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B4200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_IO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A4200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070100098200ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP3_MBOX_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B8200ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_EN_PPX_IP3_MBOX_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A8200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100095200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MEM_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B5200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MEM_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A5200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100093200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B3200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_MIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A3200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100096200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_PKT_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B6200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_PKT_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A6200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100092200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_RML_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B2200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_RML_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A2200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100091200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_WDOG_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B1200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_WDOG_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A1200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100090200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_WRKQ_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B0200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP3_WRKQ_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A0200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100097400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_GPIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B7400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_GPIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A7400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100094400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_IO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B4400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_IO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A4400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070100098400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MBOX_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B8400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MBOX_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A8400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100095400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MEM_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B5400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MEM_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A5400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100093400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MIO_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B3400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_MIO_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A3400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100096400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_PKT_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B6400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_PKT_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A6400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100092400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_RML_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B2400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_RML_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A2400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100091400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_WDOG_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B1400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_WDOG_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A1400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100090400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_WRKQ_W1C(block_id) (CVMX_ADD_IO_SEG(0x00010701000B0400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_EN_PPX_IP4_WRKQ_W1S(block_id) (CVMX_ADD_IO_SEG(0x00010701000A0400ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_INTR_CIU_READY (CVMX_ADD_IO_SEG(0x0001070100102008ull))
-#define CVMX_CIU2_INTR_RAM_ECC_CTL (CVMX_ADD_IO_SEG(0x0001070100102010ull))
-#define CVMX_CIU2_INTR_RAM_ECC_ST (CVMX_ADD_IO_SEG(0x0001070100102018ull))
-#define CVMX_CIU2_INTR_SLOWDOWN (CVMX_ADD_IO_SEG(0x0001070100102000ull))
-#define CVMX_CIU2_MSIRED_PPX_IP2(block_id) (CVMX_ADD_IO_SEG(0x00010701000C1000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_MSIRED_PPX_IP3(block_id) (CVMX_ADD_IO_SEG(0x00010701000C1200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_MSIRED_PPX_IP4(block_id) (CVMX_ADD_IO_SEG(0x00010701000C1400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_MSI_RCVX(offset) (CVMX_ADD_IO_SEG(0x00010701000C2000ull) + ((offset) & 255) * 8)
-#define CVMX_CIU2_MSI_SELX(offset) (CVMX_ADD_IO_SEG(0x00010701000C3000ull) + ((offset) & 255) * 8)
-#define CVMX_CIU2_RAW_IOX_INT_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070108047800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070108044800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070108045800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070108043800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070108046800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070108042800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070108041800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_IOX_INT_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070108040800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100047000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100044000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100045000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100043000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100046000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100042000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP2_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100041000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_RAW_PPX_IP2_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100040000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100047200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100044200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100045200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100043200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100046200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100042200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100041200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP3_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100040200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100047400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100044400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100045400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100043400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100046400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100042400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100041400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_RAW_PPX_IP4_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100040400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070108087800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070108084800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070108088800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070108085800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070108083800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070108086800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070108082800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070108081800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_IOX_INT_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070108080800ull) + ((block_id) & 1) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP2_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100087000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP2_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100084000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP2_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070100088000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP2_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100085000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP2_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100083000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP2_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100086000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_SRC_PPX_IP2_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100082000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_SRC_PPX_IP2_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100081000ull) + ((block_id) & 31) * 0x200000ull)
 #define CVMX_CIU2_SRC_PPX_IP2_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100080000ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100087200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100084200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070100088200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100085200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100083200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100086200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100082200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100081200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP3_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100080200ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_GPIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100087400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_IO(block_id) (CVMX_ADD_IO_SEG(0x0001070100084400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_MBOX(block_id) (CVMX_ADD_IO_SEG(0x0001070100088400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_MEM(block_id) (CVMX_ADD_IO_SEG(0x0001070100085400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_MIO(block_id) (CVMX_ADD_IO_SEG(0x0001070100083400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_PKT(block_id) (CVMX_ADD_IO_SEG(0x0001070100086400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_RML(block_id) (CVMX_ADD_IO_SEG(0x0001070100082400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_WDOG(block_id) (CVMX_ADD_IO_SEG(0x0001070100081400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SRC_PPX_IP4_WRKQ(block_id) (CVMX_ADD_IO_SEG(0x0001070100080400ull) + ((block_id) & 31) * 0x200000ull)
-#define CVMX_CIU2_SUM_IOX_INT(offset) (CVMX_ADD_IO_SEG(0x0001070100000800ull) + ((offset) & 1) * 8)
 #define CVMX_CIU2_SUM_PPX_IP2(offset) (CVMX_ADD_IO_SEG(0x0001070100000000ull) + ((offset) & 31) * 8)
 #define CVMX_CIU2_SUM_PPX_IP3(offset) (CVMX_ADD_IO_SEG(0x0001070100000200ull) + ((offset) & 31) * 8)
-#define CVMX_CIU2_SUM_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x0001070100000400ull) + ((offset) & 31) * 8)
 
 union cvmx_ciu2_ack_iox_int {
 	uint64_t u64;
-- 
2.17.0
