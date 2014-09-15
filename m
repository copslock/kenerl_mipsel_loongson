Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:56:14 +0200 (CEST)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:44255 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009029AbaIOXvsZhGJX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:48 +0200
Received: by mail-ie0-f202.google.com with SMTP id rl12so745412iec.5
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktjPVmRC0aDej+70rrkpttznjAQ3vV91ZStE0YHZz/w=;
        b=BSDK5Bbs3RGj2XOrSXXNPabpgarYkvyRI9fSA7963LmVvAu5W06gkEgY3rgc6dWCBc
         JUX7ZBJp7zkaxkD4iFJCEWfYkxUQl2ssgUfy7YmcC8J/EIEUxNRPNku1F79Sdyyc/vyj
         oNCo5EP8liUt9D99y9afnGrGy9zS8oB/AbhwAgqLeTVFr6qqNnWxLEwqueswT9xlz4BV
         rZzU7G3r1XNM8MfAocJx5ZMDcFp8HWmUItj1gubuNUqsAlBaCSShGpSspMJ2pp4i95nz
         apXjwdXkdkyPLzcDQnhRKmYTAYWfGtiYxqjQOllGdM1d3+sqkj+Hh2fTdSSTSFxqsAED
         j/rA==
X-Gm-Message-State: ALoCoQlJ8OBXmEBDlWJItaZiMyhNLwYA1RrHTiAe5xvl4T76blZOVzlX6OWlkgvWlnZu+oGEZ7ih
X-Received: by 10.182.45.162 with SMTP id o2mr17794470obm.20.1410825102693;
        Mon, 15 Sep 2014 16:51:42 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id j25si632222yhb.0.2014.09.15.16.51.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:42 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 1oB1jrOM.3; Mon, 15 Sep 2014 16:51:42 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 9377B22093F; Mon, 15 Sep 2014 16:51:41 -0700 (PDT)
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
Subject: [PATCH 16/24] irqchip: mips-gic: Fix gic_set_affinity() return value
Date:   Mon, 15 Sep 2014 16:51:19 -0700
Message-Id: <1410825087-5497-17-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42634
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

If the online CPU check in gic_set_affinity() fails, return a proper
errno value instead of -1.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index cde743c..fd00318 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -309,7 +309,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 	cpumask_and(&tmp, cpumask, cpu_online_mask);
 	if (cpus_empty(tmp))
-		return -1;
+		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
 	spin_lock_irqsave(&gic_lock, flags);
-- 
2.1.0.rc2.206.gedb03e5
