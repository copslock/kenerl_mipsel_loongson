Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 23:06:05 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:38534 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754840AbYKRXF4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 23:05:56 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49234a4e0000>; Tue, 18 Nov 2008 18:05:50 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 15:05:46 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 15:05:46 -0800
Message-ID: <49234A4A.2090707@caviumnetworks.com>
Date:	Tue, 18 Nov 2008 15:05:46 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	"Malov, Vlad" <Vlad.Malov@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix potential DOS by untrusted user app.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2008 23:05:46.0585 (UTC) FILETIME=[30B44490:01C949D2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: Vlad Malov <Vlad.Malov@caviumnetworks.com>

Fix potential DOS by untrusted user app.

Version 3: Fix stupid typo I introduced.  This version has received
extensive testing with the LTP where it fixes kernel crashes.

On a 64 bit kernel if an o32 syscall was made with a syscall number
less than 4000, we would read the function from outside of the bounds
of the syscall table.  This led to non-deterministic behavior
including system crashes.

While we were at it we reworked the 32 bit version as well to use
fewer instructions.  Both 32 and 64 bit versions are use the same code
now.

This version two should address the concerns Maciej raised.  gas seems
to expand this instruction ordering with no nops in the delay slots.

Signed-off-by: Vlad Malov <Vlad.Malov@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall32-o32.S |    5 +----
 arch/mips/kernel/scall64-o32.S |   12 +++++-------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 759f680..34a4dbd 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -262,14 +262,11 @@ bad_alignment:
 	LEAF(sys_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
 	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	beqz	t0, einval		# do not recurse
 	sll	t1, t0, 3
 	beqz	v0, einval
-
 	lw	t2, sys_call_table(t1)		# syscall routine
 
-	li	v1, 4000 - __NR_O32_Linux	# index of sys_syscall
-	beq	t0, v1, einval			# do not recurse
-
 	/* Some syscalls like execve get their arguments from struct pt_regs
 	   and claim zero arguments in the syscall table. Thus we have to
 	   assume the worst case and shuffle around all potential arguments.
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 6c7ef83..facb41a 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -174,14 +174,12 @@ not_o32_scall:
 	END(handle_sys)
 
 LEAF(sys32_syscall)
-	sltu	v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
+	subu	t0, a0, __NR_O32_Linux	# check syscall number
+	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	beqz	t0, einval		# do not recurse
+	dsll	t1, t0, 3
 	beqz	v0, einval
-
-	dsll	v0, a0, 3
-	ld	t2, (sys_call_table - (__NR_O32_Linux * 8))(v0)
-
-	li	v1, 4000		# indirect syscall number
-	beq	a0, v1, einval		# do not recurse
+	ld	t2, sys_call_table(t1)		# syscall routine
 
 	move	a0, a1			# shift argument registers
 	move	a1, a2
