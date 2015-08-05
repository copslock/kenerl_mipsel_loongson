From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 5 Aug 2015 16:41:37 +0100
Subject: MIPS: uaccess: Fix strlen_user with EVA
Message-ID: <20150805154137.nwPgwR0vcYhZKizTO04SH4S6BzF25xhuj4UYt628_IM@z>

commit 5dc62fdd8383afbd2faca6b6e6ea1052b45b0124 upstream.

The strlen_user() function calls __strlen_kernel_asm in both branches of
the eva_kernel_access() conditional. For EVA it should be calling
__strlen_user_eva for user accesses, otherwise it will load from the
kernel address space instead of the user address space, and the access
checking will likely be ineffective at preventing it due to EVA's
overlapping user and kernel address spaces.

This was found after extending the test_user_copy module to cover user
string access functions, which gave the following error with EVA:

test_user_copy: illegal strlen_user passed

Fortunately the use of strlen_user() has been all but eradicated from
the mainline kernel, so only out of tree modules could be affected.

Fixes: e3a9b07a9caf ("MIPS: asm: uaccess: Add EVA support for str*_user operations")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10842/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index bf8b324..2398046 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1355,7 +1355,7 @@ static inline long strlen_user(const char __user *s)
 		might_fault();
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
-			__MODULE_JAL(__strlen_kernel_asm)
+			__MODULE_JAL(__strlen_user_asm)
 			"move\t%0, $2"
 			: "=r" (res)
 			: "r" (s)
--
1.9.1
