Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 00:38:31 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:38152 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20039612AbWJWXi2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2006 00:38:28 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Gc9NE-0007Op-00; Tue, 24 Oct 2006 00:38:28 +0100
Received: from pimlico.mips.com ([192.168.192.143] helo=localhost.localdomain)
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gc9Mg-0000PP-00; Tue, 24 Oct 2006 00:37:54 +0100
Received: from ths by localhost.localdomain with local (Exim 4.50)
	id 1Gc9Mf-0006rx-Va; Tue, 24 Oct 2006 00:37:53 +0100
Date:	Tue, 24 Oct 2006 00:37:53 +0100
From:	ths@networkno.de
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH, 2.6.18] Implement missing flush_cache_data_page on SB-1(a)
Message-ID: <20061023233753.GA11979@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: ths@networkno.de
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

The appended patch implements flush_data_cache_page for SB-1(a). This
fixes the bcm1480 hanging at boot after "Freeing unused kernel memory"
when booting from NFS (and likely also any other PIO-driven device).


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>


diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index 16bad7c..acae51c 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 #include <linux/init.h>
+#include <linux/hardirq.h>
 
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
@@ -233,6 +234,25 @@ void sb1_flush_cache_page(struct vm_area
 	__attribute__((alias("local_sb1_flush_cache_page")));
 #endif
 
+#ifdef CONFIG_SMP
+static void sb1_flush_cache_data_page_ipi(void *info)
+{
+	unsigned long start = (unsigned long)info;
+
+	__sb1_writeback_inv_dcache_range(start, start + PAGE_SIZE);
+}
+
+static void sb1_flush_cache_data_page(unsigned long addr)
+{
+	if (in_atomic())
+		__sb1_writeback_inv_dcache_range(addr, addr + PAGE_SIZE);
+	else
+		on_each_cpu(sb1_flush_cache_data_page_ipi, (void *) addr, 1, 1);
+}
+#else
+void sb1_flush_cache_data_page(unsigned long)
+	__attribute__((alias("local_sb1_flush_cache_data_page")));
+#endif
 
 /*
  * Invalidate all caches on this CPU
@@ -504,7 +524,6 @@ static __init void probe_cache_sizes(voi
 void sb1_cache_init(void)
 {
 	extern char except_vec2_sb1;
-	extern char handle_vec2_sb1;
 
 	/* Special cache error handler for SB1 */
 	set_uncached_handler (0x100, &except_vec2_sb1, 0x80);
@@ -534,7 +553,7 @@ #endif
 
 	flush_cache_sigtramp = sb1_flush_cache_sigtramp;
 	local_flush_data_cache_page = (void *) sb1_nop;
-	flush_data_cache_page = (void *) sb1_nop;
+	flush_data_cache_page = sb1_flush_cache_data_page;
 
 	/* Full flush */
 	__flush_cache_all = sb1___flush_cache_all;
@@ -558,5 +577,5 @@ #endif
 	:
 	: "memory");
 
-	flush_cache_all();
+	local_sb1___flush_cache_all();
 }
