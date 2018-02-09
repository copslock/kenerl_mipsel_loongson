Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 17:14:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992966AbeBIQNDBbdKS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 17:13:03 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21DC217B4;
        Fri,  9 Feb 2018 16:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21DC217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 3/3] MIPS: Expand help text to list generic defconfigs
Date:   Fri,  9 Feb 2018 16:11:58 +0000
Message-Id: <7a6cf6748383b693f5e50dbfe9f1660f0908da67.1518192692.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
References: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
In-Reply-To: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
References: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62479
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

Expand the MIPS Makefile help text to list generic board names, generic
defconfigs, and legacy defconfigs which have been converted to generic
and are still usable.

Here's a snippet of the new "make ARCH=mips help" output:
  ...
  If you are targeting a system supported by generic kernels you may
  configure the kernel for a given architecture target like so:

  {micro32,32,64}{r1,r2,r6}{el,}_defconfig <BOARDS="list of boards">

  Where BOARDS is some subset of the following:
    boston
    ni169445
    ranchu
    sead-3
    xilfpga

  Specifically the following generic default configurations are
  supported:

  32r1_defconfig           - Build generic kernel for MIPS32 r1
  32r1el_defconfig         - Build generic kernel for MIPS32 r1 little endian
  32r2_defconfig           - Build generic kernel for MIPS32 r2
  32r2el_defconfig         - Build generic kernel for MIPS32 r2 little endian
  32r6_defconfig           - Build generic kernel for MIPS32 r6
  32r6el_defconfig         - Build generic kernel for MIPS32 r6 little endian
  64r1_defconfig           - Build generic kernel for MIPS64 r1
  64r1el_defconfig         - Build generic kernel for MIPS64 r1 little endian
  64r2_defconfig           - Build generic kernel for MIPS64 r2
  64r2el_defconfig         - Build generic kernel for MIPS64 r2 little endian
  64r6_defconfig           - Build generic kernel for MIPS64 r6
  64r6el_defconfig         - Build generic kernel for MIPS64 r6 little endian
  micro32r2_defconfig      - Build generic kernel for microMIPS32 r2
  micro32r2el_defconfig    - Build generic kernel for microMIPS32 r2 little endian

  The following legacy default configurations have been converted to
  generic and can still be used:

  sead3_defconfig          - Build 32r2el_defconfig BOARDS=sead-3
  sead3micro_defconfig     - Build micro32r2el_defconfig BOARDS=sead-3
  xilfpga_defconfig        - Build 32r2el_defconfig BOARDS=xilfpga
  ...

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kbuild@vger.kernel.org
---
 arch/mips/Makefile | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9ba487c1c4d2..e7a9ec56aa51 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -476,6 +476,21 @@ define archhelp
 	echo
 	echo '  {micro32,32,64}{r1,r2,r6}{el,}_defconfig <BOARDS="list of boards">'
 	echo
+	echo '  Where BOARDS is some subset of the following:'
+	for board in $(sort $(BOARDS)); do echo "    $${board}"; done
+	echo
+	echo '  Specifically the following generic default configurations are'
+	echo '  supported:'
+	echo
+	$(foreach cfg,$(generic_defconfigs),
+	  printf "  %-24s - Build generic kernel for $(call describe_generic_defconfig,$(cfg))\n" $(cfg);)
+	echo
+	echo '  The following legacy default configurations have been converted to'
+	echo '  generic and can still be used:'
+	echo
+	$(foreach cfg,$(sort $(legacy_defconfigs)),
+	  printf "  %-24s - Build $($(cfg)-y)\n" $(cfg);)
+	echo
 	echo '  Otherwise, the following default configurations are available:'
 endef
 
@@ -510,6 +525,10 @@ endef
 $(eval $(call gen_generic_defconfigs,32 64,r1 r2 r6,eb el))
 $(eval $(call gen_generic_defconfigs,micro32,r2,eb el))
 
+define describe_generic_defconfig
+$(subst 32r,MIPS32 r,$(subst 64r,MIPS64 r,$(subst el, little endian,$(patsubst %_defconfig,%,$(1)))))
+endef
+
 .PHONY: $(generic_defconfigs)
 $(generic_defconfigs):
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-- 
git-series 0.9.1
