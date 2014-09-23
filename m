Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 04:40:49 +0200 (CEST)
Received: from mail.kernel.org ([198.145.19.201]:32965 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006813AbaIWCkrgswsV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Sep 2014 04:40:47 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 833642021A;
        Tue, 23 Sep 2014 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AEF201FA;
        Tue, 23 Sep 2014 02:40:34 +0000 (UTC)
From:   Zefan Li <lizf@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>,
        linux-mips@linux-mips.org, david.daney@cavium.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 35/45] MIPS: perf: Fix build error caused by unused counters_per_cpu_to_total()
Date:   Tue, 23 Sep 2014 10:31:37 +0800
Message-Id: <1411439507-30391-35-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1411439259-30224-1-git-send-email-lizf@kernel.org>
References: <1411439259-30224-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: Florian Fainelli <florian@openwrt.org>

3.4.104-rc1 review patch.  If anyone has any objections, please let me know.

------------------

commit 6c37c9580409af7dc664bb6af0a85d540d63aeea upstream.

cc1: warnings being treated as errors
arch/mips/kernel/perf_event_mipsxx.c:166: error: 'counters_per_cpu_to_total' defined but not used
make[2]: *** [arch/mips/kernel/perf_event_mipsxx.o] Error 1
make[2]: *** Waiting for unfinished jobs....

It was first introduced by 82091564cfd7ab8def42777a9c662dbf655c5d25 [MIPS:
perf: Add support for 64-bit perf counters.] in 3.2.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: david.daney@cavium.com
Patchwork: https://patchwork.linux-mips.org/patch/3357/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/kernel/perf_event_mipsxx.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 811084f..52f60e5 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -162,11 +162,6 @@ static unsigned int counters_total_to_per_cpu(unsigned int counters)
 	return counters >> vpe_shift();
 }
 
-static unsigned int counters_per_cpu_to_total(unsigned int counters)
-{
-	return counters << vpe_shift();
-}
-
 #else /* !CONFIG_MIPS_MT_SMP */
 #define vpe_id()	0
 
-- 
1.7.9.5
