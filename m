Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 15:51:06 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:49432 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992773AbeEONu5j6WBr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2018 15:50:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=241AJ8mZnNdwNghCTp5VQpExXzFZjtVD6a1xq4IGSGs=; b=NkqJSWpZQIhOehECjJfglY9CNj
        IC3v8m5nu34GSlMvgGQlZeajW2xiukvkdYfSo+DLKOHIP1OUcnGrjsKR9t7dWy3gzdUU3Qr2KRDGm
        9jyTq54s5EVnOslEXaExAzByY+XqGZoDLOTftVSBOtJMhL/a6KuYD+cNkWB8Tl8JKR6w/BEvrtMr9
        vRd13nHVGmVRGMeyJ8fP/cILrN1t6eO/mt2cCkmRJTEIGRir3do1x+iGOtEzgxDYuZXxflApOf+yn
        DkU4cAgHa2OnhuGLy1cb0on1J3hLb69km73+J/IvRWXI7FnXY2WapB7k1Jn0pxj+9MOeraSYmNDcD
        cZUb+4dA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43216 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fIaLp-003Ty9-AO; Tue, 15 May 2018 13:50:50 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH -next] signal/mips: Report FPE_FLTUNK for undiagnosed floating point exceptions
Date:   Tue, 15 May 2018 06:50:47 -0700
Message-Id: <1526392247-25512-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Most mips builds fail with

arch/mips/kernel/traps.c: In function ‘force_fcr31_sig’:
arch/mips/kernel/traps.c:732:2: error:
	‘si_code’ may be used uninitialized in this function

Fix the problem by initializing si_code with FPE_FLTUNK (undiagnosed
floating point exception).

Fixes: f43a54a0d916 ("signal/mips: Use force_sig_fault where appropriate")
Cc: linux-mips@linux-mips.org
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Feel free to merge into the patch introducing the problem.

 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 66ec4b0b484d..d67fa74622ee 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -716,7 +716,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk)
 {
-	int si_code;
+	int si_code = FPE_FLTUNK;
 
 	if (fcr31 & FPU_CSR_INV_X)
 		si_code = FPE_FLTINV;
-- 
2.7.4
