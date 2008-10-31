Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:32:40 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14688 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22852392AbYJaSXV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 18:23:21 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490b4d0f0000>; Fri, 31 Oct 2008 14:23:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 11:23:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 11:23:10 -0700
Message-ID: <490B4D0D.9060305@caviumnetworks.com>
Date:	Fri, 31 Oct 2008 11:23:09 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Return ENOSYS from sys32_syscall on 64bit kernels just
 like everywhere else.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2008 18:23:10.0086 (UTC) FILETIME=[BA685A60:01C93B85]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips


When the o32 errno was changed to ENOSYS, we forgot to update the code
for 64bit kernels.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall64-o32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index d9299ae..e35e872 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -196,7 +196,7 @@ LEAF(sys32_syscall)
 	jr	t2
 	/* Unreached */
 
-einval:	li	v0, -EINVAL
+einval:	li	v0, -ENOSYS
 	jr	ra
 	END(sys32_syscall)
 
