Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:07:41 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:55990 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011977AbaJTTESwrihZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:18 +0200
Received: by mail-oi0-f74.google.com with SMTP id v63so830546oia.1
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MhGtkbJwskJ6gZ8kvpd/6omuajmZGqGMjJeakJ2jkV4=;
        b=mz6K60nVYx/Bp4OCtbIvI146d7sNOwarC1kC0ncDqRQAiKpVm9d3YAe9ARQid7b6jZ
         X6wegHdjaDdUIPTNYKNWFcbfETndcNpbYqswtjvStZ8LDA3yHmit5peZ70wMHHdPEjiH
         v/8/er7UH+21f5+KjG7mb2OGC7QhuHplB7m78OX8Rg4FnyVYgzM0Thmyb3uFgVLd6zQz
         Z8YZRiKruN3sd+THUyucABmo5Co0bIa/TB0QinevYA2wHnjvNlDqmZQ93kewZhWGo9XA
         h3AauMkieoiNkjRsjA4P0HXKG8bqrg3mlp+F7Jd7+YtMJGzchEN6vuLeA2w8V8Ibuu4b
         KAPw==
X-Gm-Message-State: ALoCoQk1QoY5kaySzcyp5PzTFsMGNkLBGR/piVOTN8PBI7G2N5iSqum9RkAfPN8+5GVXMca6fZtw
X-Received: by 10.182.98.197 with SMTP id ek5mr18418233obb.30.1413831852626;
        Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si437290yhe.3.2014.10.20.12.04.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:12 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id LUNvf60n.3; Mon, 20 Oct 2014 12:04:12 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id B3991220B02; Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
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
Subject: [PATCH 10/19] irqchip: mips-gic: Use GIC_SH_WEDGE_{SET,CLR} macros
Date:   Mon, 20 Oct 2014 12:03:57 -0700
Message-Id: <1413831846-32100-11-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43371
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

Use the GIC_SH_WEDGE_{SET,CLR} macros provided by mips-gic.h.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/irqchip/irq-mips-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 188760c..165cf1e 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -206,7 +206,7 @@ static void gic_bind_eic_interrupt(int irq, int set)
 
 void gic_send_ipi(unsigned int intr)
 {
-	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), 0x80000000 | intr);
+	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_SET(intr));
 }
 
 int gic_get_c0_compare_int(void)
@@ -270,7 +270,7 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
+	gic_write(GIC_REG(SHARED, GIC_SH_WEDGE), GIC_SH_WEDGE_CLR(irq));
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
-- 
2.1.0.rc2.206.gedb03e5
