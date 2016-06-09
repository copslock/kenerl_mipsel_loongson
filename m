Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 11:52:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19742 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040981AbcFIJvLwMfSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 11:51:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D0F7A9A4B598D;
        Thu,  9 Jun 2016 10:51:01 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 10:51:04 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 2/4] MIPS: KVM: Include bit 31 in segment matches
Date:   Thu, 9 Jun 2016 10:50:44 +0100
Message-ID: <1465465846-31918-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
References: <1465465846-31918-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53912
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

When faulting guest addresses are matched against guest segments with
the KVM_GUEST_KSEGX() macro, change the mask to 0xe0000000 so as to
include bit 31.

This is mainly for safety's sake, as it prevents a rogue BadVAddr in the
host kseg2/kseg3 segments (e.g. 0xC*******) after a TLB exception from
matching the guest kseg0 segment (e.g. 0x4*******), triggering an
internal KVM error instead of allowing the corresponding guest kseg0
page to be mapped into the host vmalloc space.

Such a rogue BadVAddr was observed to happen with the host MIPS kernel
running under QEMU with KVM built as a module, due to a not entirely
transparent optimisation in the QEMU TLB handling. This has already been
worked around properly in a previous commit.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2d5bb133d11a..36a391d289aa 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -74,7 +74,7 @@
 #define KVM_GUEST_KUSEG			0x00000000UL
 #define KVM_GUEST_KSEG0			0x40000000UL
 #define KVM_GUEST_KSEG23		0x60000000UL
-#define KVM_GUEST_KSEGX(a)		((_ACAST32_(a)) & 0x60000000)
+#define KVM_GUEST_KSEGX(a)		((_ACAST32_(a)) & 0xe0000000)
 #define KVM_GUEST_CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
 
 #define KVM_GUEST_CKSEG0ADDR(a)		(KVM_GUEST_CPHYSADDR(a) | KVM_GUEST_KSEG0)
-- 
2.4.10
