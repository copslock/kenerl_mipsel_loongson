Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2014 12:01:11 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:48429 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822274AbaDBKBEq5-q1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2014 12:01:04 +0200
Received: by mail-wg0-f48.google.com with SMTP id l18so8590863wgh.31
        for <multiple recipients>; Wed, 02 Apr 2014 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kyCwXzzoXoJI1m1ydderMYnm6GuI/ZMpKa3zZjaKh4Q=;
        b=ys5ZfGknDCPIpAwWx/kGOHOKkbBiU5bqjk25YJOQ2vfeSzBugF63S1PwEgN39tnP0t
         DJuYWq9UfnzhdlZoUIKV/SbPwfcSm+6+wQkotg2cumIef22cmRkCM3I5xtK9zBwq6R94
         7TdDB+tGWTsMK7UDhswP/7Y7TtVFcECGDhFIMGWOUQ5nNolaKUKPzSyFzh/fxYV/5bI3
         Fg/i2zqxO4tXbOy7saWSqfrl3jxVrYANMNXxEaNeadVHGvJc2eJ11RmpqIrdVlbmntQy
         IhPwyt7ABzqgowiyvnHGQZqrWIyf500k2V49cGqMaN3D/Ez6pkQE+5e3q4TV/biHH6s1
         vS7g==
X-Received: by 10.180.219.66 with SMTP id pm2mr27261739wic.60.1396432859130;
        Wed, 02 Apr 2014 03:00:59 -0700 (PDT)
Received: from localhost.localdomain (sagv5.gyakg.u-szeged.hu. [160.114.18.70])
        by mx.google.com with ESMTPSA id cb5sm3391904eeb.18.2014.04.02.03.00.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Apr 2014 03:00:58 -0700 (PDT)
From:   Levente Kurusa <levex@linux.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Levente Kurusa <levex@linux.com>
Subject: [PATCH RESEND] tc: account for device_register() failure
Date:   Wed,  2 Apr 2014 12:00:37 +0200
Message-Id: <1396432837-10549-1-git-send-email-levex@linux.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <ilevex.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levex@linux.com
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

This patch makes the TURBOchannel driver bail out if the call
to device_register() failed.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
Resending as per Maciej's request to proper list and
people.
---
 tc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tc/tc.c b/drivers/tc/tc.c
index a8aaf6a..6b3a038 100644
--- a/drivers/tc/tc.c
+++ b/drivers/tc/tc.c
@@ -129,7 +129,10 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)

 		tc_device_get_irq(tdev);

-		device_register(&tdev->dev);
+		if (device_register(&tdev->dev)) {
+			put_device(&tdev->dev);
+			goto out_err;
+		}
 		list_add_tail(&tdev->node, &tbus->devices);

 out_err:
@@ -148,7 +151,10 @@ static int __init tc_init(void)

 	INIT_LIST_HEAD(&tc_bus.devices);
 	dev_set_name(&tc_bus.dev, "tc");
-	device_register(&tc_bus.dev);
+	if (device_register(&tc_bus.dev)) {
+		put_device(&tc_bus.dev);
+		return 0;	
+	}

 	if (tc_bus.info.slot_size) {
 		unsigned int tc_clock = tc_get_speed(&tc_bus) / 100000;
