From: Kevin D. Kissell <kevink@mips.com>
Date: Thu, 10 Apr 2008 02:07:38 +0200
Subject: [PATCH] Fixes necessary for non-SMP kernels and non-relocatable binaries
Message-ID: <20080410000738.dEM5WWGPRJFqjDuR6fNaG0TUxVui9W3yc6CPtQaEvLA@z>


Signed-off-by: Kevin D. Kissell <kevink@mips.com>
---
 arch/mips/kernel/vpe.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 95446fa..4515f1e 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -782,10 +782,15 @@ static int vpe_run(struct vpe * v)
 	/* take system out of configuration state */
 	clear_c0_mvpcontrol(MVPCONTROL_VPC);
 
+	/* 
+ 	 * SMTC/SMVP kernels manage VPE enable independently,
+ 	 * but uniprocessor kernels need to turn it on, even
+ 	 * if that wasn't the pre-dvpe() state.
+ 	 */
 #ifdef CONFIG_SMP
-	evpe(EVPE_ENABLE);
-#else
 	evpe(vpeflags);
+#else
+	evpe(EVPE_ENABLE);
 #endif
 	emt(dmt_flag);
 	local_irq_restore(flags);
@@ -948,12 +953,13 @@ static int vpe_elfload(struct vpe * v)
 		struct elf_phdr *phdr = (struct elf_phdr *) ((char *)hdr + hdr->e_phoff);
 
 		for (i = 0; i < hdr->e_phnum; i++) {
-			if (phdr->p_type != PT_LOAD)
-				continue;
-
-			memcpy((void *)phdr->p_paddr, (char *)hdr + phdr->p_offset, phdr->p_filesz);
-			memset((void *)phdr->p_paddr + phdr->p_filesz, 0, phdr->p_memsz - phdr->p_filesz);
-			phdr++;
+		    if (phdr->p_type == PT_LOAD) {
+			memcpy((void *)phdr->p_paddr, 
+				(char *)hdr + phdr->p_offset, phdr->p_filesz);
+			memset((void *)phdr->p_paddr + phdr->p_filesz, 
+				0, phdr->p_memsz - phdr->p_filesz);
+		    }
+		    phdr++;
 		}
 
 		for (i = 0; i < hdr->e_shnum; i++) {
-- 
1.5.3.3


--------------030103020306010003010808
Content-Type: text/x-patch;
 name="0002-Propagate-max_low_pfn-as-max_pfn-for-compatibility-w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Propagate-max_low_pfn-as-max_pfn-for-compatibility-w.pa";
 filename*1="tch"
