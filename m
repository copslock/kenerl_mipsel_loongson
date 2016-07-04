Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:37:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61821 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992325AbcGDSfkek3U7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 29282BFEA010B;
        Mon,  4 Jul 2016 19:35:31 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 4/9] MIPS: KVM: Fix pre-r6 ll/sc instructions on r6
Date:   Mon, 4 Jul 2016 19:35:10 +0100
Message-ID: <1467657315-19975-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54203
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

The atomic KVM register access macros in kvm_host.h (for the guest Cause
register with KVM in trap & emulate mode) use ll/sc instructions,
however they still .set mips3, which causes pre-MIPSr6 instruction
encodings to be emitted, even for a MIPSr6 build.

Fix it to use MIPS_ISA_ARCH_LEVEL as other parts of arch/mips already
do.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index b32785543787..b54bcadd8aec 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -400,7 +400,7 @@ static inline void _kvm_atomic_set_c0_guest_reg(unsigned long *reg,
 	unsigned long temp;
 	do {
 		__asm__ __volatile__(
-		"	.set	mips3				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 		"	" __LL "%0, %1				\n"
 		"	or	%0, %2				\n"
 		"	" __SC	"%0, %1				\n"
@@ -416,7 +416,7 @@ static inline void _kvm_atomic_clear_c0_guest_reg(unsigned long *reg,
 	unsigned long temp;
 	do {
 		__asm__ __volatile__(
-		"	.set	mips3				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 		"	" __LL "%0, %1				\n"
 		"	and	%0, %2				\n"
 		"	" __SC	"%0, %1				\n"
@@ -433,7 +433,7 @@ static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
 	unsigned long temp;
 	do {
 		__asm__ __volatile__(
-		"	.set	mips3				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 		"	" __LL "%0, %1				\n"
 		"	and	%0, %2				\n"
 		"	or	%0, %3				\n"
-- 
2.4.10
