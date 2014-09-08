Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 17:28:35 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:58283 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008471AbaIHP10SaL0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 17:27:26 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s88FRJUE002219
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 8 Sep 2014 15:27:19 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s88FRGFb002806;
        Mon, 8 Sep 2014 17:27:19 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 4/4] MIPS: OCTEON: mark octeon_model_get_string() with __init
Date:   Mon,  8 Sep 2014 18:25:43 +0300
Message-Id: <1410189943-4573-5-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
References: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2647
X-purgate-ID: 151667::1410190039-00002A30-BFA32ABC/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42477
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

Mark octeon_model_get_string() with __init and make internal functions
static.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 7 ++++---
 arch/mips/include/asm/octeon/cvmx.h              | 2 --
 arch/mips/include/asm/octeon/octeon-model.h      | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index 5105d0d..e15b049 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -33,7 +33,7 @@
  *
  * Returns fuse value: 0 or 1
  */
-uint8_t cvmx_fuse_read_byte(int byte_addr)
+static uint8_t __init cvmx_fuse_read_byte(int byte_addr)
 {
 	union cvmx_mio_fus_rcmd read_cmd;
 
@@ -52,7 +52,8 @@ uint8_t cvmx_fuse_read_byte(int byte_addr)
  * as running early in u-boot static/global variables don't work when
  * running from flash.
  */
-const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
+static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
+							 char *buffer)
 {
 	const char *family;
 	const char *core_model;
@@ -422,7 +423,7 @@ const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer)
  *
  * Returns Model string
  */
-const char *octeon_model_get_string(uint32_t chip_id)
+const char *__init octeon_model_get_string(uint32_t chip_id)
 {
 	static char buffer[32];
 	return octeon_model_get_string_buffer(chip_id, buffer);
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index b0b544f..33db1c8 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -451,6 +451,4 @@ static inline uint32_t cvmx_octeon_num_cores(void)
 	return cvmx_pop(ciu_fuse);
 }
 
-uint8_t cvmx_fuse_read_byte(int byte_addr);
-
 #endif /*  __CVMX_H__  */
diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index e2c122c..e8a1c2f 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -326,8 +326,7 @@ static inline int __octeon_is_model_runtime__(uint32_t model)
 #define OCTEON_IS_COMMON_BINARY() 1
 #undef OCTEON_MODEL
 
-const char *octeon_model_get_string(uint32_t chip_id);
-const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer);
+const char *__init octeon_model_get_string(uint32_t chip_id);
 
 /*
  * Return the octeon family, i.e., ProcessorID of the PrID register.
-- 
2.1.0
