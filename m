Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:54 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58432 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994544AbeKUWiEWA0F- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:04 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id E32F1200A5;
        Thu, 22 Nov 2018 00:38:03 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 19/24] MIPS: OCTEON: gmxx-defs.h: delete unused functions and macros
Date:   Thu, 22 Nov 2018 00:37:40 +0200
Message-Id: <20181121223745.22792-20-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67449
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

Delete unused functions and macros.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h | 1558 ++---------------
 1 file changed, 101 insertions(+), 1457 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
index 1c1eb7e4489b..af5b6967da11 100644
--- a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
@@ -28,71 +28,6 @@
 #ifndef __CVMX_GMXX_DEFS_H__
 #define __CVMX_GMXX_DEFS_H__
 
-static inline uint64_t CVMX_GMXX_BAD_REG(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000518ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000518ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000518ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000518ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_BIST(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000400ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000400ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000400ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000400ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_BPID_MAPX(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000680ull) + (((offset) & 15) + ((block_id) & 7) * 0x200000ull) * 8)
-#define CVMX_GMXX_BPID_MSK(block_id) (CVMX_ADD_IO_SEG(0x0001180008000700ull) + ((block_id) & 7) * 0x1000000ull)
-static inline uint64_t CVMX_GMXX_CLK_EN(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007F0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007F0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007F0ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080007F0ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_EBP_DIS(block_id) (CVMX_ADD_IO_SEG(0x0001180008000608ull) + ((block_id) & 7) * 0x1000000ull)
-#define CVMX_GMXX_EBP_MSK(block_id) (CVMX_ADD_IO_SEG(0x0001180008000600ull) + ((block_id) & 7) * 0x1000000ull)
 static inline uint64_t CVMX_GMXX_HG2_CONTROL(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -132,46 +67,6 @@ static inline uint64_t CVMX_GMXX_INF_MODE(unsigned long block_id)
 	return CVMX_ADD_IO_SEG(0x00011800080007F8ull) + (block_id) * 0x8000000ull;
 }
 
-static inline uint64_t CVMX_GMXX_NXA_ADR(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000510ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000510ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000510ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000510ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_PIPE_STATUS(block_id) (CVMX_ADD_IO_SEG(0x0001180008000760ull) + ((block_id) & 7) * 0x1000000ull)
-static inline uint64_t CVMX_GMXX_PRTX_CBFC_CTL(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000580ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000580ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000580ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000580ull) + (block_id) * 0x8000000ull;
-}
-
 static inline uint64_t CVMX_GMXX_PRTX_CFG(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -197,7 +92,6 @@ static inline uint64_t CVMX_GMXX_PRTX_CFG(unsigned long offset, unsigned long bl
 	return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-#define CVMX_GMXX_RXAUI_CTL(block_id) (CVMX_ADD_IO_SEG(0x0001180008000740ull) + ((block_id) & 7) * 0x1000000ull)
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM0(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -342,20 +236,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM5(unsigned long offset, unsigned lon
 	return CVMX_ADD_IO_SEG(0x00011800080001A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_ADR_CAM_ALL_EN(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000110ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000110ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000110ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000110ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM_EN(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -406,56 +286,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CTL(unsigned long offset, unsigned long
 	return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_DECISION(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000040ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_RXX_FRM_CHK(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000020ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
 static inline uint64_t CVMX_GMXX_RXX_FRM_CTL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -483,30 +313,6 @@ static inline uint64_t CVMX_GMXX_RXX_FRM_CTL(unsigned long offset, unsigned long
 
 #define CVMX_GMXX_RXX_FRM_MAX(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000030ull) + (((offset) & 3) + ((block_id) & 1) * 0x10000ull) * 2048)
 #define CVMX_GMXX_RXX_FRM_MIN(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000028ull) + (((offset) & 3) + ((block_id) & 1) * 0x10000ull) * 2048)
-static inline uint64_t CVMX_GMXX_RXX_IFG(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000058ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
 
 static inline uint64_t CVMX_GMXX_RXX_INT_EN(unsigned long offset, unsigned long block_id)
 {
@@ -583,1432 +389,289 @@ static inline uint64_t CVMX_GMXX_RXX_JABBER(unsigned long offset, unsigned long
 	return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_PAUSE_DROP_TIME(unsigned long offset, unsigned long block_id)
+#define CVMX_GMXX_RXX_RX_INBND(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000060ull) + (((offset) & 3) + ((block_id) & 1) * 0x10000ull) * 2048)
+
+static inline uint64_t CVMX_GMXX_RX_PRTS(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
+	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x1000000ull;
 	}
-	return CVMX_ADD_IO_SEG(0x0001180008000068ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x8000000ull;
 }
 
-#define CVMX_GMXX_RXX_RX_INBND(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000060ull) + (((offset) & 3) + ((block_id) & 1) * 0x10000ull) * 2048)
-static inline uint64_t CVMX_GMXX_RXX_STATS_CTL(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_RX_XAUI_CTL(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x1000000ull;
 	}
-	return CVMX_ADD_IO_SEG(0x0001180008000050ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_SMACX(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x0001180008000088ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS_CTL(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TXX_BURST(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x0001180008000098ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS_DMAC(unsigned long offset, unsigned long block_id)
+#define CVMX_GMXX_TXX_CLK(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000208ull) + (((offset) & 3) + ((block_id) & 1) * 0x10000ull) * 2048)
+static inline uint64_t CVMX_GMXX_TXX_CTL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x00011800080000A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_OCTS_DRP(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x00011800080000B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_TIME(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x0001180008000080ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_BAD(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TXX_SLOT(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x00011800080000C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_CTL(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TXX_THRESH(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
 	}
-	return CVMX_ADD_IO_SEG(0x0001180008000090ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_DMAC(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TX_INT_EN(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x1000000ull;
 	}
-	return CVMX_ADD_IO_SEG(0x00011800080000A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x8000000ull;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_STATS_PKTS_DRP(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TX_INT_REG(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
+		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x1000000ull;
 	}
-	return CVMX_ADD_IO_SEG(0x00011800080000B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x8000000ull;
 }
 
-static inline uint64_t CVMX_GMXX_RXX_UDD_SKP(unsigned long offset, unsigned long block_id)
+static inline uint64_t CVMX_GMXX_TX_OVR_BP(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
+	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x0ull) * 2048;
+	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000048ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_RX_BP_DROPX(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x0ull) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x200000ull) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000420ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-}
-
-static inline uint64_t CVMX_GMXX_RX_BP_OFFX(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x0ull) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x200000ull) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000460ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-}
-
-static inline uint64_t CVMX_GMXX_RX_BP_ONX(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x0ull) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x200000ull) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000440ull) + ((offset) + (block_id) * 0x1000000ull) * 8;
-}
-
-static inline uint64_t CVMX_GMXX_RX_HG2_STATUS(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000548ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000548ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000548ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000548ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_RX_PASS_EN(block_id) (CVMX_ADD_IO_SEG(0x00011800080005F8ull) + ((block_id) & 1) * 0x8000000ull)
-#define CVMX_GMXX_RX_PASS_MAPX(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000600ull) + (((offset) & 15) + ((block_id) & 1) * 0x1000000ull) * 8)
-static inline uint64_t CVMX_GMXX_RX_PRTS(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_RX_PRT_INFO(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004E8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004E8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004E8ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080004E8ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_RX_TX_STATUS(block_id) (CVMX_ADD_IO_SEG(0x00011800080007E8ull))
-static inline uint64_t CVMX_GMXX_RX_XAUI_BAD_COL(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000538ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000538ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000538ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000538ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_RX_XAUI_CTL(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_SMACX(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_SOFT_BIST(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007E8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007E8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007E8ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080007E8ull) + (block_id) * 0x1000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_STAT_BP(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000520ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000520ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000520ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000520ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TB_REG(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007E0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007E0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007E0ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080007E0ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_APPEND(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000218ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_BURST(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_CBFC_XOFF(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080005A0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080005A0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080005A0ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080005A0ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_CBFC_XON(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080005C0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080005C0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080005C0ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080005C0ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_TXX_CLK(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000208ull) + (((offset) & 3) + ((block_id) & 1) * 0x10000ull) * 2048)
-static inline uint64_t CVMX_GMXX_TXX_CTL(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_MIN_PKT(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000240ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_TIME(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_PAUSE_TOGO(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000258ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_PAUSE_ZERO(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000260ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-#define CVMX_GMXX_TXX_PIPE(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000310ull) + (((offset) & 3) + ((block_id) & 7) * 0x2000ull) * 2048)
-static inline uint64_t CVMX_GMXX_TXX_SGMII_CTL(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000300ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000300ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000300ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000300ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000300ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_SLOT(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_SOFT_PAUSE(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000250ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT0(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000280ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT1(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000288ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT2(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000290ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT3(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000298ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT4(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080002A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT5(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080002A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT6(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080002B0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT7(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080002B8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT8(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080002C0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STAT9(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080002C8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_STATS_CTL(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000268ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TXX_THRESH(unsigned long offset, unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x0ull) * 2048;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x2000ull) * 2048;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-}
-
-static inline uint64_t CVMX_GMXX_TX_BP(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004D0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004D0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004D0ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080004D0ull) + (block_id) * 0x8000000ull;
-}
-
-#define CVMX_GMXX_TX_CLK_MSKX(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000780ull) + (((offset) & 1) + ((block_id) & 0) * 0x0ull) * 8)
-static inline uint64_t CVMX_GMXX_TX_COL_ATTEMPT(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000498ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000498ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000498ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000498ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_CORRUPT(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004D8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004D8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004D8ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080004D8ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_HG2_REG1(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000558ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000558ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000558ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000558ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_HG2_REG2(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000560ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000560ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000560ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000560ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_IFG(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000488ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000488ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000488ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000488ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_INT_EN(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_INT_REG(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_JAM(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000490ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000490ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000490ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000490ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_LFSR(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004F8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004F8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004F8ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080004F8ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_OVR_BP(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x1000000ull;
+		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x1000000ull;
 	}
 	return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x8000000ull;
 }
 
-static inline uint64_t CVMX_GMXX_TX_PAUSE_PKT_DMAC(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004A0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004A0ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004A0ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080004A0ull) + (block_id) * 0x8000000ull;
-}
-
-static inline uint64_t CVMX_GMXX_TX_PAUSE_PKT_TYPE(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004A8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004A8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080004A8ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x00011800080004A8ull) + (block_id) * 0x8000000ull;
-}
-
 static inline uint64_t CVMX_GMXX_TX_PRTS(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
@@ -2032,9 +695,7 @@ static inline uint64_t CVMX_GMXX_TX_PRTS(unsigned long block_id)
 }
 
 #define CVMX_GMXX_TX_SPI_CTL(block_id) (CVMX_ADD_IO_SEG(0x00011800080004C0ull) + ((block_id) & 1) * 0x8000000ull)
-#define CVMX_GMXX_TX_SPI_DRAIN(block_id) (CVMX_ADD_IO_SEG(0x00011800080004E0ull) + ((block_id) & 1) * 0x8000000ull)
 #define CVMX_GMXX_TX_SPI_MAX(block_id) (CVMX_ADD_IO_SEG(0x00011800080004B0ull) + ((block_id) & 1) * 0x8000000ull)
-#define CVMX_GMXX_TX_SPI_ROUNDX(offset, block_id) (CVMX_ADD_IO_SEG(0x0001180008000680ull) + (((offset) & 31) + ((block_id) & 1) * 0x1000000ull) * 8)
 #define CVMX_GMXX_TX_SPI_THRESH(block_id) (CVMX_ADD_IO_SEG(0x00011800080004B8ull) + ((block_id) & 1) * 0x8000000ull)
 static inline uint64_t CVMX_GMXX_TX_XAUI_CTL(unsigned long block_id)
 {
@@ -2053,23 +714,6 @@ static inline uint64_t CVMX_GMXX_TX_XAUI_CTL(unsigned long block_id)
 	return CVMX_ADD_IO_SEG(0x0001180008000528ull) + (block_id) * 0x8000000ull;
 }
 
-static inline uint64_t CVMX_GMXX_XAUI_EXT_LOOPBACK(unsigned long block_id)
-{
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000540ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000540ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000540ull) + (block_id) * 0x1000000ull;
-	}
-	return CVMX_ADD_IO_SEG(0x0001180008000540ull) + (block_id) * 0x8000000ull;
-}
-
 void __cvmx_interrupt_gmxx_enable(int interface);
 
 union cvmx_gmxx_bad_reg {
-- 
2.17.0
