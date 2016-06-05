Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 00:26:54 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:32946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042507AbcFEWY5tjkIj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 00:24:57 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3BCF2C;
        Sun,  5 Jun 2016 22:24:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Michal Toman <michal.toman@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.5 017/128] MIPS: Prevent "restoration" of MSA context in non-MSA kernels
Date:   Sun,  5 Jun 2016 15:22:52 -0700
Message-Id: <20160605222321.758151709@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605222321.183131188@linuxfoundation.org>
References: <20160605222321.183131188@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53867
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

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 6533af4d4831c421cd9aa4dce7cfc19a3514cc09 upstream.

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
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Michal Toman <michal.toman@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13164/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/signal.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -195,6 +195,9 @@ static int restore_msa_extcontext(void _
 	unsigned int csr;
 	int i, err;
 
+	if (!config_enabled(CONFIG_CPU_HAS_MSA))
+		return SIGSYS;
+
 	if (size != sizeof(*msa))
 		return -EINVAL;
 
@@ -398,8 +401,8 @@ int protected_restore_fp_context(void __
 	}
 
 fp_done:
-	if (used & USED_EXTCONTEXT)
-		err |= restore_extcontext(sc_to_extcontext(sc));
+	if (!err && (used & USED_EXTCONTEXT))
+		err = restore_extcontext(sc_to_extcontext(sc));
 
 	return err ?: sig;
 }
