Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 17:27:46 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:46881 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008470AbaIHP1ZbWNf4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 17:27:25 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s88FRI9W016450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 8 Sep 2014 15:27:18 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s88FRGFY002806;
        Mon, 8 Sep 2014 17:27:18 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 1/4] MIPS: OCTEON: move cvmx_fuse_read_byte()
Date:   Mon,  8 Sep 2014 18:25:40 +0300
Message-Id: <1410189943-4573-2-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
References: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2140
X-purgate-ID: 151667::1410190038-00005326-4F480274/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42474
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

Move cvmx_fuse_read_byte() into a .c file.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 20 ++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx.h              | 20 +-------------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index f4c1b36..e187872 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -28,6 +28,26 @@
 #include <asm/octeon/octeon.h>
 
 /**
+ * Read a byte of fuse data
+ * @byte_addr:	 address to read
+ *
+ * Returns fuse value: 0 or 1
+ */
+uint8_t cvmx_fuse_read_byte(int byte_addr)
+{
+	union cvmx_mio_fus_rcmd read_cmd;
+
+	read_cmd.u64 = 0;
+	read_cmd.s.addr = byte_addr;
+	read_cmd.s.pend = 1;
+	cvmx_write_csr(CVMX_MIO_FUS_RCMD, read_cmd.u64);
+	while ((read_cmd.u64 = cvmx_read_csr(CVMX_MIO_FUS_RCMD))
+	       && read_cmd.s.pend)
+		;
+	return read_cmd.s.dat;
+}
+
+/**
  * Given the chip processor ID from COP0, this function returns a
  * string representing the chip model number. The string is of the
  * form CNXXXXpX.X-FREQ-SUFFIX.
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index f991e77..6852dfa 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -451,25 +451,7 @@ static inline uint32_t cvmx_octeon_num_cores(void)
 	return cvmx_pop(ciu_fuse);
 }
 
-/**
- * Read a byte of fuse data
- * @byte_addr:	 address to read
- *
- * Returns fuse value: 0 or 1
- */
-static uint8_t cvmx_fuse_read_byte(int byte_addr)
-{
-	union cvmx_mio_fus_rcmd read_cmd;
-
-	read_cmd.u64 = 0;
-	read_cmd.s.addr = byte_addr;
-	read_cmd.s.pend = 1;
-	cvmx_write_csr(CVMX_MIO_FUS_RCMD, read_cmd.u64);
-	while ((read_cmd.u64 = cvmx_read_csr(CVMX_MIO_FUS_RCMD))
-	       && read_cmd.s.pend)
-		;
-	return read_cmd.s.dat;
-}
+uint8_t cvmx_fuse_read_byte(int byte_addr);
 
 /**
  * Read a single fuse bit
-- 
2.1.0
