Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g79CmkRw005678
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 05:48:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g79Cmjim005677
	for linux-mips-outgoing; Fri, 9 Aug 2002 05:48:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.gmx.net (sproxy.gmx.net [213.165.64.20])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g79CmdRw005668
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 05:48:40 -0700
Received: (qmail 31585 invoked by uid 0); 9 Aug 2002 12:50:43 -0000
Received: from unknown (HELO bogon.ms20.nix) (134.34.147.122)
  by mail.gmx.net (mp019-rz3) with SMTP; 9 Aug 2002 12:50:43 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 02466364F7; Fri,  9 Aug 2002 14:47:45 +0200 (CEST)
Date: Fri, 9 Aug 2002 14:47:45 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: ip22 build fix
Message-ID: <20020809124745.GA32507@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, 
I need the attached patch against arch/mips/arc/Makefile to
get current CVS (linux_2_4) to build on IP22. Otherwise prom_meminit
is undefined. Please apply.

Index: arch/mips/arc/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/arc/Makefile,v
retrieving revision 1.5.2.1
diff -u -u -r1.5.2.1 Makefile
--- arch/mips/arc/Makefile	2002/08/01 22:26:40	1.5.2.1
+++ arch/mips/arc/Makefile	2002/08/09 12:44:57
@@ -4,7 +4,7 @@
 
 L_TARGET = arclib.a
 
-obj-y				+= cmdline.o console.o env.o file.o \
+obj-y				+= cmdline.o console.o env.o file.o memory.o \
 				   identify.o init.o misc.o time.o tree.o
 
 obj-$(CONFIG_ARC_MEMORY)	+= memory.o

Regards,
 -- Guido
