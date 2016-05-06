Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:37:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12452 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028084AbcEFNgjaT0Lk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:39 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 71BDA8C6863F1;
        Fri,  6 May 2016 14:36:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:32 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 2/7] MIPS: Add & use CP0_EntryHi ASID definitions
Date:   Fri, 6 May 2016 14:36:19 +0100
Message-ID: <1462541784-22128-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53292
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

Add definitions for the ASID field in CP0_EntryHi (along with the soon
to be used ASIDX field), and use them in a few previously hardcoded
cases.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/mipsregs.h | 2 ++
 arch/mips/kernel/genex.S         | 2 +-
 arch/mips/kvm/locore.S           | 4 ++--
 arch/mips/pci/pci-alchemy.c      | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 3ad19ad04d8a..d4c76e7f9a56 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -229,6 +229,8 @@
 
 /* MIPS32/64 EntryHI bit definitions */
 #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
+#define MIPS_ENTRYHI_ASIDX	(_ULCAST_(0x3) << 8)
+#define MIPS_ENTRYHI_ASID	(_ULCAST_(0xff) << 0)
 
 /*
  * R4x00 interrupt enable / cause bits
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index baa7b6fc0a60..17374aef6f00 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -455,7 +455,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	noreorder
 	/* check if TLB contains a entry for EPC */
 	MFC0	k1, CP0_ENTRYHI
-	andi	k1, 0xff	/* ASID_MASK */
+	andi	k1, MIPS_ENTRYHI_ASID
 	MFC0	k0, CP0_EPC
 	PTR_SRL k0, _PAGE_SHIFT + 1
 	PTR_SLL k0, _PAGE_SHIFT + 1
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index c24facc85357..308706493fd5 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -164,7 +164,7 @@ FEXPORT(__kvm_mips_load_asid)
 	INT_SLL	t2, t2, 2                   /* x4 */
 	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
-	andi	k0, k0, 0xff
+	andi	k0, k0, MIPS_ENTRYHI_ASID
 	mtc0	k0, CP0_ENTRYHI
 	ehb
 
@@ -483,7 +483,7 @@ __kvm_mips_return_to_guest:
 	INT_SLL	t2, t2, 2		/* x4 */
 	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
-	andi	k0, k0, 0xff
+	andi	k0, k0, MIPS_ENTRYHI_ASID
 	mtc0	k0, CP0_ENTRYHI
 	ehb
 
diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index 28952637a862..c8994c156e2d 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -76,7 +76,7 @@ static void mod_wired_entry(int entry, unsigned long entrylo0,
 	unsigned long old_ctx;
 
 	/* Save old context and create impossible VPN2 value */
-	old_ctx = read_c0_entryhi() & 0xff;
+	old_ctx = read_c0_entryhi() & MIPS_ENTRYHI_ASID;
 	old_pagemask = read_c0_pagemask();
 	write_c0_index(entry);
 	write_c0_pagemask(pagemask);
-- 
2.4.10
