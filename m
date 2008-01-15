Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 22:38:19 +0000 (GMT)
Received: from mail-dub.bigfish.com ([213.199.154.10]:5586 "EHLO
	mail186-dub-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20039352AbYAOWiJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 22:38:09 +0000
Received: from mail186-dub (localhost.localdomain [127.0.0.1])
	by mail186-dub-R.bigfish.com (Postfix) with ESMTP id BCF7E1410DEF;
	Tue, 15 Jan 2008 22:33:43 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.66.75;Service: EHS
Received: by mail186-dub (MessageSwitch) id 1200436422729288_2821; Tue, 15 Jan 2008 22:33:42 +0000 (UCT)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	by mail186-dub.bigfish.com (Postfix) with ESMTP id 9FC3B5F808D;
	Tue, 15 Jan 2008 22:33:38 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id m0FMXXMl027532;
	Tue, 15 Jan 2008 22:33:33 GMT
Received: from USBMAXIM01.am.sony.com (us-east-xims.am.sony.com [43.145.108.25])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0FMXWqn006068;
	Tue, 15 Jan 2008 22:33:32 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM01.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 15 Jan 2008 17:33:32 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 17:33:32 -0500
Subject: [PATCH 2/4] kgdb on not SMP
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <1200436139.4092.30.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
Content-Type: text/plain
Date:	Tue, 15 Jan 2008 14:32:32 -0800
Message-Id: <1200436352.4092.36.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 22:33:32.0457 (UTC) FILETIME=[A8A4C190:01C857C6]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

From: Frank Rowand <frank.rowand@am.sony.com>

Fix gdb-stub.c compile warning for non-SMP systems (which becomes compile
error due to -Werror).

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/mips/kernel/gdb-stub.c |    2 	2 +	0 -	0 !
 1 files changed, 2 insertions(+)

Index: linux-2.6.24-rc5/arch/mips/kernel/gdb-stub.c
===================================================================
--- linux-2.6.24-rc5.orig/arch/mips/kernel/gdb-stub.c
+++ linux-2.6.24-rc5/arch/mips/kernel/gdb-stub.c
@@ -656,6 +656,7 @@ void set_async_breakpoint(unsigned long 
 	*epc = (unsigned long)async_breakpoint;
 }
 
+#ifdef CONFIG_SMP
 static void kgdb_wait(void *arg)
 {
 	unsigned flags;
@@ -668,6 +669,7 @@ static void kgdb_wait(void *arg)
 
 	local_irq_restore(flags);
 }
+#endif
 
 /*
  * GDB stub needs to call kgdb_wait on all processor with interrupts
