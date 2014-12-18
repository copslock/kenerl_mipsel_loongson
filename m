Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 11:24:13 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:48940 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009088AbaLRKWjrisOp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 11:22:39 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 13:22:34 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 12/12] MIPS: OCTEON: Handle OCTEON III in csrc-octeon.
Date:   Thu, 18 Dec 2014 13:18:04 +0300
Message-ID: <1418897888-17669-13-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

The clock divisors are kept in different registers on OCTEON III.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index b752c4e..a0d5029 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -14,11 +14,36 @@
 #include <asm/cpu-info.h>
 #include <asm/cpu-type.h>
 #include <asm/time.h>
+#include <asm/bitfield.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 
+#define CVMX_RST_BOOT CVMX_ADD_IO_SEG(0x0001180006001600ull)
+
+union cvmx_rst_boot {
+	uint64_t u64;
+	struct cvmx_rst_boot_s {
+		__BITFIELD_FIELD(uint64_t chipkill       : 1,
+		__BITFIELD_FIELD(uint64_t jtcsrdis       : 1,
+		__BITFIELD_FIELD(uint64_t ejtagdis       : 1,
+		__BITFIELD_FIELD(uint64_t romen          : 1,
+		__BITFIELD_FIELD(uint64_t ckill_ppdis    : 1,
+		__BITFIELD_FIELD(uint64_t jt_tstmode     : 1,
+		__BITFIELD_FIELD(uint64_t vrm_err        : 1,
+		__BITFIELD_FIELD(uint64_t reserved_37_56 : 20,
+		__BITFIELD_FIELD(uint64_t c_mul          : 7,
+		__BITFIELD_FIELD(uint64_t pnr_mul        : 6,
+		__BITFIELD_FIELD(uint64_t reserved_21_23 : 3,
+		__BITFIELD_FIELD(uint64_t lboot_oci      : 3,
+		__BITFIELD_FIELD(uint64_t lboot_ext      : 6,
+		__BITFIELD_FIELD(uint64_t lboot          : 10,
+		__BITFIELD_FIELD(uint64_t rboot          : 1,
+		__BITFIELD_FIELD(uint64_t rboot_pin      : 1,
+		;))))))))))))))))
+	} s;
+};
 
 static u64 f;
 static u64 rdiv;
@@ -39,11 +64,20 @@ void __init octeon_setup_delays(void)
 
 	if (current_cpu_type() == CPU_CAVIUM_OCTEON2) {
 		union cvmx_mio_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
 		rdiv = rst_boot.s.c_mul;	/* CPU clock */
 		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
 		f = (0x8000000000000000ull / sdiv) * 2;
+	} else if (current_cpu_type() == CPU_CAVIUM_OCTEON3) {
+		union cvmx_rst_boot rst_boot;
+
+		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
+		rdiv = rst_boot.s.c_mul;	/* CPU clock */
+		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
+		f = (0x8000000000000000ull / sdiv) * 2;
 	}
+
 }
 
 /*
-- 
2.1.3
