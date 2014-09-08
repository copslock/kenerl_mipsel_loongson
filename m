Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 17:28:19 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:58278 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008352AbaIHP1Z40b9O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 17:27:25 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s88FRJUO002194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 8 Sep 2014 15:27:19 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s88FRGFa002806;
        Mon, 8 Sep 2014 17:27:18 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 3/4] MIPS: OCTEON: move code to avoid forward declaration
Date:   Mon,  8 Sep 2014 18:25:42 +0300
Message-Id: <1410189943-4573-4-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
References: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2042
X-purgate-ID: 151667::1410190039-00002A30-A55AF63B/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

Move code to avoid forward declarations.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 38 ++++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index e187872..5105d0d 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -47,25 +47,6 @@ uint8_t cvmx_fuse_read_byte(int byte_addr)
 	return read_cmd.s.dat;
 }
 
-/**
- * Given the chip processor ID from COP0, this function returns a
- * string representing the chip model number. The string is of the
- * form CNXXXXpX.X-FREQ-SUFFIX.
- * - XXXX = The chip model number
- * - X.X = Chip pass number
- * - FREQ = Current frequency in Mhz
- * - SUFFIX = NSP, EXP, SCP, SSP, or CP
- *
- * @chip_id: Chip ID
- *
- * Returns Model string
- */
-const char *octeon_model_get_string(uint32_t chip_id)
-{
-	static char buffer[32];
-	return octeon_model_get_string_buffer(chip_id, buffer);
-}
-
 /*
  * Version of octeon_model_get_string() that takes buffer as argument,
  * as running early in u-boot static/global variables don't work when
@@ -427,3 +408,22 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
 	sprintf(buffer, "CN%s%sp%s-%d-%s", family, core_model, pass, clock_mhz, suffix);
 	return buffer;
 }
+
+/**
+ * Given the chip processor ID from COP0, this function returns a
+ * string representing the chip model number. The string is of the
+ * form CNXXXXpX.X-FREQ-SUFFIX.
+ * - XXXX = The chip model number
+ * - X.X = Chip pass number
+ * - FREQ = Current frequency in Mhz
+ * - SUFFIX = NSP, EXP, SCP, SSP, or CP
+ *
+ * @chip_id: Chip ID
+ *
+ * Returns Model string
+ */
+const char *octeon_model_get_string(uint32_t chip_id)
+{
+	static char buffer[32];
+	return octeon_model_get_string_buffer(chip_id, buffer);
+}
-- 
2.1.0
