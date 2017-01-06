Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 10:46:05 +0100 (CET)
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:44840 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992535AbdAFJoYUpJc5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 10:44:24 +0100
Received: from elsass.dev.6wind.com (unknown [10.16.0.149])
        by proxy.6wind.com (Postfix) with ESMTPS id 37861254EE;
        Fri,  6 Jan 2017 10:44:09 +0100 (CET)
Received: from root by elsass.dev.6wind.com with local (Exim 4.84_2)
        (envelope-from <root@elsass.dev.6wind.com>)
        id 1cPR49-0004sl-7E; Fri, 06 Jan 2017 10:44:05 +0100
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     arnd@arndb.de
Cc:     mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v2 5/7] Makefile.headersinst: cleanup input files
Date:   Fri,  6 Jan 2017 10:43:57 +0100
Message-Id: <1483695839-18660-6-git-send-email-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
Return-Path: <root@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.dichtel@6wind.com
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

After the last four patches, all exported headers are under uapi/, thus
input-files2 are not needed anymore.
The side effect is that input-files1-name is exactly header-y.

Note also that unput-files3-name is genhdr-y.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 scripts/Makefile.headersinst | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 1106d6ca3a38..3e20d03432d2 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -40,31 +40,20 @@ wrapper-files := $(filter $(header-y), $(generic-y))
 srcdir        := $(srctree)/$(obj)
 gendir        := $(objtree)/$(gen)
 
-oldsrcdir     := $(srctree)/$(subst /uapi,,$(obj))
-
 # all headers files for this dir
 header-y      := $(filter-out $(generic-y), $(header-y))
 all-files     := $(header-y) $(genhdr-y) $(wrapper-files)
 output-files  := $(addprefix $(installdir)/, $(all-files))
 
-input-files1  := $(foreach hdr, $(header-y), \
-		   $(if $(wildcard $(srcdir)/$(hdr)), \
-			$(wildcard $(srcdir)/$(hdr))) \
-		   )
-input-files1-name := $(notdir $(input-files1))
-input-files2  := $(foreach hdr, $(header-y), \
-		   $(if  $(wildcard $(srcdir)/$(hdr)),, \
-			$(if $(wildcard $(oldsrcdir)/$(hdr)), \
-				$(wildcard $(oldsrcdir)/$(hdr)), \
-				$(error Missing UAPI file $(srcdir)/$(hdr))) \
-		   ))
-input-files2-name := $(notdir $(input-files2))
-input-files3  := $(foreach hdr, $(genhdr-y), \
-		   $(if	$(wildcard $(gendir)/$(hdr)), \
-			$(wildcard $(gendir)/$(hdr)), \
-			$(error Missing generated UAPI file $(gendir)/$(hdr)) \
-		   ))
-input-files3-name := $(notdir $(input-files3))
+# Check that all expected files exist
+$(foreach hdr, $(header-y), \
+  $(if $(wildcard $(srcdir)/$(hdr)),, \
+       $(error Missing UAPI file $(srcdir)/$(hdr)) \
+   ))
+$(foreach hdr, $(genhdr-y), \
+  $(if	$(wildcard $(gendir)/$(hdr)),, \
+       $(error Missing generated UAPI file $(gendir)/$(hdr)) \
+  ))
 
 # Work out what needs to be removed
 oldheaders    := $(patsubst $(installdir)/%,%,$(wildcard $(installdir)/*.h))
@@ -78,9 +67,8 @@ printdir = $(patsubst $(INSTALL_HDR_PATH)/%/,%,$(dir $@))
 quiet_cmd_install = INSTALL $(printdir) ($(words $(all-files))\
                             file$(if $(word 2, $(all-files)),s))
       cmd_install = \
-        $(CONFIG_SHELL) $< $(installdir) $(srcdir) $(input-files1-name); \
-        $(CONFIG_SHELL) $< $(installdir) $(oldsrcdir) $(input-files2-name); \
-        $(CONFIG_SHELL) $< $(installdir) $(gendir) $(input-files3-name); \
+        $(CONFIG_SHELL) $< $(installdir) $(srcdir) $(header-y); \
+        $(CONFIG_SHELL) $< $(installdir) $(gendir) $(genhdr-y); \
         for F in $(wrapper-files); do                                   \
                 echo "\#include <asm-generic/$$F>" > $(installdir)/$$F;    \
         done;                                                           \
-- 
2.8.1
