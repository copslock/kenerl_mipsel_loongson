Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 23:45:58 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47963 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008130AbaLEWp4F0Pvv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 23:45:56 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 81B33934;
        Fri,  5 Dec 2014 22:45:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.17 010/122] MIPS: tlbex: Fix potential HTW race on TLBL/M/S handlers
Date:   Fri,  5 Dec 2014 14:43:04 -0800
Message-Id: <20141205223307.055708941@linuxfoundation.org>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <20141205223305.514276242@linuxfoundation.org>
References: <20141205223305.514276242@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44593
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

3.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

commit 070e76cb3ffe43f6855492e77c96680c562598f0 upstream.

There is a potential race when probing the TLB in TLBL/M/S exception
handlers for a matching entry. Between the time we hit a TLBL/S/M
exception and the time we get to execute the TLBP instruction, the
HTW may have replaced the TLB entry we are interested in hence the TLB
probe may fail. However, in the existing handlers, we never checked the
status of the TLBP (ie check the result in the C0/Index register). We
fix this by adding such a check when the core implements the HTW. If
we couldn't find a matching entry, we return back and try again.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8599/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/tlbex.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1872,8 +1872,16 @@ build_r4000_tlbchange_handler_head(u32 *
 	uasm_l_smp_pgtable_change(l, *p);
 #endif
 	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
-	if (!m4kc_tlbp_war())
+	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
+		if (cpu_has_htw) {
+			/* race condition happens, leaving */
+			uasm_i_ehb(p);
+			uasm_i_mfc0(p, wr.r3, C0_INDEX);
+			uasm_il_bltz(p, r, wr.r3, label_leave);
+			uasm_i_nop(p);
+		}
+	}
 	return wr;
 }
 
