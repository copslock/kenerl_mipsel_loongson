Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f44CYaZ07636
	for linux-mips-outgoing; Fri, 4 May 2001 05:34:36 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f44CYYF07633
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 05:34:34 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6EAA27F9; Fri,  4 May 2001 14:34:32 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6D02AF38C; Fri,  4 May 2001 14:34:10 +0200 (CEST)
Date: Fri, 4 May 2001 14:34:10 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Patch tx3912 - inb/outb definition
Message-ID: <20010504143410.A10487@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hi,
there are incompatible definitions of inb/outb in the tx3912 header
which clash the io.h definitions


Index: include/asm-mips/tx3912.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/tx3912.h,v
retrieving revision 1.1
diff -u -r1.1 tx3912.h
--- include/asm-mips/tx3912.h	2001/04/01 03:28:23	1.1
+++ include/asm-mips/tx3912.h	2001/05/04 12:33:00
@@ -14,14 +14,6 @@
 
 #include <asm/addrspace.h>
 
-#define inb(addr)	(*(volatile unsigned char *)(addr))
-#define inw(addr)	(*(volatile unsigned short *)(addr))
-#define inl(addr)	(*(volatile unsigned int *)(addr))
-#define outb(b,addr)	(*(volatile unsigned char *)(addr)) = (b)
-#define outw(b,addr)	(*(volatile unsigned short *)(addr)) = (b)
-#define outl(b,addr)	(*(volatile unsigned int *)(addr)) = (b)
-
- 
 /******************************************************************************
 *
 * 	01  General macro definitions


So i guess this is correct

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
