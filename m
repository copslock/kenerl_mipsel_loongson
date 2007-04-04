Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:36:32 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:22247 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022098AbXDDObf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:35 +0100
Received: (qmail 16939 invoked by uid 511); 4 Apr 2007 14:30:21 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:21 -0000
Message-ID: <680071.485086472-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 13/16] cache support for Loongson2 processor
Date:	Wed, 4 Apr 2007 14:38:20 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-232529.466579766"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-232529.466579766
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/mm/c-r4k.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index df04a31..19762b5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -335,6 +335,10 @@ static void r4k_flush_cache_all(void)
 
 static inline void local_r4k___flush_cache_all(void * args)
 {
+#if defined(CONFIG_CPU_LOONGSON2)
+	r4k_blast_scache();
+	return;
+#endif
 	r4k_blast_dcache();
 	r4k_blast_icache();
 
@@ -848,6 +852,26 @@ static void __init probe_pcache(void)
 		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
+	case CPU_LOONGSON2:
+		icache_size = 1 << (12 + ((config & CONF_IC) >> 9));
+		c->icache.linesz = 16 << ((config & CONF_IB) >> 5);
+		if (prid & 0x3) {
+		  c->icache.ways = 4;
+		} else {
+		  c->icache.ways = 2;
+		}
+		c->icache.waybit= 0;
+
+		dcache_size = 1 << (12 + ((config & CONF_DC) >> 6));
+		c->dcache.linesz = 16 << ((config & CONF_DB) >> 4);
+		if (prid & 0x3) {
+		  c->dcache.ways = 4;
+		} else {
+		  c->dcache.ways = 2;
+		}
+		c->dcache.waybit = 0;
+	    	break;
+
 	default:
 		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
@@ -963,6 +987,11 @@ static void __init probe_pcache(void)
 		break;
 	}
 
+#ifdef  CONFIG_CPU_LOONGSON2
+	/* LOONGSON2 has 4 way icache, but when using indexed cache op, one op will act on all 4 ways*/
+	c->icache.ways = 1;
+#endif
+
 	printk("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
 	       icache_size >> 10,
 	       cpu_has_vtag_icache ? "virtually tagged" : "physically tagged",
@@ -1036,6 +1065,25 @@ static int __init probe_scache(void)
 	return 1;
 }
 
+#if defined(CONFIG_CPU_LOONGSON2)
+static void __init loongson2_sc_init(void)
+{
+    struct cpuinfo_mips *c = &current_cpu_data;
+
+    scache_size = 512*1024;
+    c->scache.linesz = 32;
+    c->scache.ways = 4;
+    c->scache.waybit = 0;
+    c->scache.waysize = scache_size / (c->scache.ways);
+    c->scache.sets = scache_size /(c->scache.linesz * c->scache.ways);
+    printk("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
+		    scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
+
+    c->options |= MIPS_CPU_INCLUSIVE_CACHES;
+    return;
+}
+#endif
+
 extern int r5k_sc_init(void);
 extern int rm7k_sc_init(void);
 extern int mips_sc_init(void);
@@ -1085,6 +1133,12 @@ static void __init setup_scache(void)
 #endif
 		return;
 
+#if defined(CONFIG_CPU_LOONGSON2)
+	case CPU_LOONGSON2:
+		loongson2_sc_init();
+		return;
+#endif
+
 	default:
 		if (c->isa_level == MIPS_CPU_ISA_M32R1 ||
 		    c->isa_level == MIPS_CPU_ISA_M32R2 ||
-- 
1.4.4.4



------MIME delimiter for sendEmail-232529.466579766--
