Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:38:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15429 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043855AbcFWQfEy38sz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:04 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4A8CEC4121F98;
        Thu, 23 Jun 2016 17:34:55 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 11/14] MIPS: KVM: Drop redundant restore of DDATA_LO
Date:   Thu, 23 Jun 2016 17:34:44 +0100
Message-ID: <1466699687-24791-12-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54148
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

On return from the exit handler to the host (without re-entering the
guest) we restore the saved value of the DDATA_LO register which we use
as a scratch register. However we've already restored it ready for
calling the exit handler so there is no need to do it again, so drop
that code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/entry.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 53e1e576d18a..6395bfa7e542 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -581,10 +581,6 @@ static void *kvm_mips_build_ret_to_host(void *addr)
 	UASM_i_LW(&p, K1, offsetof(struct kvm_vcpu_arch, host_stack), K1);
 	uasm_i_addiu(&p, K1, K1, -(int)sizeof(struct pt_regs));
 
-	/* Restore host DDATA_LO */
-	UASM_i_LW(&p, K0, offsetof(struct pt_regs, cp0_epc), K1);
-	uasm_i_mtc0(&p, K0, C0_DDATA_LO);
-
 	/*
 	 * r2/v0 is the return code, shift it down by 2 (arithmetic)
 	 * to recover the err code
-- 
2.4.10
