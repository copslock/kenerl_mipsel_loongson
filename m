From: Leif Lindholm <leif.lindholm@linaro.org>
Date: Mon, 26 May 2014 14:42:49 +0100
Subject: MIPS: DTS: Fix missing device_type="memory" property in memory nodes
Message-ID: <20140526134249.3Q4i2g53kh9woZZQu5dtAi5I8RjVZexpmxuYzaHK1Js@z>

commit 1d530fa42a317deca1c4a4780d18e2dbf316e0cb upstream.

A few platforms lack a 'device_type = "memory"' for their memory
nodes, relying on an old ppc quirk in order to discover its memory.
Add the missing data so that all parsing code can find memory nodes
correctly.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: gaurav.minocha@alumni.ubc.ca
Patchwork: https://patchwork.linux-mips.org/patch/6989/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ kamal: backport to 3.8-stable: only lantiq/dts/easy50712.dts ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/lantiq/dts/easy50712.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
index 68c1731..de53a1b 100644
--- a/arch/mips/lantiq/dts/easy50712.dts
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -8,6 +8,7 @@
 	};

 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};

--
1.9.1
