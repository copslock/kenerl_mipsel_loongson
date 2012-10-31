Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 13:59:44 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2714 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825658Ab2JaM6qKf7Av (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:46 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:43 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:01 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 955B140FE3; Wed, 31
 Oct 2012 05:58:29 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 05/15] MIPS: Netlogic: keep .dtb/.dtb.S until make clean
Date:   Wed, 31 Oct 2012 18:31:31 +0530
Message-ID: <7a800eb7eb2a75800749cab24e67c6b1e3c76b7c.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF813QC1968400-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Provide a .SECONDARY entry for these intermediate files. Otherwise
make deletes them, and these files are regenerated for every rebuild.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/dts/Makefile |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
index 67ae3fe2..40502ff 100644
--- a/arch/mips/netlogic/dts/Makefile
+++ b/arch/mips/netlogic/dts/Makefile
@@ -1,4 +1,14 @@
-obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
+DTS_FILE		= xlp_evp.dts
+DTB_FILE		= $(patsubst %.dts, %.dtb, $(DTS_FILE))
 
-$(obj)/%.dtb: $(obj)/%.dts
-	$(call if_changed,dtc)
+# built-in dtb
+obj-$(CONFIG_DT_XLP_EVP) := $(DTB_FILE).o
+
+$(obj)/%.dtb: $(src)/%.dts
+	$(call if_changed_dep,dtc)
+
+# Keep intermediate files .dtb and .dtb.S, delete them only at make clean
+KEEP_FILES		= $(DTB_FILE) $(DTB_FILE).S
+clean-files		+= $(KEEP_FILES)
+
+.SECONDARY: $(addprefix $(obj)/, $(KEEP_FILES))
-- 
1.7.9.5
