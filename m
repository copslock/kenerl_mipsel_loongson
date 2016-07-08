Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 15:05:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9123 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992777AbcGHNFxEyhTV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 15:05:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 14ECD4D0195FE;
        Fri,  8 Jul 2016 14:05:34 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 14:05:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: uasm: Handle low values in uasm_in_compat_space_p()
Date:   Fri, 8 Jul 2016 14:05:26 +0100
Message-ID: <1467983126-30121-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54271
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

uasm_in_compat_space_p() determines whether the given value is in the
32-bit compatibility part of the 64-bit address space, i.e. is in 32-bit
sign-extended form, however it only handles the top half of the value
space (corresponding to the kernel compatibility segments in the upper
half of the address space). Since values < 2^31 (corresponding to the
low 2GiB of the address space) can also be handled using 32-bit
instructions (e.g. a LUI and ADDIU) rather than convoluted 64-bit
immediate generation, rewrite it with a cast to check whether the
address matches its 32-bit sign extended form.

This allows UASM_i_LA to be used to generate arbitrary 32-bit immediates
more efficiently on 64-bit CPUs, i.e. more like the li (load immediate)
pseudo-instruction.

For example this code to load the immediate (ST0_EXL | KSU_USER |
ST0_BEV | ST0_KX) into k0 with UASM_i_LA():

 lui        k0,0x0
 dsll       k0,k0,0x10
 daddiu     k0,k0,64
 dsll       k0,k0,0x10
 daddiu     k0,k0,146

Changes to this more efficient version:

 lui        k0,0x40
 addiu      k0,k0,146

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/uasm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index ad718debc35a..0b373405766a 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -370,11 +370,7 @@ UASM_EXPORT_SYMBOL(ISAFUNC(uasm_build_label));
 int ISAFUNC(uasm_in_compat_space_p)(long addr)
 {
 	/* Is this address in 32bit compat space? */
-#ifdef CONFIG_64BIT
-	return (((addr) & 0xffffffff00000000L) == 0xffffffff00000000L);
-#else
-	return 1;
-#endif
+	return addr == (int)addr;
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_in_compat_space_p));
 
-- 
2.4.10
