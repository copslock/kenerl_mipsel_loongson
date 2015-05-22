Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:56:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11372 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013269AbbEVPzbrNkPJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:55:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C539FC5E0949;
        Fri, 22 May 2015 16:55:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:55:28 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:55:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 13/15] MIPS: malta: remove nonsense memory limit
Date:   Fri, 22 May 2015 16:51:12 +0100
Message-ID: <1432309875-9712-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47563
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

This cap of Malta memory size to 0x7fff0000 was added by commit
e6ca4e5bf114 "MIPS: malta: malta-memory: Add support for the 'ememsize'
variable" as part of support for EVA, with only the cryptic comment
"Last 64K for HIGHMEM arithmetics". However

  - EVA is used to avoid highmem, both are not enabled at once which
    makes the comment about highmem macros nonsensical.

  - I can think of no good reason for it, and nor could anyone else I
    asked.

So remove this memsize limit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mti-malta/malta-memory.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 5660cd6..831f583 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -94,10 +94,6 @@ void __init fw_meminit(void)
 	else
 		memsize = physical_memsize;
 
-	/* Last 64K for HIGHMEM arithmetics */
-	if (memsize > 0x7fff0000)
-		memsize = 0x7fff0000;
-
 	add_memory_region(PHYS_OFFSET, 0x00001000, BOOT_MEM_RESERVED);
 
 	/*
-- 
2.4.1
