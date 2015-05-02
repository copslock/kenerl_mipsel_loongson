Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2015 21:41:12 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026406AbbEBTlJXHBJZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2015 21:41:09 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44BF58B4;
        Sat,  2 May 2015 19:41:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.14 15/92] MIPS: Hibernate: flush TLB entries earlier
Date:   Sat,  2 May 2015 21:02:30 +0200
Message-Id: <20150502190111.486876081@linuxfoundation.org>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <20150502190109.683061482@linuxfoundation.org>
References: <20150502190109.683061482@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47216
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

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit a843d00d038b11267279e3b5388222320f9ddc1d upstream.

We found that TLB mismatch not only happens after kernel resume, but
also happens during snapshot restore. So move it to the beginning of
swsusp_arch_suspend().

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/9621/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/power/hibernate.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
 END(swsusp_arch_suspend)
 
 LEAF(swsusp_arch_resume)
+	/* Avoid TLB mismatch during and after kernel resume */
+	jal local_flush_tlb_all
 	PTR_L t0, restore_pblist
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
@@ -43,7 +45,6 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
-	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
