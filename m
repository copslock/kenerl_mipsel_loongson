From: Manuel Lauss <manuel.lauss@gmail.com>
Date: Wed, 18 Feb 2015 11:01:56 +0100
Subject: MIPS: Alchemy: Fix cpu clock calculation
Message-ID: <20150218100156.ClWMxwLd7er6HzJhp_SFi-Q9AJ6PaQvJD_Ldiit4TBg@z>

From: Manuel Lauss <manuel.lauss@gmail.com>

commit 69e4e63ec816a7e22cc3aa14bc7ef4ac734d370c upstream.

The current code uses bits 0-6 of the sys_cpupll register to calculate
core clock speed.  However this is only valid on Au1300, on all earlier
models the hardware only uses bits 0-5 to generate core clock.

This fixes clock calculation on the MTX1 (Au1500), where bit 6 of cpupll
is set as well, which ultimately lead the code to calculate a bogus cpu
core clock and also uart base clock down the line.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Reported-by: John Crispin <blogic@openwrt.org>
Tested-by: Bruno Randolf <br1@einfach.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/9279/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/alchemy/common/clock.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -127,6 +127,8 @@ static unsigned long alchemy_clk_cpu_rec
 		t = 396000000;
 	else {
 		t = alchemy_rdsys(AU1000_SYS_CPUPLL) & 0x7f;
+		if (alchemy_get_cputype() < ALCHEMY_CPU_AU1300)
+			t &= 0x3f;
 		t *= parent_rate;
 	}
 


Patches currently in stable-queue which might be from manuel.lauss@gmail.com are

queue-3.19/mips-alchemy-fix-cpu-clock-calculation.patch
