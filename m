Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2013 17:14:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:39826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6852086Ab3KYQOc30ykQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Nov 2013 17:14:32 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rAPGEEl2009587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 25 Nov 2013 11:14:15 -0500
Received: from deneb.redhat.com (ovpn-113-175.phx2.redhat.com [10.3.113.175])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id rAPGE9Xx022728;
        Mon, 25 Nov 2013 11:14:12 -0500
From:   Mark Salter <msalter@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>, linux-arch@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/11] Add generic fixmap.h
Date:   Mon, 25 Nov 2013 11:13:55 -0500
Message-Id: <1385396045-15852-2-git-send-email-msalter@redhat.com>
In-Reply-To: <1385396045-15852-1-git-send-email-msalter@redhat.com>
References: <1385396045-15852-1-git-send-email-msalter@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
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

Many architectures provide an asm/fixmap.h which defines support for
compile-time 'special' virtual mappings which need to be made before
paging_init() has run. This support is also used for early ioremap
on x86. Much of this support is identical across the architectures.
This patch consolidates all of the common bits into asm-generic/fixmap.h
which is intended to be included from arch/*/include/asm/fixmap.h.

Signed-off-by: Mark Salter <msalter@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
CC: linux-arch@vger.kernel.org
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
CC: Richard Kuo <rkuo@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
CC: James Hogan <james.hogan@imgtec.com>
CC: linux-metag@vger.kernel.org
CC: Michal Simek <monstr@monstr.eu>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linux-mips@linux-mips.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org
---
 include/asm-generic/fixmap.h | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 include/asm-generic/fixmap.h

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
new file mode 100644
index 0000000..5a64ca4
--- /dev/null
+++ b/include/asm-generic/fixmap.h
@@ -0,0 +1,97 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ * x86_32 and x86_64 integration by Gustavo F. Padovan, February 2009
+ * Break out common bits to asm-generic by Mark Salter, November 2013
+ */
+
+#ifndef __ASM_GENERIC_FIXMAP_H
+#define __ASM_GENERIC_FIXMAP_H
+
+#include <linux/bug.h>
+
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+
+#ifndef __ASSEMBLY__
+/*
+ * 'index to address' translation. If anyone tries to use the idx
+ * directly without translation, we catch the bug with a NULL-deference
+ * kernel oops. Illegal ranges of incoming indices are caught too.
+ */
+static __always_inline unsigned long fix_to_virt(const unsigned int idx)
+{
+	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
+	return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
+}
+
+/*
+ * Provide some reasonable defaults for page flags.
+ * Not all architectures use all of these different types and some
+ * architectures use different names.
+ */
+#ifndef FIXMAP_PAGE_NORMAL
+#define FIXMAP_PAGE_NORMAL PAGE_KERNEL
+#endif
+#ifndef FIXMAP_PAGE_NOCACHE
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
+#endif
+#ifndef FIXMAP_PAGE_IO
+#define FIXMAP_PAGE_IO PAGE_KERNEL_IO
+#endif
+#ifndef FIXMAP_PAGE_CLEAR
+#define FIXMAP_PAGE_CLEAR __pgprot(0)
+#endif
+
+#ifndef set_fixmap
+#define set_fixmap(idx, phys)				\
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NORMAL)
+#endif
+
+#ifndef clear_fixmap
+#define clear_fixmap(idx)			\
+	__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
+#endif
+
+/* Return a pointer with offset calculated */
+#define __set_fixmap_offset(idx, phys, flags)		      \
+({							      \
+	unsigned long addr;				      \
+	__set_fixmap(idx, phys, flags);			      \
+	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
+	addr;						      \
+})
+
+#define set_fixmap_offset(idx, phys) \
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
+
+/*
+ * Some hardware wants to get fixmapped without caching.
+ */
+#define set_fixmap_nocache(idx, phys) \
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE)
+
+#define set_fixmap_offset_nocache(idx, phys) \
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE)
+
+/*
+ * Some fixmaps are for IO
+ */
+#define set_fixmap_io(idx, phys) \
+	__set_fixmap(idx, phys, FIXMAP_PAGE_IO)
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_GENERIC_FIXMAP_H */
-- 
1.8.3.1
