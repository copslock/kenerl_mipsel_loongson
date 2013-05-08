Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 13:14:28 +0200 (CEST)
Received: from 84-245-11-97.dsl.cambrium.nl ([84.245.11.97]:33209 "EHLO
        grubby.stderr.nl" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6823054Ab3EHLOYMcPrr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 13:14:24 +0200
Received: from matthijs by grubby.stderr.nl with local (Exim 4.80)
        (envelope-from <matthijs@stdin.nl>)
        id 1Ua2Jx-0002xu-Sc; Wed, 08 May 2013 13:14:05 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     Michal Marek <mmarek@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>,
        Matthijs Kooijman <matthijs@stdin.nl>
Subject: [PATCH] kbuild: Don't assume dts files live in arch/*/boot/dts
Date:   Wed,  8 May 2013 12:59:04 +0200
Message-Id: <1368010744-11281-1-git-send-email-matthijs@stdin.nl>
X-Mailer: git-send-email 1.8.0
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthijs@stdin.nl
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

In commit b40b25ff (kbuild: always run gcc -E on *.dts, remove cmd_dtc_cpp),
dts building was changed to always use the C preprocessor. This meant
that the .dts file passed to dtc is not the original, but the
preprocessed one.

When compiling with a separate build directory (i.e., with O=), this
preprocessed file will not live in the same directory as the original.
When the .dts file includes .dtsi files, dtc will look for them in the
build directory, not in the source directory and compilation will fail.

The commit referenced above tried to fix this by passing arch/*/boot/dts
as an include path to dtc. However, for mips, the .dts files are not in
this directory, so dts compilation on mips breaks for some targets.

Instead of hardcoding this particular include path, this commit just
uses the directory of the .dts file that is being compiled, which
effectively restores the previous behaviour wrt includes. For most .dts
files, this path is just the same as the previous hardcoded
arch/*/boot/dts path.

This was tested on a mips (rt3052) and an arm (bcm2835) target.

Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 51bb3de..8337663 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -264,7 +264,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 \
-		-i $(srctree)/arch/$(SRCARCH)/boot/dts $(DTC_FLAGS) \
+		-i $(dir $<) $(DTC_FLAGS) \
 		-d $(depfile).dtc $(dtc-tmp) ; \
 	cat $(depfile).pre $(depfile).dtc > $(depfile)
 
-- 
1.8.0
