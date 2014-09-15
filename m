Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:53:23 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:51937 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009011AbaIOXvnzgOf9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:43 +0200
Received: by mail-pd0-f201.google.com with SMTP id v10so1019128pde.0
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sfi/F52OoWN4a3Vh47F4jqcBzQUhyd+Ri0K5qnl8AiE=;
        b=kM1y/7T0hJ5QH8VzM9PjreY+akIepuNLjy5uLaBj/vUwtenn5K0nVhrlCOuTFxRUy6
         ZnWeps3uQMCzWi8pQSSwugiQ5aJBoTvQUr5yMFdIHmy0Y/5swRXmqX4U9hZQHixG7hwi
         vZNqde6XxxCs4jzhwhNhjlS12KSluS0ksUXhztnIDicYZ792eHqf2PVcqEcrgum8STz+
         H66xVI6ksGqr1qH59GKPnHwWJHPw2G+nwA/RgrVspCH3XJyDuO57RLdiwLhcM+CWFddP
         eurgnTQ4nJG8+y1Az1ytKTkmIYeQTuCDQvw3I9UQOX8OKJTqe72qTbvQli5Oe0EKVTxb
         4+xQ==
X-Gm-Message-State: ALoCoQncy6YF4INpABrM4Njic/yE5mVCYQazJHwDfqQpJYRM0vqcqEBMeph1/Ud+l7ecOY/IEkI0
X-Received: by 10.66.157.197 with SMTP id wo5mr3162586pab.43.1410825097992;
        Mon, 15 Sep 2014 16:51:37 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si631685yhd.1.2014.09.15.16.51.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:37 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Mdj9PTay.2; Mon, 15 Sep 2014 16:51:37 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D32A0220984; Mon, 15 Sep 2014 16:51:36 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/24] MIPS: smp-cps: Enable all hardware interrupts on secondary CPUs
Date:   Mon, 15 Sep 2014 16:51:10 -0700
Message-Id: <1410825087-5497-8-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Currently interrupt vectors 2 and 5 are left disabled on secondary CPUs.
Since systems using CPS must also have a GIC, which is responsible for
routing all external interrupts and can map them to any hardware interrupt
vector, enable the remaining vectors.  The two software interrupt vectors
are left disabled since they are not used with CPS.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/kernel/smp-cps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index e6e16a1..cd20aca 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -273,8 +273,8 @@ static void cps_init_secondary(void)
 	if (cpu_has_mipsmt)
 		dmt();
 
-	change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
-				 STATUSF_IP6 | STATUSF_IP7);
+	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
+				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
 }
 
 static void cps_smp_finish(void)
-- 
2.1.0.rc2.206.gedb03e5
