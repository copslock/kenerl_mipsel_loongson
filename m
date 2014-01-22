From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 22 Jan 2014 14:40:00 +0000
Subject: MIPS: asm: thread_info: Add _TIF_SECCOMP flag
Message-ID: <20140122144000.543Aa0pIXVmcnp_VQ_yPXJlAns6etctNANP1OHCH2kM@z>

commit 137f7df8cead00688524c82360930845396b8a21 upstream.

Add _TIF_SECCOMP flag to _TIF_WORK_SYSCALL_ENTRY to indicate
that the system call needs to be checked against a seccomp filter.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/6405/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
[ luis: backported to 3.11: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 61215a34acc6..897cd58407c8 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -134,7 +134,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)

 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
-				 _TIF_SYSCALL_AUDIT)
+				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)

 /* work to do in syscall_trace_leave() */
 #define _TIF_WORK_SYSCALL_EXIT	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
--
1.9.1
