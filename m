Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g778JdRw029736
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 01:19:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g778JdOH029735
	for linux-mips-outgoing; Wed, 7 Aug 2002 01:19:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g778JMRw029726;
	Wed, 7 Aug 2002 01:19:22 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g778KfXb015056;
	Wed, 7 Aug 2002 01:20:41 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA19530;
	Wed, 7 Aug 2002 01:20:42 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g778Keb12139;
	Wed, 7 Aug 2002 10:20:42 +0200 (MEST)
Message-ID: <3D50D857.E2DDC84F@mips.com>
Date: Wed, 07 Aug 2002 10:20:39 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   linux-mips@oss.sgi.com
Subject: PCI patch of the day
Content-Type: multipart/mixed;
 boundary="------------08E27668F641EB845943C2B1"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------08E27668F641EB845943C2B1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

It's apparently not that easy to get the PCI code right, the current
code won't compile, so here is the patch of the day.

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------08E27668F641EB845943C2B1
Content-Type: text/plain; charset=iso-8859-15;
 name="pci.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.4.patch"

Index: include/asm-mips/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.10
diff -u -r1.24.2.10 pci.h
--- include/asm-mips/pci.h	2002/08/07 03:33:30	1.24.2.10
+++ include/asm-mips/pci.h	2002/08/07 08:06:54
@@ -120,8 +120,8 @@
 	if (direction != PCI_DMA_TODEVICE) {
 		unsigned long addr;
 
-		addr = bus_to_virt(baddr_to_bus(hwdev, dma_address));
-		dma_cache_back_inv(addr, size);
+		addr = (dma_addr_t)bus_to_virt(baddr_to_bus(hwdev, dma_addr));
+		dma_cache_wback_inv(addr, size);
 	}
 }
 
@@ -153,8 +153,8 @@
 	if (direction != PCI_DMA_TODEVICE) {
 		unsigned long addr;
 
-		addr = bus_to_virt(baddr_to_bus(hwdev, dma_address));
-		dma_cache_back_inv(addr, size);
+		addr = (dma_addr_t)bus_to_virt(baddr_to_bus(hwdev, dma_address));
+		dma_cache_wback_inv(addr, size);
 	}
 }
 
@@ -255,7 +255,7 @@
 	if (direction == PCI_DMA_NONE)
 		out_of_line_bug();
 
-	addr = dma_handle - bus_to_baddr(hwdev->bus->number) + PAGE_OFFSET;
+	addr = (dma_addr_t)bus_to_virt(baddr_to_bus(hwdev->bus->number, dma_handle));
 	dma_cache_wback_inv(addr, size);
 }
 
Index: include/asm-mips64/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/pci.h,v
retrieving revision 1.16.2.11
diff -u -r1.16.2.11 pci.h
--- include/asm-mips64/pci.h	2002/08/07 03:33:30	1.16.2.11
+++ include/asm-mips64/pci.h	2002/08/07 08:06:55
@@ -146,8 +146,8 @@
 	if (direction != PCI_DMA_TODEVICE) {
 		unsigned long addr;
 
-		addr = bus_to_virt(baddr_to_bus(hwdev, dma_address));
-		dma_cache_back_inv(addr, size);
+		addr = (dma_addr_t)bus_to_virt(baddr_to_bus(hwdev, dma_addr));
+		dma_cache_wback_inv(addr, size);
 	}
 }
 
@@ -187,8 +187,8 @@
 	if (direction != PCI_DMA_TODEVICE) {
 		unsigned long addr;
 
-		addr = bus_to_virt(baddr_to_bus(hwdev, dma_address));
-		dma_cache_back_inv(addr, size);
+		addr = (dma_addr_t)bus_to_virt(baddr_to_bus(hwdev, dma_address));
+		dma_cache_wback_inv(addr, size);
 	}
 }
 
@@ -281,7 +281,7 @@
 	if (direction == PCI_DMA_NONE)
 		out_of_line_bug();
 
-	addr = dma_handle - bus_to_baddr(hwdev->bus->number) + PAGE_OFFSET;
+	addr = (dma_addr_t)bus_to_virt(baddr_to_bus(hwdev->bus->number, dma_handle));
 	dma_cache_wback_inv(addr, size);
 }
 

--------------08E27668F641EB845943C2B1--
