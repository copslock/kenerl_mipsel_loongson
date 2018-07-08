From: Paul Cercueil <paul@crapouillou.net>
Date: Sun, 8 Jul 2018 17:07:12 +0200
Subject: MIPS: jz4740: Bump zload address
Message-ID: <20180708150712.g7jKcGrpE1d4wOciC4kJXzqImSmKe5pDNTyCfx1JFDs@z>

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit c6ea7e9747318e5a6774995f4f8e3e0f7c0fa8ba ]

Having the zload address at 0x8060.0000 means the size of the
uncompressed kernel cannot be bigger than around 6 MiB, as it is
deflated at address 0x8001.0000.

This limit is too small; a kernel with some built-in drivers and things
like debugfs enabled will already be over 6 MiB in size, and so will
fail to extract properly.

To fix this, we bump the zload address from 0x8060.0000 to 0x8100.0000.

This is fine, as all the boards featuring Ingenic JZ SoCs have at least
32 MiB of RAM, and use u-boot or compatible bootloaders which won't
hardcode the load address but read it from the uImage's header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19787/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/jz4740/Platform |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,4 +1,4 @@
 platform-$(CONFIG_MACH_INGENIC)	+= jz4740/
 cflags-$(CONFIG_MACH_INGENIC)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4740
 load-$(CONFIG_MACH_INGENIC)	+= 0xffffffff80010000
-zload-$(CONFIG_MACH_INGENIC)	+= 0xffffffff80600000
+zload-$(CONFIG_MACH_INGENIC)	+= 0xffffffff81000000


Patches currently in stable-queue which might be from paul@crapouillou.net are

queue-4.18/mips-jz4740-bump-zload-address.patch
