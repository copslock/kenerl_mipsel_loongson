Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 10:45:37 +0100 (CET)
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:44808 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992514AbdAFJoWC8Xi5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 10:44:22 +0100
Received: from elsass.dev.6wind.com (unknown [10.16.0.149])
        by proxy.6wind.com (Postfix) with ESMTPS id 5899D254EC;
        Fri,  6 Jan 2017 10:44:08 +0100 (CET)
Received: from root by elsass.dev.6wind.com with local (Exim 4.84_2)
        (envelope-from <root@elsass.dev.6wind.com>)
        id 1cPR49-0004sc-5e; Fri, 06 Jan 2017 10:44:05 +0100
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
Subject: [PATCH v2 3/7] nios2: put setup.h in uapi
Date:   Fri,  6 Jan 2017 10:43:55 +0100
Message-Id: <1483695839-18660-4-git-send-email-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
Return-Path: <root@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56208
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

This header file is exported, thus move it to uapi.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 arch/nios2/include/asm/setup.h      | 2 +-
 arch/nios2/include/uapi/asm/setup.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 arch/nios2/include/uapi/asm/setup.h

diff --git a/arch/nios2/include/asm/setup.h b/arch/nios2/include/asm/setup.h
index dcbf8cf1a344..d49e9e91bf55 100644
--- a/arch/nios2/include/asm/setup.h
+++ b/arch/nios2/include/asm/setup.h
@@ -19,7 +19,7 @@
 #ifndef _ASM_NIOS2_SETUP_H
 #define _ASM_NIOS2_SETUP_H
 
-#include <asm-generic/setup.h>
+#include <uapi/asm/setup.h>
 
 #ifndef __ASSEMBLY__
 #ifdef __KERNEL__
diff --git a/arch/nios2/include/uapi/asm/setup.h b/arch/nios2/include/uapi/asm/setup.h
new file mode 100644
index 000000000000..8d8285997ba8
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/setup.h
@@ -0,0 +1,6 @@
+#ifndef _UAPI_ASM_NIOS2_SETUP_H
+#define _UAPI_ASM_NIOS2_SETUP_H
+
+#include <asm-generic/setup.h>
+
+#endif /* _UAPI_ASM_NIOS2_SETUP_H */
-- 
2.8.1
