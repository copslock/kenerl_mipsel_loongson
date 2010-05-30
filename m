From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 19:49:32 +0200
Subject: [PATCH] mips: fix uninitialized warning when using get_user()
Message-ID: <20100530174932.ycTRoMxvCSwYPuHSObSoy3OmWyGd7uStDI_qu4esSuY@z>

Fix following type of warnings:
arch/mips/kernel/../../../fs/binfmt_elf.c: In function 'vma_dump_size'
arch/mips/kernel/../../../fs/binfmt_elf.c:1139:
warning: word may be used uninitialized in this function

The warning was tracked down to the implementation of the get_user()
macro in uaccess.h.
Other architectures assign the supplied variable to 0 if
access check fails - do the same for mips.

This patch intentionally do the minimal fix as the configuration
I used (bigsur_defconfig) did not produce warnings from
the other get_user() variants.

This fixes bigsur_defconfig build that other
failed due to -Werror.

The warnings was triggered with gcc 4.1.2

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Well - I complained so I took a closer look.
This seems to be the correct fix.

I have only build tested this patch.
As the box I sit on is rather slow I do not have
before/after number for vmlinux size - sorry!

	Sam

 arch/mips/include/asm/uaccess.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index c2d53c1..1cd4bb6 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -248,6 +248,8 @@ do {									\
 	might_fault();							\
 	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size)))		\
 		__get_user_common((x), size, __gu_ptr);			\
+	else								\
+		(x) = 0;						\
 									\
 	__gu_err;							\
 })
-- 
1.6.0.6
