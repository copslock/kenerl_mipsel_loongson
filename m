Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 23:23:23 +0100 (CET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52538 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007648AbcBVWXGzgmhK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 23:23:06 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 6620F3FE6;
        Tue, 23 Feb 2016 00:23:05 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] MIPS: OCTEON: board_type_to_string: return NULL for unsupported board
Date:   Tue, 23 Feb 2016 00:22:55 +0200
Message-Id: <1456179777-6247-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52164
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

Return NULL for unsupported board.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/setup.c              | 9 +++++++--
 arch/mips/include/asm/octeon/cvmx-bootinfo.h | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index cd7101f..5be2072 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -468,9 +468,14 @@ static char __read_mostly octeon_system_type[80];
 
 static int __init init_octeon_system_type(void)
 {
+	char const *board_type;
+
+	board_type = cvmx_board_type_to_string(octeon_bootinfo->board_type);
+	if (board_type == NULL)
+		board_type = "Unsupported Board";
+
 	snprintf(octeon_system_type, sizeof(octeon_system_type), "%s (%s)",
-		cvmx_board_type_to_string(octeon_bootinfo->board_type),
-		octeon_model_get_string(read_c0_prid()));
+		 board_type, octeon_model_get_string(read_c0_prid()));
 
 	return 0;
 }
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index d92cf59..a00f903 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -388,7 +388,7 @@ static inline const char *cvmx_board_type_to_string(enum
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
 	}
-	return "Unsupported Board";
+	return NULL;
 }
 
 #define ENUM_CHIP_TYPE_CASE(x) \
-- 
2.4.0
