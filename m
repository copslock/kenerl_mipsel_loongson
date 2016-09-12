Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 22:34:58 +0200 (CEST)
Received: from mail.asbjorn.biz ([185.38.24.25]:58746 "EHLO mail.asbjorn.biz"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992186AbcILUeveqw1X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Sep 2016 22:34:51 +0200
Received: from x201s.roaming.asbjorn.biz (mon1.fiberby.net [193.104.135.42])
        by mail.asbjorn.biz (Postfix) with ESMTPSA id E39371C00C67;
        Mon, 12 Sep 2016 20:34:50 +0000 (UTC)
Received: by x201s.roaming.asbjorn.biz (Postfix, from userid 1000)
        id D948C201C5C; Mon, 12 Sep 2016 20:33:43 +0000 (UTC)
From:   Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Octeon: Use defines instead of magic numbers
Date:   Mon, 12 Sep 2016 20:33:43 +0000
Message-Id: <20160912203343.26751-1-asbjorn@asbjorn.st>
X-Mailer: git-send-email 2.9.3
Return-Path: <ast@asbjorn.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asbjorn@asbjorn.st
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

The patch will be followed by a similar patch to
drivers/staging/octeon/ethernet.c

Signed-off-by: Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 15 ++++++++++-----
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h    |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index ff26d02..9b938c8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -46,6 +46,8 @@
 #include <asm/octeon/cvmx-smix-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
 
+#include <linux/if_ether.h>
+
 /**
  * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
  * priorities[16]) is a function pointer. It is meant to allow
@@ -918,7 +920,8 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 		p64 = (uint64_t *) cvmx_phys_to_ptr(pkt_buffer.s.addr);
 		p64[0] = 0xffffffffffff0000ull;
 		p64[1] = 0x08004510ull;
-		p64[2] = ((uint64_t) (size - 14) << 48) | 0x5ae740004000ull;
+		p64[2] = ((uint64_t) (size - ETH_HLEN) << 48)
+			| 0x5ae740004000ull;
 		p64[3] = 0x3a5fc0a81073c0a8ull;
 
 		for (i = 0; i < num_segs; i++) {
@@ -954,11 +957,13 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 			       1 << INDEX(FIX_IPD_OUTPORT));
 
 		cvmx_write_csr(CVMX_GMXX_RXX_JABBER
-			       (INDEX(FIX_IPD_OUTPORT),
-				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
+				(INDEX(FIX_IPD_OUTPORT),
+					INTERFACE(FIX_IPD_OUTPORT)),
+				CVMX_IPD_MAX_MTU - ETH_HLEN - ETH_FCS_LEN);
 		cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
-			       (INDEX(FIX_IPD_OUTPORT),
-				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
+				(INDEX(FIX_IPD_OUTPORT),
+					INTERFACE(FIX_IPD_OUTPORT)),
+				CVMX_IPD_MAX_MTU - ETH_HLEN - ETH_FCS_LEN);
 
 		cvmx_pko_send_packet_prepare(FIX_IPD_OUTPORT,
 					     cvmx_pko_get_base_queue
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
index 1193f73..a877917 100644
--- a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
@@ -28,6 +28,8 @@
 #ifndef __CVMX_IPD_DEFS_H__
 #define __CVMX_IPD_DEFS_H__
 
+#define CVMX_IPD_MAX_MTU 65392
+
 #define CVMX_IPD_1ST_MBUFF_SKIP (CVMX_ADD_IO_SEG(0x00014F0000000000ull))
 #define CVMX_IPD_1st_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000150ull))
 #define CVMX_IPD_2nd_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000158ull))
-- 
2.9.3
