Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2017 18:44:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57055 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993097AbdACRnZSbVPT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jan 2017 18:43:25 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4AD274A3098FC;
        Tue,  3 Jan 2017 17:43:15 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 3 Jan 2017 17:43:18 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, <stable@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/2] KVM: MIPS: Don't clobber CP0_Status.UX
Date:   Tue, 3 Jan 2017 17:43:00 +0000
Message-ID: <c0a847bb2d9b3bb7955a36d6c76e728a6dbe1eb6.1483464823.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.cdddb6fe1a787c96c57358e404931f87f547e5e5.1483464823.git-series.james.hogan@imgtec.com>
References: <cover.cdddb6fe1a787c96c57358e404931f87f547e5e5.1483464823.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56146
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

On 64-bit kernels, MIPS KVM will clear CP0_Status.UX to prevent the
guest (running in user mode) from accessing the 64-bit memory segments.
However the previous value of CP0_Status.UX is never restored when
exiting from the guest.

If the user process uses 64-bit addressing (the n64 ABI) this can result
in address error exceptions from the kernel if it needs to deliver a
signal before returning to user mode, as the kernel will need to write a
sigframe to high user addresses on the user stack which are disallowed
by CP0_Status.UX=0.

This is fixed by explicitly setting SX and UX again when exiting from
the guest, and explicitly clearing those bits when returning to the
guest. Having the SX and UX bits set when handling guest exits (rather
than only when exiting to userland) will be helpful when we support VZ,
since we shouldn't need to directly read or write guest memory, so it
will be valid for cache management IPIs to access host user addresses.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 4.8.x-
---
 arch/mips/kvm/entry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 6a02b3a3fa65..e92fb190e2d6 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -521,6 +521,9 @@ void *kvm_mips_build_exit(void *addr)
 	uasm_i_and(&p, V0, V0, AT);
 	uasm_i_lui(&p, AT, ST0_CU0 >> 16);
 	uasm_i_or(&p, V0, V0, AT);
+#ifdef CONFIG_64BIT
+	uasm_i_ori(&p, V0, V0, ST0_SX | ST0_UX);
+#endif
 	uasm_i_mtc0(&p, V0, C0_STATUS);
 	uasm_i_ehb(&p);
 
@@ -643,7 +646,7 @@ static void *kvm_mips_build_ret_to_guest(void *addr)
 
 	/* Setup status register for running guest in UM */
 	uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
-	UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX));
+	UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX | ST0_SX | ST0_UX));
 	uasm_i_and(&p, V1, V1, AT);
 	uasm_i_mtc0(&p, V1, C0_STATUS);
 	uasm_i_ehb(&p);
-- 
git-series 0.8.10
