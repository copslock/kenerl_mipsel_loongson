Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:43 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58432 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeKUWiDNqqe- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:03 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 035DB20097;
        Thu, 22 Nov 2018 00:38:02 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 13/24] MIPS: OCTEON: cvmx-helper-util: make cvmx_helper_setup_red_queue static
Date:   Thu, 22 Nov 2018 00:37:34 +0200
Message-Id: <20181121223745.22792-14-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67445
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

Make cvmx_helper_setup_red_queue static, it's not used outside this file.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper-util.c    |  3 ++-
 arch/mips/include/asm/octeon/cvmx-helper-util.h   | 15 ---------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
index 5e353a91138e..53b912745dbd 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-util.c
@@ -92,7 +92,8 @@ const char *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t
  *		 than this many free packet buffers in FPA 0.
  * Returns Zero on success. Negative on failure
  */
-int cvmx_helper_setup_red_queue(int queue, int pass_thresh, int drop_thresh)
+static int cvmx_helper_setup_red_queue(int queue, int pass_thresh,
+				       int drop_thresh)
 {
 	union cvmx_ipd_qosx_red_marks red_marks;
 	union cvmx_ipd_red_quex_param red_param;
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-util.h b/arch/mips/include/asm/octeon/cvmx-helper-util.h
index d88e3abb16c1..e9a97e7ee604 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-util.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-util.h
@@ -44,21 +44,6 @@
 extern const char
     *cvmx_helper_interface_mode_to_string(cvmx_helper_interface_mode_t mode);
 
-/**
- * Setup Random Early Drop on a specific input queue
- *
- * @queue:  Input queue to setup RED on (0-7)
- * @pass_thresh:
- *		 Packets will begin slowly dropping when there are less than
- *		 this many packet buffers free in FPA 0.
- * @drop_thresh:
- *		 All incoming packets will be dropped when there are less
- *		 than this many free packet buffers in FPA 0.
- * Returns Zero on success. Negative on failure
- */
-extern int cvmx_helper_setup_red_queue(int queue, int pass_thresh,
-				       int drop_thresh);
-
 /**
  * Setup Random Early Drop to automatically begin dropping packets.
  *
-- 
2.17.0
