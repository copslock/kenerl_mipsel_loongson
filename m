Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 03:21:27 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993945AbdHOBUnA59nm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 03:20:43 +0200
Received: from localhost (unknown [70.96.146.25])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 113528D9;
        Tue, 15 Aug 2017 01:20:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.12 63/65] Revert "MIPS: Dont unnecessarily include kmalloc.h into <asm/cache.h>."
Date:   Mon, 14 Aug 2017 18:19:54 -0700
Message-Id: <20170815011944.887563649@linuxfoundation.org>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170815011942.395714306@linuxfoundation.org>
References: <20170815011942.395714306@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit ae5b0675942ab30cde96099c68a2290bd1aafcca upstream.

Commit 296e46db0073 ("MIPS: Don't unnecessarily include kmalloc.h into
<asm/cache.h>.") claimed that the inclusion of the machine's kmalloc.h
from asm/cache.h is unnecessary, but this is not true.

Without including kmalloc.h we don't get a definition for
ARCH_DMA_MINALIGN, which means we no longer suitably align DMA. Further
to this the definition of ARCH_KMALLOC_MINALIGN provided by linux/slab.h
ends up being set to the alignment of an unsigned long long value rather
than to ARCH_DMA_MINALIGN, which means that buffers allocated using
kmalloc may no longer be safely aligned for use with DMA.

Fix this by re-adding the include of kmalloc.h in asm/cache.h. This
reverts commit 296e46db0073 ("MIPS: Don't unnecessarily include
kmalloc.h into <asm/cache.h>.")

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 296e46db0073 ("MIPS: Don't unnecessarily include kmalloc.h into <asm/cache.h>.")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16895/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/cache.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/include/asm/cache.h
+++ b/arch/mips/include/asm/cache.h
@@ -9,6 +9,8 @@
 #ifndef _ASM_CACHE_H
 #define _ASM_CACHE_H
 
+#include <kmalloc.h>
+
 #define L1_CACHE_SHIFT		CONFIG_MIPS_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
