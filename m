From: Paul Burton <paul.burton@imgtec.com>
Date: Tue, 28 Oct 2014 11:25:51 +0000
Subject: MIPS: fix EVA & non-SMP non-FPU FP context signal handling
Message-ID: <20141028112551.V2QEbODF5nLLBo4oCeUdZW5pAVrIv02ymD_a-u6atCQ@z>

commit 14fa12df1d6bc1d3389a0fa842e0ebd8e8a9af26 upstream.

The save_fp_context & restore_fp_context pointers were being assigned
to the wrong variables if either:

  - The kernel is configured for UP & runs on a system without an FPU,
    since b2ead5282885 "MIPS: Move & rename
    fpu_emulator_{save,restore}_context".

  - The kernel is configured for EVA, since ca750649e08c "MIPS: kernel:
    signal: Prevent save/restore FPU context in user memory".

This would lead to FP context being clobbered incorrectly when setting
up a sigcontext, then the garbage values being saved uselessly when
returning from the signal.

Fix by swapping the pointer assignments appropriately.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8230/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9e60d117e41e..394e2b12a3ba 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -676,13 +676,13 @@ static int signal_setup(void)
 		save_fp_context = _save_fp_context;
 		restore_fp_context = _restore_fp_context;
 	} else {
-		save_fp_context = copy_fp_from_sigcontext;
-		restore_fp_context = copy_fp_to_sigcontext;
+		save_fp_context = copy_fp_to_sigcontext;
+		restore_fp_context = copy_fp_from_sigcontext;
 	}
 #endif /* CONFIG_SMP */
 #else
-	save_fp_context = copy_fp_from_sigcontext;;
-	restore_fp_context = copy_fp_to_sigcontext;
+	save_fp_context = copy_fp_to_sigcontext;
+	restore_fp_context = copy_fp_from_sigcontext;
 #endif

 	return 0;
