Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 03:35:19 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:43249 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225230AbUJUCfL>; Thu, 21 Oct 2004 03:35:11 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 83BC4184F7; Wed, 20 Oct 2004 19:35:09 -0700 (PDT)
Subject: [PATCH]On PMC Yosemite, get the memory size from PMON
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1098326108.4266.23.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Oct 2004 19:35:09 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Ralf

Attached untested patch implements support for getting the memory size
from PMON.PMON stores the memory size in MB in an env variable called
memsize. This patch follows the previous hypertransport patch

Thanks
Manish Lachwani

--- arch/mips/pmc-sierra/yosemite/setup.c.orig	2004-10-20
19:09:17.000000000 -0700
+++ arch/mips/pmc-sierra/yosemite/setup.c	2004-10-20 19:11:09.000000000
-0700
@@ -59,6 +59,7 @@
 
 unsigned long cpu_clock;
 unsigned long yosemite_base;
+unsigned long memory_size;
 
 void __init bus_error_init(void)
 {
@@ -197,8 +198,12 @@
 	board_time_init = yosemite_time_init;
 	late_time_init = py_map_ocd;
 
-	/* Add memory regions */
-	add_memory_region(0x00000000, 0x10000000, BOOT_MEM_RAM);
+	/* 
+	 * Add memory regions. Check what PMON as for us and 
+	 * then config memory. PMON reports the memory config
+	 * in MB
+	 */
+	add_memory_region(0x00000000, memory_size*1024*1024, BOOT_MEM_RAM);
 
 	if (val & 0x00000020) {
 		/*
--- arch/mips/pmc-sierra/yosemite/prom.c.orig	2004-10-20
18:55:06.000000000 -0700
+++ arch/mips/pmc-sierra/yosemite/prom.c	2004-10-20 19:08:40.000000000
-0700
@@ -27,6 +27,7 @@
 
 extern unsigned long yosemite_base;
 extern unsigned long cpu_clock;
+extern unsigned long memory_size; /* Get the memory size from PMON */
 
 const char *get_system_type(void)
 {
@@ -112,6 +113,11 @@
 			    simple_strtol(*env + strlen("cpuclock="), NULL,
 					  10);
 
+		if (strncmp("memsize", *env, strlen("memsize")) == 0)
+			memory_size =
+			    simple_strtol(*env + strlen("memsize="), NULL,
+					  4);
+
 		env++;
 	}
 #endif /* CONFIG_MIPS32 */
