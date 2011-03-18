From: Heiher <admin@heiher.info>
Date: Fri, 18 Mar 2011 12:51:08 +0800
Subject: [PATCH] Fixup personality in different ABI.
Message-ID: <20110318045108.QwTfWIdki6ftnmPHUA_kffPbS2UpvUyHy1sowpFsHFs@z>

* 'arch' output:
	o32 : mips
	n32 : mips64
	64  : mips64
---
 arch/mips/include/asm/elf.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 455c0ac..01510d4 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -262,6 +262,7 @@ do {									\
 #ifdef CONFIG_MIPS32_N32
 #define __SET_PERSONALITY32_N32()					\
 	do {								\
+		set_personality(PER_LINUX);				\
 		set_thread_flag(TIF_32BIT_ADDR);			\
 		current->thread.abi = &mips_abi_n32;			\
 	} while (0)
@@ -273,6 +274,7 @@ do {									\
 #ifdef CONFIG_MIPS32_O32
 #define __SET_PERSONALITY32_O32()					\
 	do {								\
+		set_personality(PER_LINUX32);			\
 		set_thread_flag(TIF_32BIT_REGS);			\
 		set_thread_flag(TIF_32BIT_ADDR);			\
 		current->thread.abi = &mips_abi_32;			\
@@ -305,7 +307,10 @@ do {									\
 	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)			\
 		__SET_PERSONALITY32(ex);				\
 	else								\
+	{								\
+		set_personality(PER_LINUX);				\
 		current->thread.abi = &mips_abi;			\
+	}								\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
-- 
1.7.4.1.225.g83c3c

-- 
Best regards!
Heiher
