Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 10:58:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58607 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823018Ab2KBJ6UmUTLI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Nov 2012 10:58:20 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qA29wDmS024326;
        Fri, 2 Nov 2012 10:58:13 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qA29w1xw024288;
        Fri, 2 Nov 2012 10:58:01 +0100
Date:   Fri, 2 Nov 2012 10:58:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Michal Marek <mmarek@suse.cz>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Scott Wood <scottwood@freescale.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, linux-arch@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
Message-ID: <20121102095801.GC17860@linux-mips.org>
References: <1351721431-26220-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1351721431-26220-1-git-send-email-swarren@wwwdotorg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Oct 31, 2012 at 04:10:30PM -0600, Stephen Warren wrote:

> From: Stephen Warren <swarren@nvidia.com>
> 
> All architectures that use cmd_dtc do so in the same way. Move the build
> rule to a central location to avoid duplication.

Can you fold these MIPS bits into your patch?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/cavium-octeon/Makefile | 3 ---
 arch/mips/netlogic/dts/Makefile  | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index bc96e29..6e927cf 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -24,9 +24,6 @@ DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
 
 obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
 
-$(obj)/%.dtb: $(src)/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
 # Let's keep the .dtb files around in case we want to look at them.
 .SECONDARY:  $(addprefix $(obj)/, $(DTB_FILES))
 
diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
index 67ae3fe2..d117d46 100644
--- a/arch/mips/netlogic/dts/Makefile
+++ b/arch/mips/netlogic/dts/Makefile
@@ -1,4 +1 @@
 obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
-
-$(obj)/%.dtb: $(obj)/%.dts
-	$(call if_changed,dtc)
