Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 04:01:59 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:38962 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011475AbbGWCB5gL-Zr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 04:01:57 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZI5pd-0005iR-3L; Thu, 23 Jul 2015 02:01:57 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZI5pa-0006CS-S7; Wed, 22 Jul 2015 19:01:54 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 080/132] MIPS: Fix KVM guest fixmap address
Date:   Wed, 22 Jul 2015 18:59:58 -0700
Message-Id: <1437616850-23266-81-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1437616850-23266-1-git-send-email-kamal@canonical.com>
References: <1437616850-23266-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11-ckt24 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 8e748c8d09a9314eedb5c6367d9acfaacddcdc88 upstream.

KVM guest kernels for trap & emulate run in user mode, with a modified
set of kernel memory segments. However the fixmap address is still in
the normal KSeg3 region at 0xfffe0000 regardless, causing problems when
cache alias handling makes use of them when handling copy on write.

Therefore define FIXADDR_TOP as 0x7ffe0000 in the guest kernel mapped
region when CONFIG_KVM_GUEST is defined.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9887/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 9488fa5..afc96ec 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -94,7 +94,11 @@
 #endif
 
 #ifndef FIXADDR_TOP
+#ifdef CONFIG_KVM_GUEST
+#define FIXADDR_TOP		((unsigned long)(long)(int)0x7ffe0000)
+#else
 #define FIXADDR_TOP		((unsigned long)(long)(int)0xfffe0000)
 #endif
+#endif
 
 #endif /* __ASM_MACH_GENERIC_SPACES_H */
-- 
1.9.1
