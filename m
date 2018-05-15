From: "Maciej W. Rozycki" <macro@mips.com>
Date: Tue, 15 May 2018 23:32:45 +0100
Subject: binfmt_elf: Respect error return from `regset->active'
Message-ID: <20180515223245.97kQgWr5JYJsldI56DxZu_NtAyQEDUGu-S_MSDibcSk@z>

From: "Maciej W. Rozycki" <macro@mips.com>

[ Upstream commit 2f819db565e82e5f73cd42b39925098986693378 ]

The regset API documented in <linux/regset.h> defines -ENODEV as the
result of the `->active' handler to be used where the feature requested
is not available on the hardware found.  However code handling core file
note generation in `fill_thread_core_info' interpretes any non-zero
result from the `->active' handler as the regset requested being active.
Consequently processing continues (and hopefully gracefully fails later
on) rather than being abandoned right away for the regset requested.

Fix the problem then by making the code proceed only if a positive
result is returned from the `->active' handler.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 4206d3aa1978 ("elf core dump: notes user_regset")
Patchwork: https://patchwork.linux-mips.org/patch/19332/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1751,7 +1751,7 @@ static int fill_thread_core_info(struct
 		const struct user_regset *regset = &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset_size(t->task, regset);
 			void *data = kmalloc(size, GFP_KERNEL);


Patches currently in stable-queue which might be from macro@mips.com are

queue-4.18/binfmt_elf-respect-error-return-from-regset-active.patch
