Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2006 16:51:46 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.231]:36 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038903AbWINPvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Sep 2006 16:51:44 +0100
Received: by wx-out-0506.google.com with SMTP id h30so3155837wxd
        for <linux-mips@linux-mips.org>; Thu, 14 Sep 2006 08:51:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=X4b6bXtkqGqRy7yfs1qBTK7nD2nlxwMf2AkDfif54o61e0qm0j0KPNDEB3uio2H5jQbZlehWPFyAkIfH2ONrdcHDZCMN8H3Cv8/Kx2I6bwJuvV6x8I/9cjOL8O1stdw/KmFiF171tR4XrUhAPzd4b8/FqDl4Gdbfc1sWMryRurE=
Received: by 10.70.29.7 with SMTP id c7mr12818166wxc;
        Thu, 14 Sep 2006 08:51:41 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id i12sm1572680wxd.2006.09.14.08.51.40;
        Thu, 14 Sep 2006 08:51:40 -0700 (PDT)
Message-ID: <45097A89.4060303@gmail.com>
Date:	Thu, 14 Sep 2006 11:51:37 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Add cache info to /proc/cpuinfo
Content-Type: multipart/mixed;
 boundary="------------080408080008000303090702"
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080408080008000303090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch shows you more details about the cache using /proc/cpuinfo.
It also shows the TLB page size.

For example:

system type             : MIPS Malta
processor               : 0
cpu model               : MIPS 20Kc V2.0  FPU V2.0
BogoMIPS                : 478.20
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 48 64K pages
icache size             : 32K sets 256 ways 4 linesize 32
dcache size             : 32K sets 256 ways 4 linesize 32
default cache policy    : cached write-back
extra interrupt vector  : yes
hardware watchpoint     : yes
ASEs implemented        : mips3d
VCED exceptions         : not available
VCEI exceptions         : not available



--------------080408080008000303090702
Content-Type: text/plain;
 name="0001-Add-cache-info-to-cpuinfo-display.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-cache-info-to-cpuinfo-display.txt"

Date: Thu, 14 Sep 2006 11:24:51 -0400
Subject: [PATCH] Add cache info to cpuinfo display.
---
 arch/mips/kernel/proc.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index d8beef1..54f4da3 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -92,6 +92,7 @@ static int show_cpuinfo(struct seq_file 
 	unsigned int version = current_cpu_data.processor_id;
 	unsigned int fp_vers = current_cpu_data.fpu_id;
 	unsigned long n = (unsigned long) v - 1;
+	unsigned long cache_size;
 	char fmt [64];
 
 #ifdef CONFIG_SMP
@@ -118,7 +119,38 @@ #endif
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 	              cpu_has_counter ? "yes" : "no");
-	seq_printf(m, "tlb_entries\t\t: %d\n", current_cpu_data.tlbsize);
+	seq_printf(m, "tlb_entries\t\t: %d %luK pages\n", current_cpu_data.tlbsize,
+			PAGE_SIZE/1024);
+	cache_size = current_cpu_data.icache.sets * 
+		     current_cpu_data.icache.ways *
+		     current_cpu_data.icache.linesz;
+	if (cache_size) {
+	    seq_printf(m, "icache size\t\t: %luK sets %d ways %d linesize %d\n",
+	              cache_size/1024, current_cpu_data.icache.sets,
+		      current_cpu_data.icache.ways, current_cpu_data.icache.linesz);
+	}
+	cache_size = current_cpu_data.dcache.sets * 
+		     current_cpu_data.dcache.ways *
+		     current_cpu_data.dcache.linesz;
+	if (cache_size) {
+	    seq_printf(m, "dcache size\t\t: %luK sets %d ways %d linesize %d\n",
+	              cache_size/1024, current_cpu_data.dcache.sets,
+		      current_cpu_data.dcache.ways, current_cpu_data.dcache.linesz);
+	}
+	cache_size = current_cpu_data.scache.sets * 
+		     current_cpu_data.scache.ways *
+		     current_cpu_data.scache.linesz;
+	if (cache_size) {
+	    seq_printf(m, "scache size\t\t: %luK sets %d ways %d linesize %d\n",
+	              cache_size/1024, current_cpu_data.scache.sets,
+		      current_cpu_data.scache.ways, current_cpu_data.scache.linesz);
+	}
+	/* In pgtable-bits.h we never use a write-through policy */
+#ifdef CONFIG_MIPS_UNCACHED
+	seq_printf(m, "default cache policy\t: uncached\n");
+#else
+	seq_printf(m, "default cache policy\t: cached write-back\n");
+#endif
 	seq_printf(m, "extra interrupt vector\t: %s\n",
 	              cpu_has_divec ? "yes" : "no");
 	seq_printf(m, "hardware watchpoint\t: %s\n",
-- 
1.4.1


--------------080408080008000303090702--
