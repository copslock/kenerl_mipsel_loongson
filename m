Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jul 2013 11:26:23 +0200 (CEST)
Received: from mo11.iij4u.or.jp ([210.138.174.79]:36247 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3GSJ0TXA84F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Jul 2013 11:26:19 +0200
Received: by mo.iij4u.or.jp (mo11) id r6J9QFAX024288; Fri, 19 Jul 2013 18:26:15 +0900
Received: from delta (sannin29190.nirai.ne.jp [203.160.29.190])
        by mbox.iij4u.or.jp (mbox10) id r6J9QCet018504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 19 Jul 2013 18:26:14 +0900
Date:   Fri, 19 Jul 2013 18:26:11 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ar7: fix redefined UNCAC_BASE and IO_BASE
Message-Id: <20130719182611.41aeb79b5711b3c9f849d594@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

In file included from arch/mips/include/asm/mach-ar7/spaces.h:23:0,
                 from arch/mips/include/asm/addrspace.h:13,
                 from arch/mips/include/asm/barrier.h:11,
                 from arch/mips/include/asm/bitops.h:18,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
arch/mips/include/asm/mach-generic/spaces.h:28:0: warning: "IO_BASE" redefined [enabled by default]
In file included from arch/mips/include/asm/addrspace.h:13:0,
                 from arch/mips/include/asm/barrier.h:11,
                 from arch/mips/include/asm/bitops.h:18,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
arch/mips/include/asm/mach-ar7/spaces.h:21:0: note: this is the location of the previous definition
In file included from arch/mips/include/asm/mach-ar7/spaces.h:23:0,
                 from arch/mips/include/asm/addrspace.h:13,
                 from arch/mips/include/asm/barrier.h:11,
                 from arch/mips/include/asm/bitops.h:18,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
arch/mips/include/asm/mach-generic/spaces.h:29:0: warning: "UNCAC_BASE" redefined [enabled by default]
In file included from arch/mips/include/asm/addrspace.h:13:0,
                 from arch/mips/include/asm/barrier.h:11,
                 from arch/mips/include/asm/bitops.h:18,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
arch/mips/include/asm/mach-ar7/spaces.h:20:0: note: this is the location of the previous definition
In file included from arch/mips/include/asm/mach-ar7/spaces.h:23:0,

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/mach-generic/spaces.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 5b2f2e6..c5d12b4 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -20,13 +20,22 @@
 #endif
 
 #ifdef CONFIG_32BIT
+
+#ifndef CAC_BASE
 #ifdef CONFIG_KVM_GUEST
 #define CAC_BASE		_AC(0x40000000, UL)
 #else
 #define CAC_BASE		_AC(0x80000000, UL)
 #endif
+#endif
+
+#ifndef IO_BASE
 #define IO_BASE			_AC(0xa0000000, UL)
+#endif
+
+#ifndef UNCAC_BASE
 #define UNCAC_BASE		_AC(0xa0000000, UL)
+#endif
 
 #ifndef MAP_BASE
 #ifdef CONFIG_KVM_GUEST
-- 
1.7.9.5
