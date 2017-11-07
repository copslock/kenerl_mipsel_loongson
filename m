Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 17:32:57 +0100 (CET)
Received: from conuserg-09.nifty.com ([210.131.2.76]:62803 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKGQcuL3tW0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 17:32:50 +0100
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id vA7GVppM022965;
        Wed, 8 Nov 2017 01:31:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com vA7GVppM022965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510072313;
        bh=vsamA0lxCZuqmejqmOwIvXGViwaLdFje50JepwwrXE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICBHYmqkQz2WIy8WBjCk7/DNjCx+miHLuR9hgBOrf97n5MeVMqNEaKAWP4ssjWMjL
         GsO0La6Qw7kJbmMKpxthIAT+S0YNUFbGgUYKGQTuOvfAWIShbx2QhI3hHIr0lxBF4D
         olNpMDQCmuOXWWTT+Vh3I79UPXO8vm3tX521vt6bTvnO3nD8ERCUSQsZyJZljo37j6
         P4zZMJW6BjKbJgyMu5LPOuUDwrEFC+baE2TiZMvtCu7igOVQ++l3mxTrpZkZuvfefV
         q8MsIlPStoNcfYpVJQ234sQHxuQV5tSMR02oelh7i/ktLS+NQbBZBTbkJ41bwgf7N7
         JygO0fUJf7MiA==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <mmarek@suse.com>
Subject: [PATCH 1/2] kbuild: create built-in.o automatically if parent directory wants it
Date:   Wed,  8 Nov 2017 01:31:46 +0900
Message-Id: <1510072307-16819-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

"obj-y += foo/" syntax requires Kbuild to visit the "foo" subdirectory
and link built-in.o from that directory.  This means foo/Makefile is
responsible for creating built-in.o even if there is no object to
link (in this case, built-in.o is an empty archive).

We have had several fixups like commit 4b024242e8a4 ("kbuild: Fix
linking error built-in.o no such file or directory"), then ended up
with a complex condition as follows:

  ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
  builtin-target := $(obj)/built-in.o
  endif

We still have more cases not covered by the above, so we need to add
  obj- := dummy.o
in several places just for creating empty built-in.o.

A key point is, the parent Makefile knows whether built-in.o is needed
or not.  If a subdirectory needs to create built-in.o, its parent can
tell the fact when Kbuild descends into it.

If non-empty $(need-builtin) flag is passed from the parent, built-in.o
should be created.  $(obj-y) should be still checked to support the
single target "%/".  All of ugly tricks will go away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile               | 2 +-
 scripts/Makefile.build | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 008a4e5..cc0b618 100644
--- a/Makefile
+++ b/Makefile
@@ -1003,7 +1003,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
 
 PHONY += $(vmlinux-dirs)
 $(vmlinux-dirs): prepare scripts
-	$(Q)$(MAKE) $(build)=$@
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1
 
 define filechk_kernel.release
 	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 061d0c3..e1c6efd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -84,7 +84,7 @@ lib-target := $(obj)/lib.a
 obj-y += $(obj)/lib-ksyms.o
 endif
 
-ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
+ifneq ($(strip $(obj-y) $(need-builtin)),)
 builtin-target := $(obj)/built-in.o
 endif
 
@@ -569,7 +569,7 @@ targets += $(multi-used-y) $(multi-used-m)
 
 PHONY += $(subdir-ym)
 $(subdir-ym):
-	$(Q)$(MAKE) $(build)=$@
+	$(Q)$(MAKE) $(build)=$@ need-builtin=$(if $(findstring $@,$(subdir-obj-y)),1)
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
-- 
2.7.4
