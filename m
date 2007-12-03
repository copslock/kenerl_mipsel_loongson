Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 17:59:36 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:24486 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20024727AbXLCR70 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2007 17:59:26 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1IzFWd-0006uL-CQ; Mon, 03 Dec 2007 09:56:11 -0800
Date:	Mon, 3 Dec 2007 09:56:11 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Add code to determine the L2 cache size on Sibyte 1250/112x processors.
Message-ID: <20071203175601.GA26533@onstor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

Resend with an actual from header in the email.
Stupid git-send-email...grmbl


Add code to determine the L2 cache size on Sibyte 1250/112x processors.

Signed-off-by: Andrew Sharp <andy.sharp@onstor.com>
---
 arch/mips/mm/c-sb1.c                 |   70 ++++++++++++++++++++++++++++++++++
 include/asm-mips/sibyte/sb1250_l2c.h |    4 ++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index ca8547e..cbc39f7 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -28,6 +28,9 @@
 #include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
 #include <asm/uaccess.h>
+#include <asm/sibyte/sb1250.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_l2c.h>
 
 extern void sb1_dma_init(void);
 
@@ -423,6 +426,68 @@ static unsigned int decode_cache_line_size(unsigned int config_field)
 }
 
 /*
+ * each bit in the 4-bit way-enable field indicates an enabled way
+ */
+
+ static int
+decode_l2_ways(u64 l2_misc)
+{
+	int ways;
+	int size;
+
+	ways = G_L2C_MISC_NO_WAY(l2_misc) ^ 0xf;
+	if (ways) {
+		int i;
+
+		size = L2C_NUM_WAYS;
+		for (i = 0; i < 4; i++) {
+			if (ways & 1) {
+				size -= 1;
+			}
+			ways = ways >> 1;
+		}
+		ways = size;
+	} else {
+		ways = L2C_NUM_WAYS;
+	}
+
+	return ways;
+}
+
+/*
+ * 0          = full size: 512KiB on 1250, 256 on 112x
+ * 1 || 2     = 256KiB
+ * 5, 6, 9, a = 128 KiB
+ */
+ static int
+decode_l2_size(u64 l2_misc)
+{
+	int size = 0;
+	int ways;
+
+	ways = decode_l2_ways(l2_misc);
+
+	switch _SB_GETVALUE(l2_misc, 4, _SB_MAKEMASK(4, 4)) {
+	case 0:
+		/* line size is 32 bytes on l2 cache */
+		size = (L2C_ENTRIES_PER_WAY * ways * 32) / 1024;
+		break;
+	case 1:
+	case 2:
+		size = 256;
+		break;
+	case 5:
+	case 6:
+	case 9:
+	case 0xa:
+		size = 128;
+		break;
+	}
+
+	return size;
+}
+
+/*
  * Relevant bits of the config1 register format (from the MIPS32/MIPS64 specs)
  *
  * 24:22 Icache sets per way
@@ -441,6 +506,7 @@ static char *way_string[] = {
 static __init void probe_cache_sizes(void)
 {
 	u32 config1;
+	u64 l2_misc;
 
 	config1 = read_c0_config1();
 	icache_line_size = decode_cache_line_size((config1 >> 19) & 0x7);
@@ -469,6 +535,10 @@ static __init void probe_cache_sizes(void)
 	printk("Primary data cache %ldkB, %s, linesize %d bytes.\n",
 	       dcache_size >> 10, way_string[dcache_assoc - 1],
 	       dcache_line_size);
+
+	l2_misc = __raw_readq(IOADDR(A_L2_READ_MISC));
+	printk("Secondary cache %dkB, %s, linesize %d bytes.\n",
+		decode_l2_size(l2_misc), way_string[decode_l2_ways(l2_misc) - 1], 32);
 }
 
 /*
diff --git a/include/asm-mips/sibyte/sb1250_l2c.h b/include/asm-mips/sibyte/sb1250_l2c.h
index 842f205..6aa19ad 100644
--- a/include/asm-mips/sibyte/sb1250_l2c.h
+++ b/include/asm-mips/sibyte/sb1250_l2c.h
@@ -102,7 +102,11 @@
 
 #define A_L2C_MGMT_TAG_BASE         0x00D0000000
 
+#ifndef CONFIG_SIBYTE_BCM112X
 #define L2C_ENTRIES_PER_WAY       4096
+#else
+#define L2C_ENTRIES_PER_WAY       2048
+#endif
 #define L2C_NUM_WAYS              4
 
 
-- 
1.4.4.4
