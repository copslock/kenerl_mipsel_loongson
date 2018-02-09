Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 17:13:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992917AbeBIQM7QsFKS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 17:12:59 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EA6217AA;
        Fri,  9 Feb 2018 16:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EA6217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/3] MIPS: Refactor legacy defconfigs
Date:   Fri,  9 Feb 2018 16:11:56 +0000
Message-Id: <28c78dcb9527b7a841d49370936124b202434efe.1518192692.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
References: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
In-Reply-To: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
References: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62477
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

Define legacy defconfigs which have been converted to the generic
platform more programatically, so that they can be listed in the
Makefile help text and as a separate Makefile target without
duplication.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kbuild@vger.kernel.org
---
 arch/mips/Makefile | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d1ca839c3981..6f368b5cdf29 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -543,14 +543,15 @@ generic_defconfig:
 # now that the boards have been converted to use the generic kernel they are
 # wrappers around the generic rules above.
 #
-.PHONY: sead3_defconfig
-sead3_defconfig:
-	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=sead-3
+legacy_defconfigs		+= sead3_defconfig
+sead3_defconfig-y		:= 32r2el_defconfig BOARDS=sead-3
 
-.PHONY: sead3micro_defconfig
-sead3micro_defconfig:
-	$(Q)$(MAKE) -f $(srctree)/Makefile micro32r2el_defconfig BOARDS=sead-3
+legacy_defconfigs		+= sead3micro_defconfig
+sead3micro_defconfig-y		:= micro32r2el_defconfig BOARDS=sead-3
 
-.PHONY: xilfpga_defconfig
-xilfpga_defconfig:
-	$(Q)$(MAKE) -f $(srctree)/Makefile 32r2el_defconfig BOARDS=xilfpga
+legacy_defconfigs		+= xilfpga_defconfig
+xilfpga_defconfig-y		:= 32r2el_defconfig BOARDS=xilfpga
+
+.PHONY: $(legacy_defconfigs)
+$(legacy_defconfigs):
+	$(Q)$(MAKE) -f $(srctree)/Makefile $($@-y)
-- 
git-series 0.9.1
