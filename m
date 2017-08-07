Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 00:39:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16914 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994887AbdHGWimn5nzI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 00:38:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 904866F3AF7AE;
        Mon,  7 Aug 2017 23:38:31 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Aug 2017 23:38:36
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: [PATCH 3/4] MIPS: generic: Move NI 169445 FIT image source to its own file
Date:   Mon, 7 Aug 2017 15:37:23 -0700
Message-ID: <20170807223724.19408-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807223724.19408-1-paul.burton@imgtec.com>
References: <20170807223724.19408-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59404
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

Move the NI 169445 board flattened image tree source into its own file
which is concatenated into the final image tree source used to build the
flattened image tree. Separating boards into different files will help
us to avoid conflicts as boards are added.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Nathan Sullivan <nathan.sullivan@ni.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/Platform             |  1 +
 arch/mips/generic/board-ni169445.its.S | 22 ++++++++++++++++++++++
 arch/mips/generic/vmlinux.its.S        | 25 -------------------------
 3 files changed, 23 insertions(+), 25 deletions(-)
 create mode 100644 arch/mips/generic/board-ni169445.its.S

diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 50c8ad58b5f1..f5312dfa8184 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -15,3 +15,4 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
diff --git a/arch/mips/generic/board-ni169445.its.S b/arch/mips/generic/board-ni169445.its.S
new file mode 100644
index 000000000000..d12e12fe90be
--- /dev/null
+++ b/arch/mips/generic/board-ni169445.its.S
@@ -0,0 +1,22 @@
+{
+	images {
+		fdt@ni169445 {
+			description = "NI 169445 device tree";
+			data = /incbin/("boot/dts/ni/169445.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@0 {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		conf@ni169445 {
+			description = "NI 169445 Linux Kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@ni169445";
+		};
+	};
+};
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
index 4a142e746719..f67fbf1c8541 100644
--- a/arch/mips/generic/vmlinux.its.S
+++ b/arch/mips/generic/vmlinux.its.S
@@ -29,28 +29,3 @@
 		};
 	};
 };
-
-#ifdef CONFIG_FIT_IMAGE_FDT_NI169445
-{
-	images {
-		fdt@ni169445 {
-			description = "NI 169445 device tree";
-			data = /incbin/("boot/dts/ni/169445.dtb");
-			type = "flat_dt";
-			arch = "mips";
-			compression = "none";
-			hash@0 {
-				algo = "sha1";
-			};
-		};
-	};
-
-	configurations {
-		conf@ni169445 {
-			description = "NI 169445 Linux Kernel";
-			kernel = "kernel@0";
-			fdt = "fdt@ni169445";
-		};
-	};
-};
-#endif /* CONFIG_FIT_IMAGE_FDT_NI169445 */
-- 
2.14.0
