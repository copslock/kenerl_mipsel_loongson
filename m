Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:31:32 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36775
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011135AbaJJW3SZSAZ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:18 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 08/10] MIPS: lantiq: the detection of the gpe clock is broken
Date:   Sat, 11 Oct 2014 00:02:32 +0200
Message-Id: <1412978554-31344-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

The code to detect unfused SoCs was broken due to missing register masking.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/sysctrl.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 8f1866d..92cf10e 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -147,12 +147,11 @@ static void falcon_gpe_enable(void)
 	if (status & (1 << (GPPC_OFFSET + 1)))
 		return;
 
-	if (status_r32(STATUS_CONFIG) == 0)
+	freq = (status_r32(STATUS_CONFIG) &
+		GPEFREQ_MASK) >>
+		GPEFREQ_OFFSET;
+	if (freq == 0)
 		freq = 1; /* use 625MHz on unfused chip */
-	else
-		freq = (status_r32(STATUS_CONFIG) &
-			GPEFREQ_MASK) >>
-			GPEFREQ_OFFSET;
 
 	/* apply new frequency */
 	sysctl_w32_mask(SYSCTL_SYS1, 7 << (GPPC_OFFSET + 1),
-- 
1.7.10.4
