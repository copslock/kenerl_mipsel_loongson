Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:30:02 +0200 (CEST)
Received: from mail-pf0-x232.google.com ([IPv6:2607:f8b0:400e:c00::232]:50194
        "EHLO mail-pf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992388AbdJDX2FcALgm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:05 +0200
Received: by mail-pf0-x232.google.com with SMTP id m63so7039079pfk.7
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgh8bscT5TthuGUYkV7xZ3ZLvs/Z2e5PGy5IRqmBm8k=;
        b=g9EWs0j8arvUZtVO2potRBDEXVIHQpof6M5OkSj9IhdzIveUPlXvl15O6uLPXoUSdb
         xDLjNpKf/hilZu33Ksz7+JDT/bOmlDcYkieZwTisStk2merrtFpKUBuvDjjUDYT8aTR0
         NpLihazYlDOyTiJXd5NbNlcBMojuOHA9KWm7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgh8bscT5TthuGUYkV7xZ3ZLvs/Z2e5PGy5IRqmBm8k=;
        b=ZGYb2JSGlY39X/P7zkfBB3Pimwltqz++z940+MklVFYmgtG4ksB/dytcZnSzTX0RxI
         mpBp5uWhwFjHUFQ1APTg4i+GvJpt5hSWGZt/0QTzSm6nDeAXdaDUxkj7Yr7BqSpAI22f
         256e/vJ148LjOvhu0+ZHIBd8U5ud87pjE0ZEgArHYV7vBM7nwK6VjVlnGmACYInojo85
         l4TOsRDNGUP/5qkWG6FEGH8R+dfSbk2w6dym72w/HSBTEjSHpM/lXGccyS8vypeaIJIJ
         6ZPc85ho7PqR4gFlZezM7+0mFBmn0zM2kB5n13ab8+8k38WRWnGOAxgjWJbkR+QCM22b
         pBlA==
X-Gm-Message-State: AMCzsaX9UQw7s2pAJNr1F6ZQ8GviiryaSl1oIrsFRTlA+9ZbyMW+at0h
        0t/aYXYpsJD57anUUOXpSu+H4A==
X-Google-Smtp-Source: AOwi7QAOmhj65fOEDU8PN6F6AokGUA5hsyy/Ac3qf2XV/4pfkOCF+u+ARkimrscWbWM6f+9IPnUenA==
X-Received: by 10.99.101.135 with SMTP id z129mr14079136pgb.75.1507159679341;
        Wed, 04 Oct 2017 16:27:59 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q73sm10579839pfl.146.2017.10.04.16.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sebastian Reichel <sre@kernel.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Reed <mdr@sgi.com>, Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] timer: Remove init_timer_deferrable() in favor of timer_setup()
Date:   Wed,  4 Oct 2017 16:26:59 -0700
Message-Id: <1507159627-127660-6-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

This refactors the only users of init_timer_deferrable() to use
the new timer_setup() and from_timer(). Removes definition of
init_timer_deferrable().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Harish Patil <harish.patil@cavium.com>
Cc: Manish Chopra <manish.chopra@cavium.com>
Cc: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/mm/numa.c                       | 12 +++++------
 drivers/hsi/clients/ssi_protocol.c           | 32 ++++++++++++++++------------
 drivers/net/ethernet/qlogic/qlge/qlge_main.c | 11 ++++------
 drivers/net/vxlan.c                          |  8 +++----
 drivers/net/wireless/ath/ath6kl/recovery.c   |  9 ++++----
 include/linux/timer.h                        |  2 --
 6 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b95c584ce19d..f9b6107d6854 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1453,7 +1453,7 @@ static void topology_schedule_update(void)
 	schedule_work(&topology_work);
 }
 
-static void topology_timer_fn(unsigned long ignored)
+static void topology_timer_fn(struct timer_list *unused)
 {
 	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
 		topology_schedule_update();
@@ -1463,14 +1463,11 @@ static void topology_timer_fn(unsigned long ignored)
 		reset_topology_timer();
 	}
 }
-static struct timer_list topology_timer =
-	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
+static struct timer_list topology_timer;
 
 static void reset_topology_timer(void)
 {
-	topology_timer.data = 0;
-	topology_timer.expires = jiffies + 60 * HZ;
-	mod_timer(&topology_timer, topology_timer.expires);
+	mod_timer(&topology_timer, jiffies + 60 * HZ);
 }
 
 #ifdef CONFIG_SMP
@@ -1530,7 +1527,8 @@ int start_topology_update(void)
 			prrn_enabled = 0;
 			vphn_enabled = 1;
 			setup_cpu_associativity_change_counters();
-			init_timer_deferrable(&topology_timer);
+			timer_setup(&topology_timer, topology_timer_fn,
+				    TIMER_DEFERRABLE);
 			reset_topology_timer();
 		}
 	}
diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 93d28c0ec8bf..67af03d3aeb3 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -464,10 +464,10 @@ static void ssip_error(struct hsi_client *cl)
 	hsi_async_read(cl, msg);
 }
 
-static void ssip_keep_alive(unsigned long data)
+static void ssip_keep_alive(struct timer_list *t)
 {
-	struct hsi_client *cl = (struct hsi_client *)data;
-	struct ssi_protocol *ssi = hsi_client_drvdata(cl);
+	struct ssi_protocol *ssi = from_timer(ssi, t, keep_alive);
+	struct hsi_client *cl = ssi->cl;
 
 	dev_dbg(&cl->device, "Keep alive kick in: m(%d) r(%d) s(%d)\n",
 		ssi->main_state, ssi->recv_state, ssi->send_state);
@@ -490,9 +490,19 @@ static void ssip_keep_alive(unsigned long data)
 	spin_unlock(&ssi->lock);
 }
 
-static void ssip_wd(unsigned long data)
+static void ssip_rx_wd(struct timer_list *t)
+{
+	struct ssi_protocol *ssi = from_timer(ssi, t, rx_wd);
+	struct hsi_client *cl = ssi->cl;
+
+	dev_err(&cl->device, "Watchdog trigerred\n");
+	ssip_error(cl);
+}
+
+static void ssip_tx_wd(unsigned long data)
 {
-	struct hsi_client *cl = (struct hsi_client *)data;
+	struct ssi_protocol *ssi = from_timer(ssi, t, tx_wd);
+	struct hsi_client *cl = ssi->cl;
 
 	dev_err(&cl->device, "Watchdog trigerred\n");
 	ssip_error(cl);
@@ -1084,15 +1094,9 @@ static int ssi_protocol_probe(struct device *dev)
 	}
 
 	spin_lock_init(&ssi->lock);
-	init_timer_deferrable(&ssi->rx_wd);
-	init_timer_deferrable(&ssi->tx_wd);
-	init_timer(&ssi->keep_alive);
-	ssi->rx_wd.data = (unsigned long)cl;
-	ssi->rx_wd.function = ssip_wd;
-	ssi->tx_wd.data = (unsigned long)cl;
-	ssi->tx_wd.function = ssip_wd;
-	ssi->keep_alive.data = (unsigned long)cl;
-	ssi->keep_alive.function = ssip_keep_alive;
+	timer_setup(&ssi->rx_wd, ssip_rx_wd, TIMER_DEFERRABLE);
+	timer_setup(&ssi->tx_wd, ssip_tx_wd, TIMER_DEFERRABLE);
+	timer_setup(&ssi->keep_alive, ssip_keep_alive, 0);
 	INIT_LIST_HEAD(&ssi->txqueue);
 	INIT_LIST_HEAD(&ssi->cmdqueue);
 	atomic_set(&ssi->tx_usecnt, 0);
diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index 9feec7009443..29fea74bff2e 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -4725,9 +4725,9 @@ static const struct net_device_ops qlge_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= qlge_vlan_rx_kill_vid,
 };
 
-static void ql_timer(unsigned long data)
+static void ql_timer(struct timer_list *t)
 {
-	struct ql_adapter *qdev = (struct ql_adapter *)data;
+	struct ql_adapter *qdev = from_timer(qdev, t, timer);
 	u32 var = 0;
 
 	var = ql_read32(qdev, STS);
@@ -4806,11 +4806,8 @@ static int qlge_probe(struct pci_dev *pdev,
 	/* Start up the timer to trigger EEH if
 	 * the bus goes dead
 	 */
-	init_timer_deferrable(&qdev->timer);
-	qdev->timer.data = (unsigned long)qdev;
-	qdev->timer.function = ql_timer;
-	qdev->timer.expires = jiffies + (5*HZ);
-	add_timer(&qdev->timer);
+	timer_setup(&qdev->timer, ql_timer, TIMER_DEFERRABLE);
+	mod_timer(&qdev->timer, jiffies + (5*HZ));
 	ql_link_off(qdev);
 	ql_display_dev_info(ndev);
 	atomic_set(&qdev->lb_count, 0);
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index d7c49cf1d5e9..3247d2feda07 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2325,9 +2325,9 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 /* Walk the forwarding table and purge stale entries */
-static void vxlan_cleanup(unsigned long arg)
+static void vxlan_cleanup(struct timer_list *t)
 {
-	struct vxlan_dev *vxlan = (struct vxlan_dev *) arg;
+	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
 	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
 	unsigned int h;
 
@@ -2647,9 +2647,7 @@ static void vxlan_setup(struct net_device *dev)
 	INIT_LIST_HEAD(&vxlan->next);
 	spin_lock_init(&vxlan->hash_lock);
 
-	init_timer_deferrable(&vxlan->age_timer);
-	vxlan->age_timer.function = vxlan_cleanup;
-	vxlan->age_timer.data = (unsigned long) vxlan;
+	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
 
 	vxlan->dev = dev;
 
diff --git a/drivers/net/wireless/ath/ath6kl/recovery.c b/drivers/net/wireless/ath/ath6kl/recovery.c
index 3a8d5e97dc8e..c09e40c9010f 100644
--- a/drivers/net/wireless/ath/ath6kl/recovery.c
+++ b/drivers/net/wireless/ath/ath6kl/recovery.c
@@ -60,9 +60,9 @@ void ath6kl_recovery_hb_event(struct ath6kl *ar, u32 cookie)
 		ar->fw_recovery.hb_pending = false;
 }
 
-static void ath6kl_recovery_hb_timer(unsigned long data)
+static void ath6kl_recovery_hb_timer(struct timer_list *t)
 {
-	struct ath6kl *ar = (struct ath6kl *) data;
+	struct ath6kl *ar = from_timer(ar, t, fw_recovery.hb_timer);
 	int err;
 
 	if (test_bit(RECOVERY_CLEANUP, &ar->flag) ||
@@ -104,9 +104,8 @@ void ath6kl_recovery_init(struct ath6kl *ar)
 	recovery->seq_num = 0;
 	recovery->hb_misscnt = 0;
 	ar->fw_recovery.hb_pending = false;
-	ar->fw_recovery.hb_timer.function = ath6kl_recovery_hb_timer;
-	ar->fw_recovery.hb_timer.data = (unsigned long) ar;
-	init_timer_deferrable(&ar->fw_recovery.hb_timer);
+	timer_setup(&ar->fw_recovery.hb_timer, ath6kl_recovery_hb_timer,
+		    TIMER_DEFERRABLE);
 
 	if (ar->fw_recovery.hb_poll)
 		mod_timer(&ar->fw_recovery.hb_timer, jiffies +
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 9da903562ed4..10cc45ca5803 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -128,8 +128,6 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 
 #define init_timer(timer)						\
 	__init_timer((timer), 0)
-#define init_timer_deferrable(timer)					\
-	__init_timer((timer), TIMER_DEFERRABLE)
 
 #define __setup_timer(_timer, _fn, _data, _flags)			\
 	do {								\
-- 
2.7.4
