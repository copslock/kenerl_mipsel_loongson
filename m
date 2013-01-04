Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 03:59:17 +0100 (CET)
Received: from wolverine01.qualcomm.com ([199.106.114.254]:36046 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823044Ab3ADC7GyLNJ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 03:59:06 +0100
X-IronPort-AV: E=Sophos;i="4.84,406,1355126400"; 
   d="scan'208";a="17669351"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2013 18:59:00 -0800
Received: from svaddagi-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
        by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C8F7610004DC;
        Thu,  3 Jan 2013 18:58:59 -0800 (PST)
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     Russell King <linux@arm.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Frysinger <vapier@gentoo.org>,
        uclinux-dist-devel@blackfin.uclinux.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, mhocko@suse.cz,
        srivatsa.bhat@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
Date:   Thu,  3 Jan 2013 18:58:57 -0800
Message-Id: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 1.7.8.3
X-archive-position: 35364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vatsa@codeaurora.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
cpu's idle time as last recorded in its ts->idle_sleeptime will be reported
(thus excluding its offline time as part of idle time statistics).

Cc: mhocko@suse.cz
Cc: srivatsa.bhat@linux.vnet.ibm.com
Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 fs/proc/stat.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index e296572..64c3b31 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -45,13 +45,10 @@ static cputime64_t get_iowait_time(int cpu)
 
 static u64 get_idle_time(int cpu)
 {
-	u64 idle, idle_time = -1ULL;
-
-	if (cpu_online(cpu))
-		idle_time = get_cpu_idle_time_us(cpu, NULL);
+	u64 idle, idle_time = get_cpu_idle_time_us(cpu, NULL);
 
 	if (idle_time == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
+		/* !NO_HZ so we can rely on cpustat.idle */
 		idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
 	else
 		idle = usecs_to_cputime64(idle_time);
@@ -61,13 +58,10 @@ static u64 get_idle_time(int cpu)
 
 static u64 get_iowait_time(int cpu)
 {
-	u64 iowait, iowait_time = -1ULL;
-
-	if (cpu_online(cpu))
-		iowait_time = get_cpu_iowait_time_us(cpu, NULL);
+	u64 iowait, iowait_time = get_cpu_iowait_time_us(cpu, NULL);
 
 	if (iowait_time == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
+		/* !NO_HZ so we can rely on cpustat.iowait */
 		iowait = kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
 	else
 		iowait = usecs_to_cputime64(iowait_time);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
