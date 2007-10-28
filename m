Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 06:11:10 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:33234 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20021892AbXJ1GLC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 06:11:02 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 1683330F1A0
	for <linux-mips@linux-mips.org>; Sun, 28 Oct 2007 06:10:27 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Sun, 28 Oct 2007 06:10:26 +0000 (UTC)
Received: from [192.168.7.221] ([192.168.7.221]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 27 Oct 2007 23:10:21 -0700
Message-ID: <472427CC.4000406@avtrex.com>
Date:	Sat, 27 Oct 2007 23:10:20 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Add len and addr validation for MAP_FIXED mappings.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2007 06:10:21.0477 (UTC) FILETIME=[38A54D50:01C81929]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

From: David Daney  <ddaney@avtrex.com>

mmap with MAP_FIXED was not validating the addr and len parameters.
This leads to the failure of GCC's gcc.c-torture/execute/loop-2[fg].c
testcases when using the o32 ABI on a 64 bit kernel.

These testcases try to mmap 65536 bytes at 0x7fff8000 and then access
all the memory.  In 2.6.18 and 2.6.23.1 (and likely other versions as
well) the kernel maps the requested memory, but since half of it is
above 0x80000000 a SIGBUS is generated when it is accessed.

This patch moves the len validation above the MAP_FIXED processing so
that it is always validated.  It also adds validation to the addr
parameter for MAP_FIXED mappings.

The patch is against 2.6.23.1 from kernel.org and was tested in a 64
bit big-endian kernel.

Signed-off-by: David Daney  <ddaney@avtrex.com>
---
--- ../linux-2.6.23.1-clean/arch/mips/kernel/syscall.c	2007-10-12 09:43:44.000000000 -0700
+++ arch/mips/kernel/syscall.c	2007-10-25 23:10:23.000000000 -0700
@@ -73,7 +73,14 @@ unsigned long arch_get_unmapped_area(str
 
 	task_size = STACK_TOP;
 
+	if (len > task_size)
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
+		/* Even MAP_FIXED mappings must reside within task_size.  */
+		if (task_size - len < addr)
+			return -EINVAL;
+
 		/*
 		 * We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -83,8 +90,6 @@ unsigned long arch_get_unmapped_area(str
 		return addr;
 	}
 
-	if (len > task_size)
-		return -ENOMEM;
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align = 1;
