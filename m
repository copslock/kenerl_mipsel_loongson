Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:58:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60712 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992880AbcGHKyMRUJ3v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:54:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E00709324AD04;
        Fri,  8 Jul 2016 11:53:53 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 11/12] MIPS: KVM: Reset CP0_PageMask during host TLB flush
Date:   Fri, 8 Jul 2016 11:53:30 +0100
Message-ID: <1467975211-12674-12-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54270
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

KVM sometimes flushes host TLB entries, reading each one to check if it
corresponds to a guest KSeg0 address. In the absence of EntryHi.EHInv
bits to invalidate the whole entry, the entries will be set to unique
virtual addresses in KSeg0 (which is not TLB mapped), spaced 2*PAGE_SIZE
apart.

The TLB read however will clobber the CP0_PageMask register with
whatever page size that TLB entry had, and that same page size will be
written back into the TLB entry along with the unique address.

This would cause breakage when transparent huge pages are enabled on
64-bit host kernels, since huge page entries will overlap other nearby
entries when separated by only 2*PAGE_SIZE, causing a machine check
exception.

Fix this by restoring the old CP0_PageMask value (which should be set to
the normal page size) after reading the TLB entry if we're going to go
ahead and invalidate it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index f5f8c2acae53..254377d8e0b9 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -332,6 +332,8 @@ void kvm_mips_flush_host_tlb(int skip_kseg0)
 			/* Don't blow away guest kernel entries */
 			if (KVM_GUEST_KSEGX(entryhi) == KVM_GUEST_KSEG0)
 				continue;
+
+			write_c0_pagemask(old_pagemask);
 		}
 
 		/* Make sure all entries differ. */
-- 
2.4.10
