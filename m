Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g79IBIRw015798
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 11:11:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g79IBIeT015797
	for linux-mips-outgoing; Fri, 9 Aug 2002 11:11:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g79IBCRw015783
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 11:11:13 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA05901;
	Fri, 9 Aug 2002 11:13:18 -0700
Message-ID: <3D54040C.8060703@mvista.com>
Date: Fri, 09 Aug 2002 11:03:56 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: [PATCH] typo for sibyte swarm board
Content-Type: multipart/mixed;
 boundary="------------030205060005080706030509"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------030205060005080706030509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Otherwise we will see zero-sized memory chunk...

Jun

--------------030205060005080706030509
Content-Type: text/plain;
 name="junk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="junk"

diff -Nru smp/arch/mips/sibyte/swarm/setup.c.orig smp/arch/mips/sibyte/swarm/setup.c
--- smp/arch/mips/sibyte/swarm/setup.c.orig	Wed May 22 18:35:59 2002
+++ smp/arch/mips/sibyte/swarm/setup.c	Fri Aug  9 10:56:43 2002
@@ -367,8 +367,8 @@
 			if (!rd_flag) {
 				if (addr > MAX_RAM_SIZE)
 					continue;
-				if (addr+size > MAX_RAM_SIZE)
-					size = MAX_RAM_SIZE - (addr+size) + 1;
+				if (addr+size-1 > MAX_RAM_SIZE)
+					size = MAX_RAM_SIZE - addr + 1;
 				add_memory_region(addr, size, BOOT_MEM_RAM);
 			}
 			swarm_mem_region_addrs[swarm_mem_region_count] = addr;

--------------030205060005080706030509--
