Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 13:52:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:54726 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023615AbYDNMwC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 13:52:02 +0100
Received: from localhost (p6040-ipad303funabasi.chiba.ocn.ne.jp [123.217.152.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7D1C9AD83; Mon, 14 Apr 2008 21:51:57 +0900 (JST)
Date:	Mon, 14 Apr 2008 21:52:51 +0900 (JST)
Message-Id: <20080414.215251.25478108.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix some section mismatches
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Also make coherentio static.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/kernel/spram.c |   14 +++++++-------
 arch/mips/mm/c-r4k.c     |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
index 31bb952..6ddb507 100644
--- a/arch/mips/kernel/spram.c
+++ b/arch/mips/kernel/spram.c
@@ -39,7 +39,7 @@
 /*
  * Different semantics to the set_c0_* function built by __BUILD_SET_C0
  */
-static __init unsigned int bis_c0_errctl(unsigned int set)
+static __cpuinit unsigned int bis_c0_errctl(unsigned int set)
 {
 	unsigned int res;
 	res = read_c0_errctl();
@@ -47,7 +47,7 @@ static __init unsigned int bis_c0_errctl(unsigned int set)
 	return res;
 }
 
-static __init void ispram_store_tag(unsigned int offset, unsigned int data)
+static __cpuinit void ispram_store_tag(unsigned int offset, unsigned int data)
 {
 	unsigned int errctl;
 
@@ -66,7 +66,7 @@ static __init void ispram_store_tag(unsigned int offset, unsigned int data)
 }
 
 
-static __init unsigned int ispram_load_tag(unsigned int offset)
+static __cpuinit unsigned int ispram_load_tag(unsigned int offset)
 {
 	unsigned int data;
 	unsigned int errctl;
@@ -84,7 +84,7 @@ static __init unsigned int ispram_load_tag(unsigned int offset)
 	return data;
 }
 
-static __init void dspram_store_tag(unsigned int offset, unsigned int data)
+static __cpuinit void dspram_store_tag(unsigned int offset, unsigned int data)
 {
 	unsigned int errctl;
 
@@ -100,7 +100,7 @@ static __init void dspram_store_tag(unsigned int offset, unsigned int data)
 }
 
 
-static __init unsigned int dspram_load_tag(unsigned int offset)
+static __cpuinit unsigned int dspram_load_tag(unsigned int offset)
 {
 	unsigned int data;
 	unsigned int errctl;
@@ -117,7 +117,7 @@ static __init unsigned int dspram_load_tag(unsigned int offset)
 	return data;
 }
 
-static __init void probe_spram(char *type,
+static __cpuinit void probe_spram(char *type,
 	    unsigned int base,
 	    unsigned int (*read)(unsigned int),
 	    void (*write)(unsigned int, unsigned int))
@@ -199,7 +199,7 @@ static __init void probe_spram(char *type,
 	}
 }
 
-__init void spram_config(void)
+__cpuinit void spram_config(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config0;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 92b549e..82bdc66 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1226,7 +1226,7 @@ void au1x00_fixup_config_od(void)
 	}
 }
 
-static int __initdata cca = -1;
+static int __cpuinitdata cca = -1;
 unsigned long _page_cachable_default;
 EXPORT_SYMBOL_GPL(_page_cachable_default);
 
@@ -1296,7 +1296,7 @@ static void __cpuinit coherency_setup(void)
 
 #if defined(CONFIG_DMA_NONCOHERENT)
 
-int __initdata coherentio;
+static int __cpuinitdata coherentio;
 
 static int __init setcoherentio(char *str)
 {
