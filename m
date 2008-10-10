Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2008 20:40:35 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36927 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21167543AbYJJTkd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Oct 2008 20:40:33 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48efaf9f0000>; Fri, 10 Oct 2008 15:40:15 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 12:40:14 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 12:40:14 -0700
Message-ID: <48EFAF9E.9010806@caviumnetworks.com>
Date:	Fri, 10 Oct 2008 12:40:14 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: [PATCH] MIPS: Add missing include in arch/mips/include/asm/ptrace.h.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2008 19:40:14.0522 (UTC) FILETIME=[041C89A0:01C92B10]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add missing include in arch/mips/include/asm/ptrace.h.

Recent reorganization seems to have lost this include.  You cannot
build without it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 arch/mips/include/asm/ptrace.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 7fe9812..36872b8 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -120,6 +120,8 @@ struct pt_watch_regs {
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
+#include <linux/sched.h>
+
 #include <asm/isadep.h>
 
 extern int ptrace_getregs(struct task_struct *child, __s64 __user *data);
