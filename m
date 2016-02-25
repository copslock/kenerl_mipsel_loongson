Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:01:30 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44124 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012746AbcBYKB1g1ORm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:01:27 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA0tcV000370;
        Thu, 25 Feb 2016 02:01:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA0thR000367;
        Thu, 25 Feb 2016 02:00:55 -0800
Date:   Thu, 25 Feb 2016 02:00:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-29d5c8db26ad54592436508819ac617119306f96@git.kernel.org>
Cc:     linux-mips@linux-mips.org, marc.zyngier@arm.com,
        qsyousef@gmail.com, jiang.liu@linux.intel.com,
        lisa.parratt@imgtec.com, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        mingo@kernel.org, tglx@linutronix.de, qais.yousef@imgtec.com,
        hpa@zytor.com
Reply-To: marc.zyngier@arm.com, linux-mips@linux-mips.org,
          jiang.liu@linux.intel.com, lisa.parratt@imgtec.com,
          qsyousef@gmail.com, ralf@linux-mips.org,
          linux-kernel@vger.kernel.org, jason@lakedaemon.net,
          tglx@linutronix.de, mingo@kernel.org, qais.yousef@imgtec.com,
          hpa@zytor.com
In-Reply-To: <1449580830-23652-3-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-3-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add DOMAIN_BUS_IPI
Git-Commit-ID: 29d5c8db26ad54592436508819ac617119306f96
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  29d5c8db26ad54592436508819ac617119306f96
Gitweb:     http://git.kernel.org/tip/29d5c8db26ad54592436508819ac617119306f96
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:13 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:55 +0100

genirq: Add DOMAIN_BUS_IPI

We need a way to search and match IPI domains.

Using the new enum we can use irq_find_matching_host() to do that.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-3-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9bb0a9c..130e1c3 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -74,6 +74,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_MSI,
 	DOMAIN_BUS_PLATFORM_MSI,
 	DOMAIN_BUS_NEXUS,
+	DOMAIN_BUS_IPI,
 };
 
 /**
