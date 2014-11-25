Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 13:40:55 +0100 (CET)
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:33253 "EHLO
        e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013690AbaKYMiuq4sRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 13:38:50 +0100
Received: from /spool/local
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Nov 2014 12:38:45 -0000
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp12.uk.ibm.com (192.168.101.142) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 25 Nov 2014 12:38:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1192F17D8066
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:58 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPCcg1l42860640
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:38:42 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAPCcd0o002127
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 05:38:42 -0700
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id sAPCcdOQ002098;
        Tue, 25 Nov 2014 05:38:39 -0700
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 58DE11224439; Tue, 25 Nov 2014 13:38:39 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-x86_64@vger.kernel.org, linux-s390"@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        torvalds@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2 02/10] kernel: Provide READ_ONCE and ASSIGN_ONCE
Date:   Tue, 25 Nov 2014 13:38:29 +0100
Message-Id: <1416919117-50652-3-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14112512-0009-0000-0000-000002213877
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Let's provide READ_ONCE/ASSIGN_ONCE that will do all accesses via
scalar types.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/compiler.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d5ad7b1..0ff01f2 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,6 +186,40 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
 #endif
 
+#include <linux/types.h>
+
+static __always_inline void __assign_once_size(volatile void *p, void *res, int size)
+{
+	switch (size) {
+	case 1: *(volatile u8 *)p = *(u8 *)res; break;
+	case 2: *(volatile u16 *)p = *(u16 *)res; break;
+	case 4: *(volatile u32 *)p = *(u32 *)res; break;
+#ifdef CONFIG_64BIT
+	case 8: *(volatile u64 *)p = *(u64 *)res; break;
+#endif
+       }
+}
+
+#define ASSIGN_ONCE(val, p) \
+      ({ typeof(p) __val; __val = val; __assign_once_size(&p, &__val, sizeof(__val)); __val; })
+
+
+static __always_inline void __read_once_size(volatile void *p, void *res, int size)
+{
+	switch (size) {
+	case 1: *(u8 *)res = *(volatile u8 *)p; break;
+	case 2: *(u16 *)res = *(volatile u16 *)p; break;
+	case 4: *(u32 *)res = *(volatile u32 *)p; break;
+#ifdef CONFIG_64BIT
+	case 8: *(u64 *)res = *(volatile u64 *)p; break;
+#endif
+       }
+}
+
+#define READ_ONCE(p) \
+      ({ typeof(p) __val; __read_once_size(&p, &__val, sizeof(__val)); __val; })
+
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
-- 
1.9.3
