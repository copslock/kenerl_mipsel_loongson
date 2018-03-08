Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 12:03:16 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994739AbeCHLDIP38Eo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Mar 2018 12:03:08 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2345C2133D;
        Thu,  8 Mar 2018 11:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2345C2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: [PATCH v2] kbuild: Handle builtin dtb file names containing hyphens
Date:   Thu,  8 Mar 2018 11:02:46 +0000
Message-Id: <20180308110246.16639-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
References: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
FDT (that is, the .dtb file) as binary data in the kernel image. This
assembly source contains labels before and after the binary data. The
label names incorporate the file name of the corresponding .dtb file.
Hyphens are not legal characters in labels, so .dtb files built into the
kernel with hyphens in the file name result in errors like the
following:

bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'

Fix this by updating cmd_dt_S_dtb to transform all hyphens from the file
name to underscores when constructing the labels.

As of v4.16-rc2, 1139 .dts files across ARM64, ARM, MIPS and PowerPC
contain hyphens in their names, but the issue only currently manifests
on Broadcom MIPS platforms, as that is the only place where such files
are built into the kernel. For example when CONFIG_DT_NETGEAR_CVG834G=y,
or on BMIPS kernels when the dtbs target is used (in the latter case it
admittedly shouldn't really build all the dtb.o files, but thats a
separate issue).

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.9+
---
Changes in v2:
 - Rewrite commit message (thanks Frank for some improved wording).
 - Add Franks' reviewed-by.
---
 scripts/Makefile.lib | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5589bae34af6..a6f538b31ad6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -297,11 +297,11 @@ cmd_dt_S_dtb=						\
 	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
 	echo '.section .dtb.init.rodata,"a"';		\
 	echo '.balign STRUCT_ALIGNMENT';		\
-	echo '.global __dtb_$(*F)_begin';		\
-	echo '__dtb_$(*F)_begin:';			\
+	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
+	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
 	echo '.incbin "$<" ';				\
-	echo '__dtb_$(*F)_end:';			\
-	echo '.global __dtb_$(*F)_end';			\
+	echo '__dtb_$(subst -,_,$(*F))_end:';		\
+	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
 	echo '.balign STRUCT_ALIGNMENT'; 		\
 ) > $@
 
-- 
2.13.6
