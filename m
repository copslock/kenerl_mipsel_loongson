From: Matt Redfearn <matt.redfearn@mips.com>
Date: Mon, 29 Jan 2018 11:26:45 +0000
Subject: MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS
Message-ID: <20180129112645.q4SlvmYRPJrKuctnf0edgd6PwWxikoPDvxmVTNngmF8@z>

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 0cde5b44a30f1daaef1c34e08191239dc63271c4 ]

When commit b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
added board support for the RBTX4939, it added a call to
led_classdev_register even if the LED class is built as a module.
Built-in arch code cannot call module code directly like this. Commit
b33b44073734 ("MIPS: TXX9: use IS_ENABLED() macro") subsequently
changed the inclusion of this code to a single check that
CONFIG_LEDS_CLASS is either builtin or a module, but the same issue
remains.

This leads to MIPS allmodconfig builds failing when CONFIG_MACH_TX49XX=y
is set:

arch/mips/txx9/rbtx4939/setup.o: In function `rbtx4939_led_probe':
setup.c:(.init.text+0xc0): undefined reference to `of_led_classdev_register'
make: *** [Makefile:999: vmlinux] Error 1

Fix this by using the IS_BUILTIN() macro instead.

Fixes: b27311e1cace ("MIPS: TXx9: Add RBTX4939 board support")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18544/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/txx9/rbtx4939/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -186,7 +186,7 @@ static void __init rbtx4939_update_ioc_p
 
 #define RBTX4939_MAX_7SEGLEDS	8
 
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -261,7 +261,7 @@ static inline void rbtx4939_led_setup(vo
 
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if IS_ENABLED(CONFIG_LEDS_CLASS)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */


Patches currently in stable-queue which might be from matt.redfearn@mips.com are

queue-4.4/mips-txx9-use-is_builtin-for-config_leds_class.patch
