Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 12:20:17 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:50882 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992028AbcJNKUL3YXBI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 12:20:11 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id A252823C9C8C9;
        Fri, 14 Oct 2016 11:20:02 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 14 Oct 2016
 11:20:05 +0100
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 14 Oct 2016 11:20:04 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <stable@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: IP22: Fix build error in IP22 cache code
Date:   Fri, 14 Oct 2016 11:19:57 +0100
Message-ID: <1476440397-13042-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Recent MIPS toolchains complain about the use of an immediate larger
than 32bits when compiling a 32bit kernel, leading to the following
build failure:
{standard input}: Assembler messages:
{standard input}:131: Error: number (0x9000000080000000) larger than 32
bits
{standard input}:154: Error: number (0x9000000080000000) larger than 32
bits
{standard input}:191: Error: number (0x9000000080000000) larger than 32
bits

Fix this by specifying registers are 64bit via the .set gp=64 directive.

Since IP22 is the default MIPS machine, this is causing allnoconfig
build failures.

Fixes: 1da177e4c3f4
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Cc: stable@vger.kernel.org
---

 arch/mips/mm/sc-ip22.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/sc-ip22.c b/arch/mips/mm/sc-ip22.c
index 026cb59a914d..6551ca37d308 100644
--- a/arch/mips/mm/sc-ip22.c
+++ b/arch/mips/mm/sc-ip22.c
@@ -35,6 +35,7 @@ static inline void indy_sc_wipe(unsigned long first, unsigned long last)
 	".set\tnoreorder\n\t"
 	".set\tmips3\n\t"
 	".set\tnoat\n\t"
+	".set\tgp=64\n\t"
 	"mfc0\t%2, $12\n\t"
 	"li\t$1, 0x80\t\t\t# Go 64 bit\n\t"
 	"mtc0\t$1, $12\n\t"
-- 
2.7.4
