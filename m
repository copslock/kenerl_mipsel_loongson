Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2003 16:28:16 +0100 (BST)
Received: from bristol.phunnypharm.org ([IPv6:::ffff:65.207.35.130]:8101 "EHLO
	bristol.phunnypharm.org") by linux-mips.org with ESMTP
	id <S8225192AbTEZP2N>; Mon, 26 May 2003 16:28:13 +0100
Received: from hopper.phunnypharm.org ([65.207.35.143] ident=mail)
	by bristol.phunnypharm.org with esmtp (Exim 3.36 #1 (Debian))
	id 19KJtH-0000iC-00; Mon, 26 May 2003 11:27:59 -0400
Received: from bmc by hopper.phunnypharm.org with local (Exim 3.36 #1 (Debian))
	id 19KJ6p-0003yT-00; Mon, 26 May 2003 10:37:55 -0400
Date: Mon, 26 May 2003 10:37:55 -0400
From: Ben Collins <bcollins@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] Fix thinko in mips/mips64 sys_sysmips
Message-ID: <20030526143755.GT2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <bmc@phunnypharm.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bcollins@debian.org
Precedence: bulk
X-list: linux-mips

This has already been fixed in Linus' tree. Here's hoping it gets into
2.4 sometime soon. Note in the patch that "node" is the userspace
pointer and "nodename" is the string where "node" was
strncpy_from_user()'d to.

So it really should be using "nodename".



Index: linux-2.4/arch/mips64/kernel/syscall.c
===================================================================
--- linux-2.4/arch/mips64/kernel/syscall.c	(revision 3226)
+++ linux-2.4/arch/mips64/kernel/syscall.c	(working copy)
@@ -207,7 +207,7 @@
 			return -EFAULT;
 
 		down_write(&uts_sem);
-		strncpy(system_utsname.nodename, name, len);
+		strncpy(system_utsname.nodename, nodename, len);
 		system_utsname.nodename[len] = '\0';
 		up_write(&uts_sem);
 		return 0;
Index: linux-2.4/arch/mips/kernel/sysmips.c
===================================================================
--- linux-2.4/arch/mips/kernel/sysmips.c	(revision 3226)
+++ linux-2.4/arch/mips/kernel/sysmips.c	(working copy)
@@ -65,7 +65,7 @@
 			return -EFAULT;
 
 		down_write(&uts_sem);
-		strncpy(system_utsname.nodename, name, len);
+		strncpy(system_utsname.nodename, nodename, len);
 		system_utsname.nodename[len] = '\0';
 		up_write(&uts_sem);
 		return 0;
