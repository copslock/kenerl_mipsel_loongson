Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 14:34:37 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36420 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008723AbaIKMeNxOih2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 14:34:13 +0200
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1XS3ZZ-0006Jq-Vt; Thu, 11 Sep 2014 13:34:02 +0100
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1XS3ZT-0004Kk-2f; Thu, 11 Sep 2014 13:33:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Florian Fainelli" <florian@openwrt.org>, david.daney@cavium.com,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Thu, 11 Sep 2014 13:32:13 +0100
Message-ID: <lsq.1410438733.444243504@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 096/131] MIPS: perf: Fix build error caused by unused
 counters_per_cpu_to_total()
In-Reply-To: <lsq.1410438733.176537304@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian@openwrt.org>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/perf_event_mipsxx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index f29099b..eb5e394 100644
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
 
