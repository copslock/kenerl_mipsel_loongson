Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:36:40 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:52570 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22852175AbYJaSTF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Oct 2008 18:19:05 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490b4c070001>; Fri, 31 Oct 2008 14:18:47 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 11:18:46 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 31 Oct 2008 11:18:46 -0700
Message-ID: <490B4C06.3050400@caviumnetworks.com>
Date:	Fri, 31 Oct 2008 11:18:46 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	"Malov, Vlad" <Vlad.Malov@caviumnetworks.com>
Subject: [PATCH] MIPS: Check the range of the syscall number for o32 syscall
 on 64bit kernel (v2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2008 18:18:46.0541 (UTC) FILETIME=[1D5293D0:01C93B85]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: Vlad Malov <Vlad.Malov@caviumnetworks.com>

On a 64 bit kernel if an o32 syscall was made with a syscall number
less than 4000, we would read the function from outside of the bounds
of the syscall table.  This led to non-deterministic behavior
including system crashes.

While we were at it we reworked the 32 bit version as well to use
fewer instructions.

This version two should address the concerns Maciej raised.  gas seems
to expand this instruction ordering with no nops in the delay slots.

Signed-off-by: Vlad Malov <Vlad.Malov@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/scall32-o32.S |    7 ++-----
 arch/mips/kernel/scall64-o32.S |   12 +++++-------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 759f680..4a77438 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -261,15 +261,12 @@ bad_alignment:
 
 	LEAF(sys_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
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
index 6c7ef83..d9299ae 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -174,14 +174,12 @@ not_o32_scall:
 	END(handle_sys)
 
 LEAF(sys32_syscall)
-	sltu	v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
+	subu	t0, a0, __NR_O32_Linux	# check syscall number
+	sltiu	v0, a0, __NR_O32_Linux + __NR_O32_Linux_syscalls + 1
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
