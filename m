Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 23:50:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22632 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFBVuMYQXdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 23:50:12 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1E12550C73F3E;
        Fri,  2 Jun 2017 22:50:02 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 22:50:06
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/7] MIPS: CM: WARN on attempt to lock invalid VP, not BUG
Date:   Fri, 2 Jun 2017 14:48:51 -0700
Message-ID: <20170602214856.4545-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602214856.4545-1-paul.burton@imgtec.com>
References: <20170602214856.4545-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58157
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

Rather than using BUG_ON in the case of an invalid attempt to lock
access to a non-zero VP on a pre-CM3 system, use WARN_ON so that we have
even the slightest chance of recovery.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/mips-cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 99bb74dd12ce..cb0c57f860d4 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -282,7 +282,7 @@ void mips_cm_lock_other(unsigned int core, unsigned int vp)
 		spin_lock_irqsave(this_cpu_ptr(&cm_core_lock),
 				  *this_cpu_ptr(&cm_core_lock_flags));
 	} else {
-		BUG_ON(vp != 0);
+		WARN_ON(vp != 0);
 
 		/*
 		 * We only have a GCR_CL_OTHER per core in systems with
-- 
2.13.0
