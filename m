Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 11:59:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53705 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014850AbcAVK6pCXN-h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 11:58:45 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id B9695A18E0012;
        Fri, 22 Jan 2016 10:58:37 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 22 Jan 2016 10:58:39 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 22 Jan 2016 10:58:38 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: I6400: Icache fills from dcache
Date:   Fri, 22 Jan 2016 10:58:26 +0000
Message-ID: <1453460306-8505-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51301
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

Coherence Manager 3 (CM3) as present in I6400 can fill icache lines
effectively from dirty dcaches, so there is no need to flush dirty lines
from dcaches through to L2 prior to icache invalidation.

Set the MIPS_CACHE_IC_F_DC flag such that cpu_has_ic_fills_f_dc
evaluates to true, which avoids those dcache flushes.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index fc7289dfaf5a..69e7e5873af3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1311,6 +1311,7 @@ static void probe_pcache(void)
 		break;
 
 	case CPU_ALCHEMY:
+	case CPU_I6400:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 
-- 
2.4.10
