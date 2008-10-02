Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2008 18:42:45 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:60697 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20377540AbYJBRmm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Oct 2008 18:42:42 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48e507ff0000>; Thu, 02 Oct 2008 13:42:23 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 10:41:28 -0700
Received: from localhost.localdomain ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 10:41:28 -0700
Message-ID: <48E507C8.30402@caviumnetworks.com>
Date:	Thu, 02 Oct 2008 10:41:28 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Bogus code in linux-queue commit 381ef5828990102b098aeb0a1f6958efd2e99733
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2008 17:41:28.0571 (UTC) FILETIME=[1968B4B0:01C924B6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf,

When you committed this patch to linux-queue:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=48D8969E.6060501%40avtrex.com

Some 'extra' code got added with it.  This is code that I didn't write 
and furthermore it contains a typo.

----------------
+#include <linux/copiler.h>
 #include <linux/linkage.h>
 #include <asm/isadep.h>
 
+extern int ptrace_get_watch_regs(struct task_struct *child,
+       struct pt_watch_regs __user *addr);
+extern int ptrace_set_watch_regs(struct task_struct *child,
+       struct pt_watch_regs __user *addr);
+
----------------

Note that it should read <linux/compiler.h> not <linux/copiler.h>.

Is there some way to fix this?

David Daney.
