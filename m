Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:34:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7505 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992514AbdAFBdfrGxgu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0EF0865455831;
        Fri,  6 Jan 2017 01:33:29 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/30] mm: Export init_mm for MIPS KVM use of pgd_alloc()
Date:   Fri, 6 Jan 2017 01:32:33 +0000
Message-ID: <a8df39719fb0570cb38e3fbb5c128fe2618e92d6.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Export the init_mm symbol to GPL modules so that MIPS KVM can use
pgd_alloc() to create GVA page directory tables for trap & emulate mode,
which runs guest code in user mode. On MIPS pgd_alloc() is implemented
inline and refers to init_mm in order to copy kernel address space
mappings into the new page directory.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 mm/init-mm.c | 2 ++
 1 file changed, 2 insertions(+), 0 deletions(-)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 975e49f00f34..94aae08b41e1 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,3 +1,4 @@
+#include <linux/export.h>
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
 #include <linux/rwsem.h>
@@ -25,3 +26,4 @@ struct mm_struct init_mm = {
 	.user_ns	= &init_user_ns,
 	INIT_MM_CONTEXT(init_mm)
 };
+EXPORT_SYMBOL_GPL(init_mm);
-- 
git-series 0.8.10
