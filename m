Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2004 13:34:02 +0100 (BST)
Received: from web13309.mail.yahoo.com ([IPv6:::ffff:216.136.175.192]:24431
	"HELO web13309.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225875AbUFBMd5>; Wed, 2 Jun 2004 13:33:57 +0100
Message-ID: <20040602123346.58165.qmail@web13309.mail.yahoo.com>
Received: from [12.33.232.234] by web13309.mail.yahoo.com via HTTP; Wed, 02 Jun 2004 05:33:46 PDT
Date: Wed, 2 Jun 2004 05:33:46 -0700 (PDT)
From: Ken Giusti <manwithastinkydog@yahoo.com>
Subject: cat /proc/iomem crash +patch
To: linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <manwithastinkydog@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manwithastinkydog@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm running 2.4 on a swarm card with 2Gig of memory.
I've got CONFIG_64BIT_PHYS_ADDR=y configured.  I get
the following memory map during boot:

Determined physical RAM map:
 memory: 0fe82e00 @ 00000000 (usable)
 memory: 1ffffe00 @ 80000000 (usable)
 memory: 0ffffe00 @ c0000000 (usable)
 memory: 3ffffe00 @ 100000000 (usable)

"cat"ing /proc/iomem would cause an oops.   I traced
this to setup.c::resource_init(), which was
incorrectly
truncating the start address of the 0x100000000 memory
entry to fit in a 32 bit ulong.  This would cause
the request_resource call to fail, triggering a bug
which would insert an invalid root node in the iomem
map. 

Here's a patch that works for me:

cvs diff: Diffing .
Index: setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.168
diff -u -r1.168 setup.c
--- setup.c	8 Feb 2004 14:57:04 -0000	1.168
+++ setup.c	2 Jun 2004 12:24:37 -0000
@@ -382,7 +382,7 @@
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		struct resource *res;
-		unsigned long start, end;
+		phys_t start, end;
 
 		start = boot_mem_map.map[i].addr;
 		end = boot_mem_map.map[i].addr +
boot_mem_map.map[i].size - 1;
@@ -406,15 +406,16 @@
 		res->end = end;
 
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
+		if (request_resource(&iomem_resource, res) == 0) {
 
-		/*
-		 *  We don't know which RAM region contains kernel
data,
-		 *  so we try it repeatedly and let the resource
manager
-		 *  test it.
-		 */
-		request_resource(res, &code_resource);
-		request_resource(res, &data_resource);
+			/*
+			 *  We don't know which RAM region contains kernel
data,
+			 *  so we try it repeatedly and let the resource
manager
+			 *  test it.
+			 */
+			request_resource(res, &code_resource);
+			request_resource(res, &data_resource);
+		}
 	}
 }

-K





	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
