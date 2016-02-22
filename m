Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 23:23:40 +0100 (CET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52545 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012087AbcBVWXGzgmhK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 23:23:06 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id C35B84042;
        Tue, 23 Feb 2016 00:23:05 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] MIPS: OCTEON: use model string from DTB for unknown board type
Date:   Tue, 23 Feb 2016 00:22:57 +0200
Message-Id: <1456179777-6247-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52165
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

Use model string from DTB for board type if the board is unknown.
This is more informative, e.g. with EdgeRouter Pro the /proc/cpuinfo
will display "ubnt,e200 (CN6120p1.1-1000-NSP)" instead of misleading
"Unsupported Board".

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/setup.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index d9fb610..2338890 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -471,8 +471,16 @@ static void __init init_octeon_system_type(void)
 	char const *board_type;
 
 	board_type = cvmx_board_type_to_string(octeon_bootinfo->board_type);
-	if (board_type == NULL)
-		board_type = "Unsupported Board";
+	if (board_type == NULL) {
+		struct device_node *root;
+		int ret;
+
+		root = of_find_node_by_path("/");
+		ret = of_property_read_string(root, "model", &board_type);
+		of_node_put(root);
+		if (ret)
+			board_type = "Unsupported Board";
+	}
 
 	snprintf(octeon_system_type, sizeof(octeon_system_type), "%s (%s)",
 		 board_type, octeon_model_get_string(read_c0_prid()));
-- 
2.4.0
