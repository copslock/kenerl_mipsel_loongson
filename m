Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2016 12:01:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13507 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992236AbcINKBPAIs2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2016 12:01:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 40D6578CDF92B;
        Wed, 14 Sep 2016 11:00:55 +0100 (IST)
Received: from localhost (10.100.200.175) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 14 Sep
 2016 11:00:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 1/2] cpu/hotplug: Include linux/types.h in linux/cpuhotplug.h
Date:   Wed, 14 Sep 2016 11:00:26 +0100
Message-ID: <20160914100027.20945-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55138
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

The linux/cpuhotplug.h header makes use of the bool type, but wasn't
including linux/types.h to ensure that type has been defined. Fix this
by including linux/types.h in preparation for including
linux/cpuhotplug.h in a file that doesn't do so already.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 include/linux/cpuhotplug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 242bf53..34bd805 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -1,6 +1,8 @@
 #ifndef __CPUHOTPLUG_H
 #define __CPUHOTPLUG_H
 
+#include <linux/types.h>
+
 enum cpuhp_state {
 	CPUHP_OFFLINE,
 	CPUHP_CREATE_THREADS,
-- 
2.9.3
