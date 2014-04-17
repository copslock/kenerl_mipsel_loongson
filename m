From: Leif Lindholm <leif.lindholm@linaro.org>
Date: Thu, 17 Apr 2014 18:42:00 +0100
Subject: mips: dts: Fix missing device_type="memory" property in memory nodes
Message-ID: <20140417174200.Pv6sAO2Lf6OCdhOQVN44KUZSBPnJbbsNeCGl5ZrZCxY@z>

commit dfc44f8030653b345fc6fb337558c3a07536823f upstream.

A few platforms lack a 'device_type = "memory"' for their memory
nodes, relying on an old ppc quirk in order to discover its memory.
Add the missing data so that all parsing code can find memory nodes
correctly.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/lantiq/dts/easy50712.dts    | 1 +
 arch/mips/ralink/dts/mt7620a_eval.dts | 1 +
 arch/mips/ralink/dts/rt2880_eval.dts  | 1 +
 arch/mips/ralink/dts/rt3052_eval.dts  | 1 +
 arch/mips/ralink/dts/rt3883_eval.dts  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
index fac1f5b..143b8a3 100644
--- a/arch/mips/lantiq/dts/easy50712.dts
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -8,6 +8,7 @@
 	};

 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};

diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
index 35eb874..709f581 100644
--- a/arch/mips/ralink/dts/mt7620a_eval.dts
+++ b/arch/mips/ralink/dts/mt7620a_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink MT7620A evaluation board";

 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};

diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
index 322d700..0a685db 100644
--- a/arch/mips/ralink/dts/rt2880_eval.dts
+++ b/arch/mips/ralink/dts/rt2880_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT2880 evaluation board";

 	memory@0 {
+		device_type = "memory";
 		reg = <0x8000000 0x2000000>;
 	};

diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index 0ac73ea..ec9e9a0 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3052 evaluation board";

 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};

diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
index 2fa6b33..e8df21a 100644
--- a/arch/mips/ralink/dts/rt3883_eval.dts
+++ b/arch/mips/ralink/dts/rt3883_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3883 evaluation board";

 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};

--
1.9.1
