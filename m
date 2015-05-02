Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2015 21:10:21 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43703 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012126AbbEBTKEIriZ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2015 21:10:04 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D672ACC;
        Sat,  2 May 2015 19:09:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.0 036/220] MIPS: lose_fpu(): Disable FPU when MSA enabled
Date:   Sat,  2 May 2015 20:59:11 +0200
Message-Id: <20150502185855.946592485@linuxfoundation.org>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <20150502185854.333748961@linuxfoundation.org>
References: <20150502185854.333748961@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47201
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit acaf6a97d623af123314c2f8ce4cf7254f6b2fc1 upstream.

The lose_fpu() function only disables the FPU in CP0_Status.CU1 if the
FPU is in use and MSA isn't enabled.

This isn't necessarily a problem because KSTK_STATUS(current), the
version of CP0_Status stored on the kernel stack on entry from user
mode, does always get updated and gets restored when returning to user
mode, but I don't think it was intended, and it is inconsistent with the
case of only the FPU being in use. Sometimes leaving the FPU enabled may
also mask kernel bugs where FPU operations are executed when the FPU
might not be enabled.

So lets disable the FPU in the MSA case too.

Fixes: 33c771ba5c5d ("MIPS: save/disable MSA in lose_fpu")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9323/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/fpu.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -170,6 +170,7 @@ static inline void lose_fpu(int save)
 		}
 		disable_msa();
 		clear_thread_flag(TIF_USEDMSA);
+		__disable_fpu();
 	} else if (is_fpu_owner()) {
 		if (save)
 			_save_fp(current);
