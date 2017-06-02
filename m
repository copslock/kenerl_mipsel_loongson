Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:31:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26159 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFBTbRM4Srn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:31:17 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1FF10919916DF;
        Fri,  2 Jun 2017 20:31:07 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:31:10
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/9] MIPS: generic/yamon-dt: Use serial* rather than uart* aliases
Date:   Fri, 2 Jun 2017 12:29:53 -0700
Message-ID: <20170602192959.25435-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Name aliases in the SEAD-3 device tree serial0 & serial1, rather than
uart0 & uart1. This allows the core serial code to make use of the
aliases to ensure that the UARTs are consistently numbered as expected
rather than having the numbering depend upon probe order.

When translating YAMON-provided serial configuration to a device tree
stdout-path property adjust accordingly, such that we continue to
reference a valid alias.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/boot/dts/mti/sead3.dts | 6 +++---
 arch/mips/generic/yamon-dt.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index b112879a5d9d..c1dbf16708bd 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -14,12 +14,12 @@
 	interrupt-parent = <&gic>;
 
 	chosen {
-		stdout-path = "uart1:115200";
+		stdout-path = "serial1:115200";
 	};
 
 	aliases {
-		uart0 = &uart0;
-		uart1 = &uart1;
+		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	cpus {
diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
index 8e36a5baaa7e..6077bca9b364 100644
--- a/arch/mips/generic/yamon-dt.c
+++ b/arch/mips/generic/yamon-dt.c
@@ -163,7 +163,7 @@ __init int yamon_dt_append_memory(void *fdt,
 __init int yamon_dt_serial_config(void *fdt)
 {
 	const char *yamontty, *mode_var;
-	char mode_var_name[9], path[18], parity;
+	char mode_var_name[9], path[20], parity;
 	unsigned int uart, baud, stop_bits;
 	bool hw_flow;
 	int chosen_off, err;
@@ -214,7 +214,7 @@ __init int yamon_dt_serial_config(void *fdt)
 	if (stop_bits != 7 && stop_bits != 8)
 		stop_bits = 8;
 
-	WARN_ON(snprintf(path, sizeof(path), "uart%u:%u%c%u%s",
+	WARN_ON(snprintf(path, sizeof(path), "serial%u:%u%c%u%s",
 			 uart, baud, parity, stop_bits,
 			 hw_flow ? "r" : "") >= sizeof(path));
 
-- 
2.13.0
