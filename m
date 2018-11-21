Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:39:00 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58488 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994551AbeKUWiEnh4-- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:04 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 54A49200B4;
        Thu, 22 Nov 2018 00:38:04 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 21/24] MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused union fields
Date:   Thu, 22 Nov 2018 00:37:42 +0200
Message-Id: <20181121223745.22792-22-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67450
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

When register definition is identical on all OCTEONs, we can trivially
delete the model specific union fields.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h | 131 ------------------
 1 file changed, 131 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
index dc1f1dd2fd05..dc65269ff3ba 100644
--- a/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gmxx-defs.h
@@ -733,16 +733,6 @@ union cvmx_gmxx_hg2_control {
 		uint64_t reserved_19_63:45;
 #endif
 	} s;
-	struct cvmx_gmxx_hg2_control_s cn52xx;
-	struct cvmx_gmxx_hg2_control_s cn52xxp1;
-	struct cvmx_gmxx_hg2_control_s cn56xx;
-	struct cvmx_gmxx_hg2_control_s cn61xx;
-	struct cvmx_gmxx_hg2_control_s cn63xx;
-	struct cvmx_gmxx_hg2_control_s cn63xxp1;
-	struct cvmx_gmxx_hg2_control_s cn66xx;
-	struct cvmx_gmxx_hg2_control_s cn68xx;
-	struct cvmx_gmxx_hg2_control_s cn68xxp1;
-	struct cvmx_gmxx_hg2_control_s cnf71xx;
 };
 
 union cvmx_gmxx_inf_mode {
@@ -994,24 +984,6 @@ union cvmx_gmxx_rxx_adr_ctl {
 		uint64_t reserved_4_63:60;
 #endif
 	} s;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn30xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn31xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn38xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn38xxp2;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn50xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn52xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn52xxp1;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn56xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn56xxp1;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn58xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn58xxp1;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn61xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn63xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn63xxp1;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn66xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn68xx;
-	struct cvmx_gmxx_rxx_adr_ctl_s cn68xxp1;
-	struct cvmx_gmxx_rxx_adr_ctl_s cnf71xx;
 };
 
 union cvmx_gmxx_rxx_frm_ctl {
@@ -1234,12 +1206,6 @@ union cvmx_gmxx_rxx_frm_max {
 		uint64_t reserved_16_63:48;
 #endif
 	} s;
-	struct cvmx_gmxx_rxx_frm_max_s cn30xx;
-	struct cvmx_gmxx_rxx_frm_max_s cn31xx;
-	struct cvmx_gmxx_rxx_frm_max_s cn38xx;
-	struct cvmx_gmxx_rxx_frm_max_s cn38xxp2;
-	struct cvmx_gmxx_rxx_frm_max_s cn58xx;
-	struct cvmx_gmxx_rxx_frm_max_s cn58xxp1;
 };
 
 union cvmx_gmxx_rxx_frm_min {
@@ -1253,12 +1219,6 @@ union cvmx_gmxx_rxx_frm_min {
 		uint64_t reserved_16_63:48;
 #endif
 	} s;
-	struct cvmx_gmxx_rxx_frm_min_s cn30xx;
-	struct cvmx_gmxx_rxx_frm_min_s cn31xx;
-	struct cvmx_gmxx_rxx_frm_min_s cn38xx;
-	struct cvmx_gmxx_rxx_frm_min_s cn38xxp2;
-	struct cvmx_gmxx_rxx_frm_min_s cn58xx;
-	struct cvmx_gmxx_rxx_frm_min_s cn58xxp1;
 };
 
 union cvmx_gmxx_rxx_int_en {
@@ -2058,24 +2018,6 @@ union cvmx_gmxx_rxx_jabber {
 		uint64_t reserved_16_63:48;
 #endif
 	} s;
-	struct cvmx_gmxx_rxx_jabber_s cn30xx;
-	struct cvmx_gmxx_rxx_jabber_s cn31xx;
-	struct cvmx_gmxx_rxx_jabber_s cn38xx;
-	struct cvmx_gmxx_rxx_jabber_s cn38xxp2;
-	struct cvmx_gmxx_rxx_jabber_s cn50xx;
-	struct cvmx_gmxx_rxx_jabber_s cn52xx;
-	struct cvmx_gmxx_rxx_jabber_s cn52xxp1;
-	struct cvmx_gmxx_rxx_jabber_s cn56xx;
-	struct cvmx_gmxx_rxx_jabber_s cn56xxp1;
-	struct cvmx_gmxx_rxx_jabber_s cn58xx;
-	struct cvmx_gmxx_rxx_jabber_s cn58xxp1;
-	struct cvmx_gmxx_rxx_jabber_s cn61xx;
-	struct cvmx_gmxx_rxx_jabber_s cn63xx;
-	struct cvmx_gmxx_rxx_jabber_s cn63xxp1;
-	struct cvmx_gmxx_rxx_jabber_s cn66xx;
-	struct cvmx_gmxx_rxx_jabber_s cn68xx;
-	struct cvmx_gmxx_rxx_jabber_s cn68xxp1;
-	struct cvmx_gmxx_rxx_jabber_s cnf71xx;
 };
 
 union cvmx_gmxx_rxx_rx_inbnd {
@@ -2093,13 +2035,6 @@ union cvmx_gmxx_rxx_rx_inbnd {
 		uint64_t reserved_4_63:60;
 #endif
 	} s;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn30xx;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn31xx;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn38xx;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn38xxp2;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn50xx;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn58xx;
-	struct cvmx_gmxx_rxx_rx_inbnd_s cn58xxp1;
 };
 
 union cvmx_gmxx_rx_prts {
@@ -2113,24 +2048,6 @@ union cvmx_gmxx_rx_prts {
 		uint64_t reserved_3_63:61;
 #endif
 	} s;
-	struct cvmx_gmxx_rx_prts_s cn30xx;
-	struct cvmx_gmxx_rx_prts_s cn31xx;
-	struct cvmx_gmxx_rx_prts_s cn38xx;
-	struct cvmx_gmxx_rx_prts_s cn38xxp2;
-	struct cvmx_gmxx_rx_prts_s cn50xx;
-	struct cvmx_gmxx_rx_prts_s cn52xx;
-	struct cvmx_gmxx_rx_prts_s cn52xxp1;
-	struct cvmx_gmxx_rx_prts_s cn56xx;
-	struct cvmx_gmxx_rx_prts_s cn56xxp1;
-	struct cvmx_gmxx_rx_prts_s cn58xx;
-	struct cvmx_gmxx_rx_prts_s cn58xxp1;
-	struct cvmx_gmxx_rx_prts_s cn61xx;
-	struct cvmx_gmxx_rx_prts_s cn63xx;
-	struct cvmx_gmxx_rx_prts_s cn63xxp1;
-	struct cvmx_gmxx_rx_prts_s cn66xx;
-	struct cvmx_gmxx_rx_prts_s cn68xx;
-	struct cvmx_gmxx_rx_prts_s cn68xxp1;
-	struct cvmx_gmxx_rx_prts_s cnf71xx;
 };
 
 union cvmx_gmxx_rx_xaui_ctl {
@@ -2144,17 +2061,6 @@ union cvmx_gmxx_rx_xaui_ctl {
 		uint64_t reserved_2_63:62;
 #endif
 	} s;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn52xx;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn52xxp1;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn56xx;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn56xxp1;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn61xx;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn63xx;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn63xxp1;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn66xx;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn68xx;
-	struct cvmx_gmxx_rx_xaui_ctl_s cn68xxp1;
-	struct cvmx_gmxx_rx_xaui_ctl_s cnf71xx;
 };
 
 union cvmx_gmxx_txx_thresh {
@@ -2756,24 +2662,6 @@ union cvmx_gmxx_tx_prts {
 		uint64_t reserved_5_63:59;
 #endif
 	} s;
-	struct cvmx_gmxx_tx_prts_s cn30xx;
-	struct cvmx_gmxx_tx_prts_s cn31xx;
-	struct cvmx_gmxx_tx_prts_s cn38xx;
-	struct cvmx_gmxx_tx_prts_s cn38xxp2;
-	struct cvmx_gmxx_tx_prts_s cn50xx;
-	struct cvmx_gmxx_tx_prts_s cn52xx;
-	struct cvmx_gmxx_tx_prts_s cn52xxp1;
-	struct cvmx_gmxx_tx_prts_s cn56xx;
-	struct cvmx_gmxx_tx_prts_s cn56xxp1;
-	struct cvmx_gmxx_tx_prts_s cn58xx;
-	struct cvmx_gmxx_tx_prts_s cn58xxp1;
-	struct cvmx_gmxx_tx_prts_s cn61xx;
-	struct cvmx_gmxx_tx_prts_s cn63xx;
-	struct cvmx_gmxx_tx_prts_s cn63xxp1;
-	struct cvmx_gmxx_tx_prts_s cn66xx;
-	struct cvmx_gmxx_tx_prts_s cn68xx;
-	struct cvmx_gmxx_tx_prts_s cn68xxp1;
-	struct cvmx_gmxx_tx_prts_s cnf71xx;
 };
 
 union cvmx_gmxx_tx_spi_ctl {
@@ -2789,10 +2677,6 @@ union cvmx_gmxx_tx_spi_ctl {
 		uint64_t reserved_2_63:62;
 #endif
 	} s;
-	struct cvmx_gmxx_tx_spi_ctl_s cn38xx;
-	struct cvmx_gmxx_tx_spi_ctl_s cn38xxp2;
-	struct cvmx_gmxx_tx_spi_ctl_s cn58xx;
-	struct cvmx_gmxx_tx_spi_ctl_s cn58xxp1;
 };
 
 union cvmx_gmxx_tx_spi_max {
@@ -2837,10 +2721,6 @@ union cvmx_gmxx_tx_spi_thresh {
 		uint64_t reserved_6_63:58;
 #endif
 	} s;
-	struct cvmx_gmxx_tx_spi_thresh_s cn38xx;
-	struct cvmx_gmxx_tx_spi_thresh_s cn38xxp2;
-	struct cvmx_gmxx_tx_spi_thresh_s cn58xx;
-	struct cvmx_gmxx_tx_spi_thresh_s cn58xxp1;
 };
 
 union cvmx_gmxx_tx_xaui_ctl {
@@ -2868,17 +2748,6 @@ union cvmx_gmxx_tx_xaui_ctl {
 		uint64_t reserved_11_63:53;
 #endif
 	} s;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn52xx;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn52xxp1;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn56xx;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn56xxp1;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn61xx;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn63xx;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn63xxp1;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn66xx;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn68xx;
-	struct cvmx_gmxx_tx_xaui_ctl_s cn68xxp1;
-	struct cvmx_gmxx_tx_xaui_ctl_s cnf71xx;
 };
 
 #endif
-- 
2.17.0
