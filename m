Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2004 16:04:49 +0100 (BST)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:32911 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225268AbUGEPEo>; Mon, 5 Jul 2004 16:04:44 +0100
Received: (qmail 2493 invoked from network); 5 Jul 2004 14:59:57 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.227)
  by mail.dev.rtsoft.ru with SMTP; 5 Jul 2004 14:59:57 -0000
Message-ID: <40E96E2A.2000403@dev.rtsoft.ru>
Date: Mon, 05 Jul 2004 19:05:14 +0400
From: Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.6) Gecko/20040113
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: linux-mips@ftp.linux-mips.org
Subject: LO reg. gets trashed by kgdb in 2.4.x and older kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 5400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hi.

     I have discovered that the gdb-low.S trashes the LO reg. instead of 
restoring it. This was fixed for the 2.6 kernels but, as it seems, was left 
unfixed in the earlier ones (run into this on 2.4.18/2.4.20). Here's the patch
against the lastest 2.4.x revision of the file...

Index: linux/arch/mips/kernel/gdb-low.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/gdb-low.S,v
retrieving revision 1.11.2.3
diff -a -u -r1.11.2.3 gdb-low.S
--- linux/arch/mips/kernel/gdb-low.S	20 Feb 2003 18:19:01 -0000	1.11.2.3
+++ linux/arch/mips/kernel/gdb-low.S	5 Jul 2004 14:48:08 -0000
@@ -283,7 +283,7 @@
  		lw	v0,GDB_FR_HI(sp)
  		lw	v1,GDB_FR_LO(sp)
  		mthi	v0
-		mtlo	v0
+		mtlo	v1
  		lw	ra,GDB_FR_REG31(sp)
  		lw	fp,GDB_FR_REG30(sp)
  		lw	gp,GDB_FR_REG28(sp)
