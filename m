Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0A8Gvs00931
	for linux-mips-outgoing; Thu, 10 Jan 2002 00:16:57 -0800
Received: from cast-ext.ab.videon.ca (cast-ext.ab.videon.ca [206.75.216.34])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0A8Grg00928
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 00:16:53 -0800
Received: (qmail 21762 invoked from network); 10 Jan 2002 07:16:50 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by cast-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <linux-mips@oss.sgi.com>; 10 Jan 2002 07:16:50 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16OZSE-0004Xz-00
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 00:16:50 -0700
Date: Thu, 10 Jan 2002 00:16:50 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: linux-mips <linux-mips@oss.sgi.com>
Subject: initrd breaks with exactly 512M of ram
Message-ID: <Pine.LNX.3.96.1020109235100.16693A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I realize this is a very unique situation, but the initrd code breaks with
exactly 512M of RAM mapped from 0 to 512M: 

Determined physical RAM map:
 memory: 20000000 @ 00000000 (usable)
Initial ramdisk at: 0x8023a000 (629389 bytes)
initrd extends beyond end of memory (0x802d3a8d > 0x80000000)

Here is a little patch - instead of converting the PFN to a physical
address it converts the initrd_end to a PFN.

Thanks,
Jason

Index: setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96
diff -u -r1.96 setup.c
--- setup.c	2001/12/02 11:34:38	1.96
+++ setup.c	2002/01/10 08:01:18
@@ -921,7 +928,7 @@
 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
 		       (void *)initrd_start, 
 		       initrd_size);
-		if ((void *)initrd_end > phys_to_virt(PFN_PHYS(max_low_pfn))) {
+		if (PFN_UP(__pa(initrd_end)) >= max_low_pfn) {
 			printk("initrd extends beyond end of memory "
 			       "(0x%lx > 0x%p)\ndisabling initrd\n",
 			       initrd_end,
