Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 19:05:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38415 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDURFVSrcVP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 19:05:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 10CFAED35637F;
        Thu, 21 Apr 2016 18:05:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 21 Apr 2016 18:05:15 +0100
Received: from localhost (10.100.200.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 21 Apr
 2016 18:05:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Michal Toman <michal.toman@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "stable # v4 . 3+" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: Prevent "restoration" of MSA context in non-MSA kernels
Date:   Thu, 21 Apr 2016 18:04:53 +0100
Message-ID: <1461258293-8863-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <alpine.DEB.2.00.1604211731030.21846@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1604211731030.21846@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

If a kernel doesn't support MSA context (ie. CONFIG_CPU_HAS_MSA=n) then
it will only keep 64 bits per FP register in thread context, and the
calls to set_fpr64 in restore_msa_extcontext will overrun the end of the
FP register context into the FCSR & MSACSR values. GCC 6.x has become
smart enough to detect this & complain like so:

    arch/mips/kernel/signal.c: In function 'protected_restore_fp_context':
    ./arch/mips/include/asm/processor.h:114:17: error: array subscript is above array bounds [-Werror=array-bounds]
      fpr->val##width[FPR_IDX(width, idx)] = val;   \
      ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
    ./arch/mips/include/asm/processor.h:118:1: note: in expansion of macro 'BUILD_FPR_ACCESS'
     BUILD_FPR_ACCESS(64)

The only way to trigger this code to run would be for a program to set
up an artificial extended MSA context structure following a sigframe &
execute sigreturn. Whilst this doesn't allow a program to write to any
state that it couldn't already, it makes little sense to allow this
"restoration" of MSA context in a system that doesn't support MSA.

Fix this by killing a program with SIGSYS if it tries something as crazy
as "restoring" fake MSA context in this way, also fixing the build error
& allowing for most of restore_msa_extcontext to be optimised out of
kernels without support for MSA.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: Michal Toman <michal.toman@imgtec.com>
Fixes: bf82cb30c7e5 ("MIPS: Save MSA extended context around signals")
Cc: James Hogan <james.hogan@imgtec.com>
Cc: stable <stable@vger.kernel.org> # v4.3+

---

Changes in v2:
- Prevent potential for malformed errno/signal from protected_restore_fp_context.

 arch/mips/kernel/signal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index bf792e2..fc7c1f0 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -195,6 +195,9 @@ static int restore_msa_extcontext(void __user *buf, unsigned int size)
 	unsigned int csr;
 	int i, err;
 
+	if (!config_enabled(CONFIG_CPU_HAS_MSA))
+		return SIGSYS;
+
 	if (size != sizeof(*msa))
 		return -EINVAL;
 
@@ -398,8 +401,8 @@ int protected_restore_fp_context(void __user *sc)
 	}
 
 fp_done:
-	if (used & USED_EXTCONTEXT)
-		err |= restore_extcontext(sc_to_extcontext(sc));
+	if (!err && (used & USED_EXTCONTEXT))
+		err = restore_extcontext(sc_to_extcontext(sc));
 
 	return err ?: sig;
 }
-- 
2.8.0
