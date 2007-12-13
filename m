Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 01:56:13 +0000 (GMT)
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:52797 "EHLO
	outbound5-va3-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S28576040AbXLNB4D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 01:56:03 +0000
Received: from outbound5-va3.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-va3-R.bigfish.com (Postfix) with ESMTP id D7AB4B0C4F7;
	Fri, 14 Dec 2007 01:54:56 +0000 (UTC)
Received: from mail140-va3-R.bigfish.com (si1-va3 [10.7.14.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound5-va3.bigfish.com (Postfix) with ESMTP id D678F199006E;
	Fri, 14 Dec 2007 01:54:56 +0000 (UTC)
Received: from mail140-va3 (localhost.localdomain [127.0.0.1])
	by mail140-va3-R.bigfish.com (Postfix) with ESMTP id 88FEB19500B5;
	Fri, 14 Dec 2007 01:54:56 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.66.75;Service: EHS
Received: by mail140-va3 (MessageSwitch) id 1197597296545852_2446; Fri, 14 Dec 2007 01:54:56 +0000 (UCT)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail140-va3.bigfish.com (Postfix) with ESMTP id 3209B7E8078;
	Fri, 14 Dec 2007 01:54:56 +0000 (UTC)
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id lBE1stMI016051;
	Fri, 14 Dec 2007 01:54:55 GMT
Received: from USSDIXIM02.am.sony.com (ussdixim02.am.sony.com [43.130.140.34])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id lBE1ss4S029579;
	Fri, 14 Dec 2007 01:54:54 GMT
Received: from ussdixms03.am.sony.com ([43.130.140.23]) by USSDIXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 13 Dec 2007 17:54:54 -0800
Received: from [43.135.148.200] ([43.135.148.200]) by ussdixms03.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 13 Dec 2007 17:54:53 -0800
Subject: [PATCH][MIPS] kernel build fails if CONFIG_KGDB=y and CONFIG_SMP=n
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 13 Dec 2007 17:57:57 -0500
Message-Id: <1197586677.4660.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2007 01:54:53.0994 (UTC) FILETIME=[522B40A0:01C83DF4]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips


The kernel build fails if CONFIG_KGDB=y and CONFIG_SMP=n.

kgdb_wait() is defined but unused, resulting in a warning.
The warning is converted to an error by the
"EXTRA_CFLAGS += -Werror" in arch/mips/kernel/Makefile.


Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>


---
 arch/mips/kernel/gdb-stub.c |    2 	2 +	0 -	0 !
 1 files changed, 2 insertions(+)

Index: linux-2.6.24-rc4/arch/mips/kernel/gdb-stub.c
===================================================================
--- linux-2.6.24-rc4.orig/arch/mips/kernel/gdb-stub.c
+++ linux-2.6.24-rc4/arch/mips/kernel/gdb-stub.c
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
