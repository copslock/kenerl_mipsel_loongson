From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 13 Aug 2015 08:47:59 +0100
Subject: MIPS: Fix seccomp syscall argument for MIPS64
Message-ID: <20150813074759.cnB3ZDIkI33GgTIZCjheQ6J-0zC2H6mQ52IMjOdeGYA@z>

commit 9f161439e4104b641a7bfb9b89581d801159fec8 upstream.

Commit 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
fixed indirect system calls on O32 but it also introduced a bug for MIPS64
where it erroneously modified the v0 (syscall) register with the assumption
that the sycall offset hasn't been taken into consideration. This breaks
seccomp on MIPS64 n64 and n32 ABIs. We fix this by replacing the addition
with a move instruction.

Fixes: 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls (o32)")
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10951/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/scall64-64.S  | 2 +-
 arch/mips/kernel/scall64-n32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index ad4d4463..a6f6b76 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -80,7 +80,7 @@ syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
-	daddiu	a1, v0, __NR_64_Linux
+	move	a1, v0
 	jal	syscall_trace_enter

 	bltz	v0, 2f			# seccomp failed? Skip syscall
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 446cc65..4b20106 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -72,7 +72,7 @@ n32_syscall_trace_entry:
 	SAVE_STATIC
 	move	s0, t2
 	move	a0, sp
-	daddiu	a1, v0, __NR_N32_Linux
+	move	a1, v0
 	jal	syscall_trace_enter

 	bltz	v0, 2f			# seccomp failed? Skip syscall
--
1.9.1
