From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 12 Apr 2018 22:30:44 -0400
Subject: MIPS: io: Add barrier after register read in readX()
Message-ID: <20180413023044.jves3D_HwVK595AoPZdWto61VB3-gXyI0CKYnw0tFmc@z>

From: Sinan Kaya <okaya@codeaurora.org>

[ Upstream commit a1cc7034e33d12dc17d13fbcd7d597d552889097 ]

While a barrier is present in the writeX() functions before the register
write, a similar barrier is missing in the readX() functions after the
register read. This could allow memory accesses following readX() to
observe stale data.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/19069/
[jhogan@kernel.org: Tidy commit message]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/io.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,8 @@ static inline type pfx##read##bwlq(const
 		BUG();							\
 	}								\
 									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 


Patches currently in stable-queue which might be from okaya@codeaurora.org are

queue-4.14/mips-io-add-barrier-after-register-read-in-readx.patch
queue-4.14/mips-io-prevent-compiler-reordering-writex.patch
