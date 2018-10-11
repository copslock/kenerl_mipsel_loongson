Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 01:41:02 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:12378 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994652AbeJKXkH3Rfsx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Oct 2018 01:40:07 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 16:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="96792934"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2018 16:40:03 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de,
        jeyu@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 3/7] arm/modules: Add rlimit checking for arm modules
Date:   Thu, 11 Oct 2018 16:31:13 -0700
Message-Id: <20181011233117.7883-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
Return-Path: <rick.p.edgecombe@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rick.p.edgecombe@intel.com
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

This adds in the rlimit checking for the arm module allocator.

This has not been tested.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/arm/kernel/module.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..e331863553d2 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -43,6 +43,9 @@ void *module_alloc(unsigned long size)
 	gfp_t gfp_mask = GFP_KERNEL;
 	void *p;
 
+	if (check_inc_mod_rlimit(size))
+		return NULL;
+
 	/* Silence the initial allocation */
 	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
 		gfp_mask |= __GFP_NOWARN;
@@ -51,10 +54,15 @@ void *module_alloc(unsigned long size)
 				gfp_mask, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
-		return p;
-	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
+		goto done;
+	p = __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
 				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
+
+done:
+	update_mod_rlimit(p, size);
+
+	return p;
 }
 #endif
 
-- 
2.17.1
