Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 15:07:23 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994715AbeCGOHQq7isg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 15:07:16 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07E52172D;
        Wed,  7 Mar 2018 14:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07E52172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: [PATCH] kbuild: Handle builtin dtb files containing hyphens
Date:   Wed,  7 Mar 2018 14:06:33 +0000
Message-Id: <20180307140633.26182-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62828
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

On dtb files which contain hyphens, the dt_S_dtb command to build the
dtb.S files (which allow DTB files to be built into the kernel) results
in errors like the following:

bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'

This is due to the hyphen being used in symbol names. Replace all
hyphens with underscores in the dt_S_dtb command to avoid this problem.

Quite a lot of dts files have hyphens, but its only a problem on MIPS
where such files can be built into the kernel. For example when
CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
used (in the latter case it admitedly shouldn't really build all the
dtb.o files, but thats a separate issue).

Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
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
