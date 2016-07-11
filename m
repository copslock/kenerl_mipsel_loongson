Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 22:24:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60734 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992880AbcGKUYCRn4Q0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 22:24:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 254C435C7F0A3;
        Mon, 11 Jul 2016 21:23:42 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 11 Jul 2016 21:23:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v2 01/12] MIPS: Fix definition of KSEGX() for 64-bit
Date:   Mon, 11 Jul 2016 21:23:40 +0100
Message-ID: <1468268620-8600-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54291
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

The KSEGX() macro is defined to 32-bit sign extend the address argument
and logically AND the result with 0xe0000000, with the final result
usually compared against one of the CKSEG macros. However the literal
0xe0000000 is unsigned as the high bit is set, and is therefore
zero-extended on 64-bit kernels, resulting in the sign extension bits of
the argument being masked to zero. This results in the odd situation
where:

  KSEGX(CKSEG0) != CKSEG0
  (0xffffffff80000000 & 0x00000000e0000000) != 0xffffffff80000000)

Fix this by 32-bit sign extending the 0xe0000000 literal using
_ACAST32_.

This will help some MIPS KVM code handling 32-bit guest addresses to
work on 64-bit host kernels, but will also affect a couple of other
users:

- KSEGX in dec_kn01_be_backend() on a 64-bit DECstation kernel. Maciej
  has confirmed this is not a valid combination.

- The SiByte DMA page ops KSEGX check in clear_page() and copy_page() on
  64-bit SB1 kernels, which appears not to be designed with 64-bit
  segments in mind anyway. This would (perhaps unintentionally) have
  always fallen back to the CPU copy on 64-bit kernels anyway, so we
  make this explicit by making CONFIG_SIBYTE_DMA_PAGEOPS depend on
  32BIT, so the change of KSEGX behaviour can't break anything.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v2:
- Clarify that the DEC code in question shouldn't get used with 64-bit
  kernels (thanks Maciej).
- Make SIBYTE_DMA_PAGEOPS depend on 32BIT so the dependence is explicit
  and so we don't break anything.
- Correct CKSEG -> CKSEG0 in patch description.
---
 arch/mips/Kconfig                 | 2 +-
 arch/mips/include/asm/addrspace.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac91939b9b75..86a9abd398f5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2195,7 +2195,7 @@ config RM7000_CPU_SCACHE
 
 config SIBYTE_DMA_PAGEOPS
 	bool "Use DMA to clear/copy pages"
-	depends on CPU_SB1
+	depends on CPU_SB1 && 32BIT
 	help
 	  Instead of using the CPU to zero and copy pages, use a Data Mover
 	  channel.  These DMA channels are otherwise unused by the standard
diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 3b0e51d5a613..c5b04e752e97 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -45,7 +45,7 @@
 /*
  * Returns the kernel segment base of a given address
  */
-#define KSEGX(a)		((_ACAST32_ (a)) & 0xe0000000)
+#define KSEGX(a)		((_ACAST32_(a)) & _ACAST32_(0xe0000000))
 
 /*
  * Returns the physical address of a CKSEGx / XKPHYS address
-- 
2.4.10
