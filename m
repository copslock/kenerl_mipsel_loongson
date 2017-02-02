Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:06:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28618 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993902AbdBBMFBDa0bv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:01 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1FDF2A373CD08;
        Thu,  2 Feb 2017 12:04:52 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:04:54 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>
Subject: [PATCH v2 3/30] MIPS: uasm: Add include guards in asm/uasm.h
Date:   Thu, 2 Feb 2017 12:04:16 +0000
Message-ID: <4b7cf464ec3abd91714c5f48475f9f007c3bc269.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56592
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

Add include guards in asm/uasm.h to allow it to be safely used by a new
header asm/tlbex.h in the next patch to expose TLB exception building
functions for KVM to use.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/uasm.h | 5 +++++
 1 file changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index f7929f65f7ca..e9a9e2ade1d2 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -9,6 +9,9 @@
  * Copyright (C) 2012, 2013  MIPS Technologies, Inc.  All rights reserved.
  */
 
+#ifndef __ASM_UASM_H
+#define __ASM_UASM_H
+
 #include <linux/types.h>
 
 #ifdef CONFIG_EXPORT_UASM
@@ -309,3 +312,5 @@ void uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
 		 unsigned int reg2, int lid);
 void uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+
+#endif /* __ASM_UASM_H */
-- 
git-series 0.8.10
