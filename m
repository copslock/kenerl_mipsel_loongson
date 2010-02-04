Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2010 00:49:50 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5227 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493178Ab0BDXtq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2010 00:49:46 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6b5d200000>; Thu, 04 Feb 2010 15:49:52 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Feb 2010 15:48:55 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Feb 2010 15:48:55 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o14Nmpfb002974;
        Thu, 4 Feb 2010 15:48:51 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o14Nmnmi002973;
        Thu, 4 Feb 2010 15:48:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix __devinit __cpuinit confusion in cpu_cache_init
Date:   Thu,  4 Feb 2010 15:48:49 -0800
Message-Id: <1265327329-2949-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 04 Feb 2010 23:48:55.0643 (UTC) FILETIME=[9CE66AB0:01CAA5F4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

cpu_cache_init and the things it calls should all be __cpuinit instead
of __devinit.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/c-octeon.c |    4 ++--
 arch/mips/mm/cache.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index e75174a..af85959 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -174,7 +174,7 @@ static void octeon_flush_cache_page(struct vm_area_struct *vma,
  * Probe Octeon's caches
  *
  */
-static void __devinit probe_octeon(void)
+static void __cpuinit probe_octeon(void)
 {
 	unsigned long icache_size;
 	unsigned long dcache_size;
@@ -235,7 +235,7 @@ static void __devinit probe_octeon(void)
  * Setup the Octeon cache flush routines
  *
  */
-void __devinit octeon_cache_init(void)
+void __cpuinit octeon_cache_init(void)
 {
 	extern unsigned long ebase;
 	extern char except_vec2_octeon;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 102b2df..e716caf 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -155,7 +155,7 @@ static inline void setup_protection_map(void)
 	protection_map[15] = PAGE_SHARED;
 }
 
-void __devinit cpu_cache_init(void)
+void __cpuinit cpu_cache_init(void)
 {
 	if (cpu_has_3k_cache) {
 		extern void __weak r3k_cache_init(void);
-- 
1.6.0.6
