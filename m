From: David Daney <david.daney@cavium.com>
Date: Mon, 27 Feb 2017 14:14:30 -0800
Subject: [PATCH] MIPS: jump_lable: Give __jump_table elements an entsize.
Message-ID: <20170227221430.A0a4ErIf_sXRRFOCoKSmJa9r5bp1_vVo7MrZzR34egQ@z>

Since the __jump_table is a big array of non power-of-2 sized
elements, tell the linker the size so they can be properly packed.
Since each element will have unique "code" and "key" fields, no
merging will ever occur, but it should end up properly packed.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/jump_label.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index e776725..c9a695f 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -26,14 +26,26 @@
 #define NOP_INSN "nop"
 #endif
 
+#ifdef CONFIG_64BIT
+typedef u64 jump_label_t;
+#else
+typedef u32 jump_label_t;
+#endif
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
 		"nop\n\t"
-		".pushsection __jump_table,  \"aw\"\n\t"
+		".pushsection __jump_table, \"awM\",@progbits, %1\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
-		: :  "i" (&((char *)key)[branch]) : : l_yes);
+		: :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)): : l_yes);
 
 	return false;
 l_yes:
@@ -44,27 +56,15 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\tj %l[l_yes]\n\t"
 		"nop\n\t"
-		".pushsection __jump_table,  \"aw\"\n\t"
+		".pushsection __jump_table, \"awM\"@progbits, %1\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
-		: :  "i" (&((char *)key)[branch]) : : l_yes);
+		: :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)) : : l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
-#ifdef CONFIG_64BIT
-typedef u64 jump_label_t;
-#else
-typedef u32 jump_label_t;
-#endif
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif /* _ASM_MIPS_JUMP_LABEL_H */
-- 
2.9.3


--------------D566EBDEDAFBEDE0F1C637BC--
