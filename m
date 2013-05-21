Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 22:55:35 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:54327 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835040Ab3EUUzJQOgC4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 22:55:09 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq12so1106007pab.12
        for <multiple recipients>; Tue, 21 May 2013 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0R16bW0lbSIsswX9ItZDifatSI+Hxzx7fnGKYx4ks9I=;
        b=JN3zoS+JsZr4dxn5X14KLVex2qcb3ZP1DAwPr5gmyOKETN5YxblUakMZPQPX99SkSS
         ykZHFJ6mFsNYpdZJHHJk7uUxn2DDCOFfJZmUtd1ZdbCNomnvH2IcHuvArx15ULU48pWQ
         ZGjNIMRoBZ+4eTHZIZaTUCJV/Ru9LSZRwdX1yP0Nr+xCzaVPpXqZYvVejQ4H8oqjl/R0
         8yxraGZoZkpdpatc1mMRG8NlRRk6EUk9fSYQxk7b3/N60lAbjHuJHrF+MFe/54oi0hTJ
         7VA/DUUVsgEi1PEfogAB+JLTlbahqoG7MClstrho7DgJGfJPiyXpxu68Kd0UOKiGzLe4
         wRaQ==
X-Received: by 10.66.122.39 with SMTP id lp7mr4907495pab.208.1369169702501;
        Tue, 21 May 2013 13:55:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id zy5sm4017050pbb.43.2013.05.21.13.55.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 13:55:00 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4LKsxFV010487;
        Tue, 21 May 2013 13:54:59 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4LKsx8g010486;
        Tue, 21 May 2013 13:54:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v4 1/6] mips/kvm: Fix ABI for use of FPU.
Date:   Tue, 21 May 2013 13:54:50 -0700
Message-Id: <1369169695-10444-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Define a non-empty struct kvm_fpu.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
index 85789ea..0e8f565 100644
--- a/arch/mips/include/asm/kvm.h
+++ b/arch/mips/include/asm/kvm.h
@@ -1,11 +1,12 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Cavium, Inc.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #ifndef __LINUX_KVM_MIPS_H
 #define __LINUX_KVM_MIPS_H
@@ -31,8 +32,20 @@ struct kvm_regs {
 struct kvm_sregs {
 };
 
-/* for KVM_GET_FPU and KVM_SET_FPU */
+/*
+ * for KVM_GET_FPU and KVM_SET_FPU
+ *
+ * If Status[FR] is zero (32-bit FPU), the upper 32-bits of the FPRs
+ * are zero filled.
+ */
 struct kvm_fpu {
+	__u64 fpr[32];
+	__u32 fir;
+	__u32 fccr;
+	__u32 fexr;
+	__u32 fenr;
+	__u32 fcsr;
+	__u32 pad;
 };
 
 struct kvm_debug_exit_arch {
-- 
1.7.11.7
