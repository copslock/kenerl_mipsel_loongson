Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:02:49 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44238 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012842AbcBYKCrrgggm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:02:47 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA2ELm000751;
        Thu, 25 Feb 2016 02:02:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA2EC6000746;
        Thu, 25 Feb 2016 02:02:14 -0800
Date:   Thu, 25 Feb 2016 02:02:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-ac0a0cd266d1f21236d5975ca6bced9b377a2a6a@git.kernel.org>
Cc:     mingo@kernel.org, marc.zyngier@arm.com, lisa.parratt@imgtec.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        jiang.liu@linux.intel.com, qsyousef@gmail.com, tglx@linutronix.de,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        qais.yousef@imgtec.com, jason@lakedaemon.net
Reply-To: marc.zyngier@arm.com, lisa.parratt@imgtec.com, mingo@kernel.org,
          jason@lakedaemon.net, ralf@linux-mips.org,
          qais.yousef@imgtec.com, linux-kernel@vger.kernel.org,
          jiang.liu@linux.intel.com, qsyousef@gmail.com,
          tglx@linutronix.de, linux-mips@linux-mips.org, hpa@zytor.com
In-Reply-To: <1449580830-23652-8-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-8-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Make irq_domain_alloc_descs() non static
Git-Commit-ID: ac0a0cd266d1f21236d5975ca6bced9b377a2a6a
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
X-archive-position: 52242
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

Commit-ID:  ac0a0cd266d1f21236d5975ca6bced9b377a2a6a
Gitweb:     http://git.kernel.org/tip/ac0a0cd266d1f21236d5975ca6bced9b377a2a6a
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:18 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:56 +0100

genirq: Make irq_domain_alloc_descs() non static

We will need to use this function to implement irq_reserve_ipi() later. So
make it non static and move the prototype to irqdomain.h to allow using it
outside irqdomain.c

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-8-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h | 2 ++
 kernel/irq/irqdomain.c    | 6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 130e1c3..c466cc1 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -213,6 +213,8 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 extern struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
 						   enum irq_domain_bus_token bus_token);
 extern void irq_set_default_host(struct irq_domain *host);
+extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
+				  irq_hw_number_t hwirq, int node);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3e56d2f0..8681154 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -23,8 +23,6 @@ static DEFINE_MUTEX(irq_domain_mutex);
 static DEFINE_MUTEX(revmap_trees_mutex);
 static struct irq_domain *irq_default_domain;
 
-static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
-				  irq_hw_number_t hwirq, int node);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
 
 struct irqchip_fwid {
@@ -840,8 +838,8 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 };
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
-static int irq_domain_alloc_descs(int virq, unsigned int cnt,
-				  irq_hw_number_t hwirq, int node)
+int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
+			   int node)
 {
 	unsigned int hint;
 
