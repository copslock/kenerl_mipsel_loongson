Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASINIJ31925
	for linux-mips-outgoing; Wed, 28 Nov 2001 10:23:18 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASINEo31921;
	Wed, 28 Nov 2001 10:23:14 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fASHNBh7012957;
	Wed, 28 Nov 2001 09:23:11 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fASHNAU2012953;
	Wed, 28 Nov 2001 09:23:10 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 28 Nov 2001 09:23:10 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] const mips_io_port_base !?
In-Reply-To: <20011128091655.A20264@lucon.org>
Message-ID: <Pine.LNX.4.10.10111280921550.11130-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ralph please apply this patch to arch/mips/kernel/setup.c. Some compilers
don't like the conflict of definition in io.h and setup.c. Thanks.
 
--- setup.c.orig	Wed Nov 28 10:19:09 2001
+++ setup.c	Wed Nov 28 10:19:20 2001
@@ -106,7 +106,7 @@
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
  */
-unsigned long mips_io_port_base;	EXPORT_SYMBOL(mips_io_port_base);
+const unsigned long mips_io_port_base;	EXPORT_SYMBOL(mips_io_port_base);
 
 
 /*
