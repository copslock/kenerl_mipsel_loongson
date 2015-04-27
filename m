Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 16:08:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53053 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026170AbbD0OHl0gunk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 16:07:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CF2164480D6F9;
        Mon, 27 Apr 2015 15:07:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Apr 2015 15:07:35 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 27 Apr 2015 15:07:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 2/4] MIPS: tlbex: Fix broken offsets on r2 without XPA
Date:   Mon, 27 Apr 2015 15:07:17 +0100
Message-ID: <1430143639-22580-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1430143639-22580-1-git-send-email-james.hogan@imgtec.com>
References: <1430143639-22580-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47090
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

Commit c5b367835cfc ("MIPS: Add support for XPA.") changed
build_pte_present() and build_pte_writable() to assume a constant offset
of _PAGE_READ and _PAGE_WRITE relative to _PAGE_PRESENT, however this is
no longer true for some MIPS32R2 builds since commit be0c37c985ed
("MIPS: Rearrange PTE bits into fixed positions.") which moved the
_PAGE_READ PTE bit away from the _PAGE_PRESENT bit, with the _PAGE_WRITE
bit falling into its place.

Make use of the _PAGE_READ and _PAGE_WRITE definitions to calculate the
correct mask to apply instead of hard coding 3 (for _PAGE_PRESENT |
_PAGE_READ) or 5 (for _PAGE_PRESENT | _PAGE_WRITE).

Fixes: c5b367835cfc ("MIPS: Add support for XPA.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
---
I hit a hang during boot on v4.1-rc1 KVM guest kernels, where its
continuously trying to service a TLB miss for a page which is apparently
_PAGE_READ but not _PAGE_WRITE, but since the TLBL handler
(build_pte_present()) ends up incorrectly testing _PAGE_WRITE, it just
keeps calling into C code instead of making the PTE valid and updating
the TLB entry.

The build_pte_present() part of this patch fixes it, but its still not
entirely clear to me why I cannot reproduce the problem in other MIPS R2
environments without RIXI.
---
 arch/mips/mm/tlbex.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 97c87027c17f..d998fea7fc93 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1623,8 +1623,10 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 		}
 	} else {
 		uasm_i_srl(p, t, pte, _PAGE_PRESENT_SHIFT);
-		uasm_i_andi(p, t, t, 3);
-		uasm_i_xori(p, t, t, 3);
+		uasm_i_andi(p, t, t,
+			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
+		uasm_i_xori(p, t, t,
+			(_PAGE_PRESENT | _PAGE_READ) >> _PAGE_PRESENT_SHIFT);
 		uasm_il_bnez(p, r, t, lid);
 		if (pte == t)
 			/* You lose the SMP race :-(*/
@@ -1654,8 +1656,10 @@ build_pte_writable(u32 **p, struct uasm_reloc **r,
 	int t = scratch >= 0 ? scratch : pte;
 
 	uasm_i_srl(p, t, pte, _PAGE_PRESENT_SHIFT);
-	uasm_i_andi(p, t, t, 5);
-	uasm_i_xori(p, t, t, 5);
+	uasm_i_andi(p, t, t,
+		    (_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT);
+	uasm_i_xori(p, t, t,
+		    (_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT);
 	uasm_il_bnez(p, r, t, lid);
 	if (pte == t)
 		/* You lose the SMP race :-(*/
-- 
2.0.5
