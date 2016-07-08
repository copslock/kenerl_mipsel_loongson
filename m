Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:56:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4154 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992821AbcGHKyE12lXv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:54:04 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E97F23AF6149A;
        Fri,  8 Jul 2016 11:53:45 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 01/12] MIPS: Fix definition of KSEGX() for 64-bit
Date:   Fri, 8 Jul 2016 11:53:20 +0100
Message-ID: <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54265
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

  KSEGX(CKSEG) != CKSEG
  (0xffffffff80000000 & 0x00000000e0000000) != 0xffffffff80000000)

Fix this by 32-bit sign extending the 0xe0000000 literal using
_ACAST32_.

This will help some MIPS KVM code handling 32-bit guest addresses to
work on 64-bit host kernels, but will also affect KSEGX in
dec_kn01_be_backend() on a 64-bit DECstation kernel, and the SiByte DMA
page ops KSEGX check in clear_page() and copy_page() on 64-bit SB1
kernels, neither of which appear to be designed with 64-bit segments in
mind anyway.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
For the SiByte optimisations in arch/mips/mm/page.c, the KSEGX condition
looks slightly questionable anyway - is it acceptable to 32-bit sign
extend the pointer in that case before the comparison. Currently the
effect of the zero-extended 0xe0000000 is to prevent the optimisation
from happening on 64-bit kernels. Will this patch cause breakage due to
the pointer possibly being in some other 64-bit segment and the
optimisation suddenly being enabled?

As for the DEC bus error handling usage, it doesn't seem to take 64-bit
addresses into account anyway (which get 32-bit sign extended by KSEGX).
The effect of the zero-extended 0xe0000000 is to cause the TLB lookup
code to always take place with no TLB presence check, which seems
already broken.
---
 arch/mips/include/asm/addrspace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
