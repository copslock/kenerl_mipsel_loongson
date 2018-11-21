Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:39:09 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58432 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994552AbeKUWiEs9Nl- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:04 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 7A81E200A4;
        Thu, 22 Nov 2018 00:38:04 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 22/24] MIPS: OCTEON: cvmx-gmxx-defs.h: use default register value return when possible
Date:   Thu, 22 Nov 2018 00:37:43 +0200
Message-Id: <20181121223745.22792-23-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67451
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

If we are about to return the same register address that would
be the default anyway, fallback to default return instead of adding
a case label.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h | 376 ------------------
 1 file changed, 376 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
index dc65269ff3ba..00d0dbc75ea4 100644
--- a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
@@ -31,14 +31,6 @@
 static inline uint64_t CVMX_GMXX_HG2_CONTROL(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000550ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000550ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000550ull) + (block_id) * 0x1000000ull;
 	}
@@ -48,19 +40,6 @@ static inline uint64_t CVMX_GMXX_HG2_CONTROL(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_INF_MODE(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007F8ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080007F8ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x00011800080007F8ull) + (block_id) * 0x1000000ull;
 	}
@@ -70,20 +49,6 @@ static inline uint64_t CVMX_GMXX_INF_MODE(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_PRTX_CFG(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000010ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -95,19 +60,6 @@ static inline uint64_t CVMX_GMXX_PRTX_CFG(unsigned long offset, unsigned long bl
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM0(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000180ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000180ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000180ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000180ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -119,19 +71,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM0(unsigned long offset, unsigned lon
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM1(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000188ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000188ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000188ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000188ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -143,19 +82,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM1(unsigned long offset, unsigned lon
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM2(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000190ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000190ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000190ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000190ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -167,19 +93,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM2(unsigned long offset, unsigned lon
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM3(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000198ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000198ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000198ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000198ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -191,19 +104,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM3(unsigned long offset, unsigned lon
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM4(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080001A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080001A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080001A0ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x00011800080001A0ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -215,19 +115,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM4(unsigned long offset, unsigned lon
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM5(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080001A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080001A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x00011800080001A8ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x00011800080001A8ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -239,20 +126,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM5(unsigned long offset, unsigned lon
 static inline uint64_t CVMX_GMXX_RXX_ADR_CAM_EN(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000108ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000108ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000108ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000108ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000108ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -264,20 +137,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CAM_EN(unsigned long offset, unsigned l
 static inline uint64_t CVMX_GMXX_RXX_ADR_CTL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000100ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -289,20 +148,6 @@ static inline uint64_t CVMX_GMXX_RXX_ADR_CTL(unsigned long offset, unsigned long
 static inline uint64_t CVMX_GMXX_RXX_FRM_CTL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000018ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000018ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000018ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000018ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000018ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -317,20 +162,6 @@ static inline uint64_t CVMX_GMXX_RXX_FRM_CTL(unsigned long offset, unsigned long
 static inline uint64_t CVMX_GMXX_RXX_INT_EN(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000008ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000008ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000008ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000008ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000008ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -342,20 +173,6 @@ static inline uint64_t CVMX_GMXX_RXX_INT_EN(unsigned long offset, unsigned long
 static inline uint64_t CVMX_GMXX_RXX_INT_REG(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000000ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000000ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000000ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000000ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000000ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -367,20 +184,6 @@ static inline uint64_t CVMX_GMXX_RXX_INT_REG(unsigned long offset, unsigned long
 static inline uint64_t CVMX_GMXX_RXX_JABBER(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset) + (block_id) * 0x10000ull) * 2048;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000038ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -394,19 +197,6 @@ static inline uint64_t CVMX_GMXX_RXX_JABBER(unsigned long offset, unsigned long
 static inline uint64_t CVMX_GMXX_RX_PRTS(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000410ull) + (block_id) * 0x1000000ull;
 	}
@@ -416,14 +206,6 @@ static inline uint64_t CVMX_GMXX_RX_PRTS(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_RX_XAUI_CTL(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000530ull) + (block_id) * 0x1000000ull;
 	}
@@ -433,20 +215,6 @@ static inline uint64_t CVMX_GMXX_RX_XAUI_CTL(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_SMACX(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000230ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -458,20 +226,6 @@ static inline uint64_t CVMX_GMXX_SMACX(unsigned long offset, unsigned long block
 static inline uint64_t CVMX_GMXX_TXX_BURST(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000228ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -484,20 +238,6 @@ static inline uint64_t CVMX_GMXX_TXX_BURST(unsigned long offset, unsigned long b
 static inline uint64_t CVMX_GMXX_TXX_CTL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000270ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -509,20 +249,6 @@ static inline uint64_t CVMX_GMXX_TXX_CTL(unsigned long offset, unsigned long blo
 static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000248ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -534,20 +260,6 @@ static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_INTERVAL(unsigned long offset, un
 static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_TIME(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000238ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -559,20 +271,6 @@ static inline uint64_t CVMX_GMXX_TXX_PAUSE_PKT_TIME(unsigned long offset, unsign
 static inline uint64_t CVMX_GMXX_TXX_SLOT(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000220ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -584,20 +282,6 @@ static inline uint64_t CVMX_GMXX_TXX_SLOT(unsigned long offset, unsigned long bl
 static inline uint64_t CVMX_GMXX_TXX_THRESH(unsigned long offset, unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000210ull) + ((offset) + (block_id) * 0x0ull) * 2048;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
@@ -609,19 +293,6 @@ static inline uint64_t CVMX_GMXX_TXX_THRESH(unsigned long offset, unsigned long
 static inline uint64_t CVMX_GMXX_TX_INT_EN(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000508ull) + (block_id) * 0x1000000ull;
 	}
@@ -631,19 +302,6 @@ static inline uint64_t CVMX_GMXX_TX_INT_EN(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_TX_INT_REG(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000500ull) + (block_id) * 0x1000000ull;
 	}
@@ -653,19 +311,6 @@ static inline uint64_t CVMX_GMXX_TX_INT_REG(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_TX_OVR_BP(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
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
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x00011800080004C8ull) + (block_id) * 0x1000000ull;
 	}
@@ -675,19 +320,6 @@ static inline uint64_t CVMX_GMXX_TX_OVR_BP(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_TX_PRTS(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000480ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000480ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000480ull) + (block_id) * 0x1000000ull;
 	}
@@ -700,14 +332,6 @@ static inline uint64_t CVMX_GMXX_TX_PRTS(unsigned long block_id)
 static inline uint64_t CVMX_GMXX_TX_XAUI_CTL(unsigned long block_id)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000528ull) + (block_id) * 0x8000000ull;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001180008000528ull) + (block_id) * 0x8000000ull;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001180008000528ull) + (block_id) * 0x1000000ull;
 	}
-- 
2.17.0
