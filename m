Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 13:42:05 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:57984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900AbaFCLmCYrJNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jun 2014 13:42:02 +0200
Received: from bl15-147-49.dsl.telepac.pt ([188.80.147.49] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Wrn6P-00079s-Kb; Tue, 03 Jun 2014 11:42:01 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Leif Lindholm <leif.lindholm@linaro.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Grant Likely <grant.likely@linaro.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.11 088/138] mips: dts: Fix missing device_type="memory" property in memory nodes
Date:   Tue,  3 Jun 2014 12:38:54 +0100
Message-Id: <1401795584-22664-89-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1401795584-22664-1-git-send-email-luis.henriques@canonical.com>
References: <1401795584-22664-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.11
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

3.11.10.11 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leif Lindholm <leif.lindholm@linaro.org>

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/lantiq/dts/easy50712.dts    | 1 +
 arch/mips/ralink/dts/mt7620a_eval.dts | 1 +
 arch/mips/ralink/dts/rt2880_eval.dts  | 1 +
 arch/mips/ralink/dts/rt3052_eval.dts  | 1 +
 arch/mips/ralink/dts/rt3883_eval.dts  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
index fac1f5b178eb..143b8a37b5e4 100644
--- a/arch/mips/lantiq/dts/easy50712.dts
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -8,6 +8,7 @@
 	};
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
index 35eb874ab7f1..709f58132f5c 100644
--- a/arch/mips/ralink/dts/mt7620a_eval.dts
+++ b/arch/mips/ralink/dts/mt7620a_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink MT7620A evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
index 322d7002595b..0a685db093d4 100644
--- a/arch/mips/ralink/dts/rt2880_eval.dts
+++ b/arch/mips/ralink/dts/rt2880_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT2880 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x8000000 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
index 0ac73ea28198..ec9e9a035541 100644
--- a/arch/mips/ralink/dts/rt3052_eval.dts
+++ b/arch/mips/ralink/dts/rt3052_eval.dts
@@ -7,6 +7,7 @@
 	model = "Ralink RT3052 evaluation board";
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
index 2fa6b330bf4f..e8df21a5d10d 100644
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
