Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 12:46:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15827 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992172AbcHaKpDcNr7D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 12:45:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3F1F21BCD41E5;
        Wed, 31 Aug 2016 11:44:45 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 Aug 2016 11:44:47 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 04/10] MIPS: pm-cps: Remove I6400 sync types
Date:   Wed, 31 Aug 2016 11:44:33 +0100
Message-ID: <1472640279-26593-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54887
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

Commit 4e88a8621301 ("MIPS: Add cases for CPU_I6400") added a case for
I6400 to the selection of lightweight sync types, but these are not
implemented. Remove the case.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/pm-cps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 2faa227a032e..c6b9ad2256f0 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -674,7 +674,6 @@ static int __init cps_pm_init(void)
 	case CPU_PROAPTIV:
 	case CPU_M5150:
 	case CPU_P5600:
-	case CPU_I6400:
 		stype_intervention = 0x2;
 		stype_memory = 0x3;
 		stype_ordering = 0x10;
-- 
2.7.4
