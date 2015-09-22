Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:44:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26849 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVSoghGsAP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:44:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 38D93352B6E80;
        Tue, 22 Sep 2015 19:44:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:44:30 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:44:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/6] MIPS: tidy EntryLo bit definitions, add PFN
Date:   Tue, 22 Sep 2015 11:42:51 -0700
Message-ID: <1442947373-13345-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
References: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Tidy up the definition of the EntryLo RI & XI bits using BITS_PER_LONG
rather than #ifdef'ing on CONFIG_64BIT, and add a definition for the
offset to the PFN field for use by a later patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mipsregs.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index d3cd8ea..76dbb38 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -126,15 +126,9 @@
 #define R3K_ENTRYLO_N		(_ULCAST_(1) << 11)
 
 /* MIPS32/64 EntryLo bit definitions */
-#ifdef CONFIG_64BIT
-/* as read by dmfc0 */
-#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 62)
-#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 63)
-#else
-/* as read by mfc0 */
-#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 30)
-#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 31)
-#endif
+#define MIPS_ENTRYLO_PFN_SHIFT	6
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << (BITS_PER_LONG - 2))
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << (BITS_PER_LONG - 1))
 
 /*
  * Values for PageMask register
-- 
2.5.3
