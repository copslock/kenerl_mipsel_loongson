Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:08:48 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:46128 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011988AbaJTTEVYqc0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:21 +0200
Received: by mail-oi0-f74.google.com with SMTP id v63so829294oia.5
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JZSu9+NUtma0J6Eo7Iq6gVtfYU4gLzVxf1XW5yU454k=;
        b=izvH5hUJqqOl5fNwlvzRpHwbKiAJ/+nGHaXGmB2Yla7fy6ngUTSkfmyyXODlkiOG/Z
         LmGnAAe0ibim/H9fX5z6nE2A1kRbAVw92A8DM1a8hR/dZXvDFvVkuC9Bp9chtuLcVrve
         95GD2cvmimKDqhmS6I80wbQbBCjTcKIRsaw0FXJnOgw9/gNrTCv04u41twE3dkPkGpQ9
         V5O/zMS9RO5dzEKYWs8nSb/4b9gn3fVo0GkL4Be5X7xkzrnTtd7CBPiuqXjwa1h7RK+g
         Xygr/4ySvN/b57p1iHpPq3Y/8rvBqrOnmM3SizOva7UciXlGUWhDXf4hdS0yFo2C9Cp1
         R1uw==
X-Gm-Message-State: ALoCoQlyl/RkSWop5s/bqdM19pKvyKbNWh89mL5iz9C2woQ3nUDrzRk9sywuWTKECb4No3Uq/UMG
X-Received: by 10.182.104.69 with SMTP id gc5mr14415912obb.18.1413831855636;
        Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si438201yhf.0.2014.10.20.12.04.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:15 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id LUNvf60n.5; Mon, 20 Oct 2014 12:04:15 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B0A85220D57; Mon, 20 Oct 2014 12:04:14 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] clocksource: mips-gic: Use percpu_dev_id
Date:   Mon, 20 Oct 2014 12:04:03 -0700
Message-Id: <1413831846-32100-17-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43375
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

Since the GIC timer IRQ is a percpu IRQ, we can use percpu_dev_id
to pass the IRQ handler the correct clock_event_device.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clocksource/mips-gic-timer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 763aa1c..05bdfe1 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -39,17 +39,16 @@ static void gic_set_clock_mode(enum clock_event_mode mode,
 
 static irqreturn_t gic_compare_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *cd;
-	int cpu = smp_processor_id();
+	struct clock_event_device *cd = dev_id;
 
 	gic_write_compare(gic_read_compare());
-	cd = &per_cpu(gic_clockevent_device, cpu);
 	cd->event_handler(cd);
 	return IRQ_HANDLED;
 }
 
 struct irqaction gic_compare_irqaction = {
 	.handler = gic_compare_interrupt,
+	.percpu_dev_id = &gic_clockevent_device,
 	.flags = IRQF_PERCPU | IRQF_TIMER,
 	.name = "timer",
 };
-- 
2.1.0.rc2.206.gedb03e5
