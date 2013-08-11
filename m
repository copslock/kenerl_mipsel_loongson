Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:18:32 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4015 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824782Ab3HKJNfRQOM0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:35 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:07:09 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:18 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:18 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 88B8CF2D72; Sun, 11
 Aug 2013 02:13:17 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 07/10] MIPS: Netlogic: Core wakeup changes for XLP2XX
Date:   Sun, 11 Aug 2013 14:43:57 +0530
Message-ID: <1376212440-21038-8-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198BB71R079371340-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On XLP2xx, wakeup code does not need to enable clock on the core.
Update xlp/wakeup.c to handle this.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/wakeup.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index 0cce37c..682d563 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -58,10 +58,12 @@ static int xlp_wakeup_core(uint64_t sysbase, int node, int core)
 
 	coremask = (1 << core);
 
-	/* Enable CPU clock */
-	value = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL);
-	value &= ~coremask;
-	nlm_write_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL, value);
+	/* Enable CPU clock in case of 8xx/3xx */
+	if (!cpu_is_xlpii()) {
+		value = nlm_read_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL);
+		value &= ~coremask;
+		nlm_write_sys_reg(sysbase, SYS_CORE_DFS_DIS_CTRL, value);
+	}
 
 	/* Remove CPU Reset */
 	value = nlm_read_sys_reg(sysbase, SYS_CPU_RESET);
-- 
1.7.9.5
