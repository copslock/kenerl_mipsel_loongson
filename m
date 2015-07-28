Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 11:46:05 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33684 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009326AbbG1JqCYoX0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2015 11:46:02 +0200
Received: by wicmv11 with SMTP id mv11so171831814wic.0;
        Tue, 28 Jul 2015 02:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hXV/T2yAOmnxNdlnQh4E8ecurSXkRkTVn2mZrDbQFL8=;
        b=S7gKOfLtT5V0CPM3MwkOkGOILYqHS0JpMWGJxuda1CDUxcDzkJM7xLOfVjLC/K6r9N
         vgG1nTkWuokRL3xWaNKLJ5uS4gnbR+bcJhMrsAkl7R6SZ9H2ChjfP3cWuX8GSspRps6X
         Lb5cFh4d/a/uJnH24b8UlJaNUVPY/eqMpXmqATnS/690m1Bc+V3Z5BcPSwm641L/aoe7
         O2BNVlGCn2F5aJXVGhjX/pODYYTecHCYnu/dO68LjKBqK9aqv/xvJE5x8HsMz/d8Ztad
         KXD3rxNFadIn0shz2OIrANYcy7B8ixU4BGLfe461tHnkkgDCWGV7FixEP4j+ZcaNgVgC
         +npA==
X-Received: by 10.194.7.97 with SMTP id i1mr64074985wja.107.1438076757147;
        Tue, 28 Jul 2015 02:45:57 -0700 (PDT)
Received: from anemoi.home (ip4-83-240-67-251.cust.nbox.cz. [83.240.67.251])
        by smtp.gmail.com with ESMTPSA id uc16sm18120323wib.8.2015.07.28.02.45.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 02:45:56 -0700 (PDT)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 091/124] MIPS: Fix KVM guest fixmap address
Date:   Tue, 28 Jul 2015 11:43:45 +0200
Message-Id: <5e30bb61d6e081c1728af25e7737bafb71fb2fbd.1438076484.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <90d8a5681e4a9e320611b422f0ed012e148c2bca.1438076484.git.jslaby@suse.cz>
References: <90d8a5681e4a9e320611b422f0ed012e148c2bca.1438076484.git.jslaby@suse.cz>
In-Reply-To: <cover.1438076484.git.jslaby@suse.cz>
References: <cover.1438076484.git.jslaby@suse.cz>
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 9488fa5f8866..afc96ecb9004 100644
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
2.4.6
