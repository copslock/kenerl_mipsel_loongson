Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 00:36:01 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65267 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225205AbULGAf4>; Tue, 7 Dec 2004 00:35:56 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iB70Zrdh022924;
	Mon, 6 Dec 2004 16:35:53 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iB70ZrUU022914;
	Mon, 6 Dec 2004 16:35:53 -0800
Date: Mon, 6 Dec 2004 16:35:53 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Ocelot-3 memory configuration patch
Message-ID: <20041207003553.GA22456@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Based on your suggestion, I have now modified the Ocelot-3 code
to probe for memory that has been configured by PMON. Please review ...

Thanks
Manish Lachwani


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_ocelot3_memory.patch"

Index: linux/arch/mips/momentum/ocelot_3/prom.c
===================================================================
--- linux.orig/arch/mips/momentum/ocelot_3/prom.c
+++ linux/arch/mips/momentum/ocelot_3/prom.c
@@ -34,6 +34,7 @@
 struct callvectors* debug_vectors;
 extern unsigned long marvell_base;
 extern unsigned long cpu_clock;
+extern unsigned long memsize;
 
 #ifdef CONFIG_MV643XX_ETH
 extern unsigned char prom_mac_addr_base[6];
@@ -194,6 +195,11 @@
 							NULL, 10);
 			printk("cpu_clock set to %d\n", cpu_clock);
 		}
+		if (strncmp("memsize", ptr, strlen("memsize"))  == 0) {
+			memsize = simple_strtol(ptr + strlen("memsize="),
+							NULL, 10);
+		}
+
 		i++;
 	}
 	printk("arcs_cmdline: %s\n", arcs_cmdline);
@@ -222,6 +228,10 @@
 			cpu_clock = simple_strtol(*env + strlen("cpuclock="),
 							NULL, 10);
 		}
+		if (strncmp("memsize", *env, strlen("memsize")) == 0) {
+			memsize = simple_strtol(*env + strlen("memsize="),
+							NULL, 10);
+		}
 		env++;
 	}
 #endif /* CONFIG_MIPS64 */
Index: linux/arch/mips/momentum/ocelot_3/setup.c
===================================================================
--- linux.orig/arch/mips/momentum/ocelot_3/setup.c
+++ linux/arch/mips/momentum/ocelot_3/setup.c
@@ -77,6 +77,9 @@
 /* CPU clock */
 unsigned long cpu_clock;
 
+/* Memory size */
+unsigned long memsize;
+
 /* RTC/NVRAM */
 unsigned char* rtc_base = (unsigned char*)(signed)0xfc800000;
 
@@ -390,8 +393,8 @@
 	printk("  - Boot flash write jumper: %s\n", (tmpword&0x40)?"installed":"absent");
 	printk("  - L3 cache size: %d MB\n", (1<<((tmpword&12) >> 2))&~1);
 
-	/* Support for 256 MB memory */
-	add_memory_region(0x0, 0x10000000, BOOT_MEM_RAM);
+	/* Support for memory configured by PMON*/
+	add_memory_region(0x0, memsize * 1024 * 1024, BOOT_MEM_RAM);
 
 	return 0;
 }

--wac7ysb48OaltWcw--
