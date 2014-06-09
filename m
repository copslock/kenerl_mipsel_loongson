Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2014 10:51:33 +0200 (CEST)
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:35551 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819313AbaFIIv3dbUWU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2014 10:51:29 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
        (envelope-from <jslaby@suse.cz>)
        id 1WtvIX-0007be-Qt; Mon, 09 Jun 2014 10:51:21 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Leif Lindholm <leif.lindholm@linaro.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Grant Likely <grant.likely@linaro.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 013/146] mips: dts: Fix missing device_type="memory" property in memory nodes
Date:   Mon,  9 Jun 2014 10:49:08 +0200
Message-Id: <923aef0f16d9930bb275aa2fdbffdc732411ed2b.1402303820.git.jslaby@suse.cz>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <ebe219e45dcf94c1a34281167427cff4d742faef.1402303820.git.jslaby@suse.cz>
References: <ebe219e45dcf94c1a34281167427cff4d742faef.1402303820.git.jslaby@suse.cz>
In-Reply-To: <cover.1402303820.git.jslaby@suse.cz>
References: <cover.1402303820.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Leif Lindholm <leif.lindholm@linaro.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
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
1.9.3
