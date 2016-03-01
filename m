Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 09:50:06 +0100 (CET)
Received: from michel.telenet-ops.be ([195.130.137.88]:55955 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007388AbcCAIuEq9wPL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 09:50:04 +0100
Received: from ayla.of.borg ([84.195.106.123])
        by michel.telenet-ops.be with bizsmtp
        id QYq31s01A2fm56U06Yq3ip; Tue, 01 Mar 2016 09:50:04 +0100
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1aag0J-0006ws-KS; Tue, 01 Mar 2016 09:50:03 +0100
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1aag0K-0003Ej-Bj; Tue, 01 Mar 2016 09:50:04 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     John Stultz <john.stultz@linaro.org>, rtc-linux@googlegroups.com,
        linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFT] rtc: rtc-vr41xx: Wire up alarm_irq_enable
Date:   Tue,  1 Mar 2016 09:50:01 +0100
Message-Id: <1456822201-12408-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

drivers/rtc/rtc-vr41xx.c:229: warning: ‘vr41xx_rtc_alarm_irq_enable’ defined but not used

Apparently the conversion to alarm_irq_enable forgot to wire up the
callback.

Fixes: 16380c153a69c378 ("RTC: Convert rtc drivers to use the alarm_irq_enable method")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested due to lack of hardware
---
 drivers/rtc/rtc-vr41xx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index f64c282275b3988a..e1b86bb0106233f1 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -272,12 +272,13 @@ static irqreturn_t rtclong1_interrupt(int irq, void *dev_id)
 }
 
 static const struct rtc_class_ops vr41xx_rtc_ops = {
-	.release	= vr41xx_rtc_release,
-	.ioctl		= vr41xx_rtc_ioctl,
-	.read_time	= vr41xx_rtc_read_time,
-	.set_time	= vr41xx_rtc_set_time,
-	.read_alarm	= vr41xx_rtc_read_alarm,
-	.set_alarm	= vr41xx_rtc_set_alarm,
+	.release		= vr41xx_rtc_release,
+	.ioctl			= vr41xx_rtc_ioctl,
+	.read_time		= vr41xx_rtc_read_time,
+	.set_time		= vr41xx_rtc_set_time,
+	.read_alarm		= vr41xx_rtc_read_alarm,
+	.set_alarm		= vr41xx_rtc_set_alarm,
+	.alarm_irq_enable	= vr41xx_rtc_alarm_irq_enable,
 };
 
 static int rtc_probe(struct platform_device *pdev)
-- 
1.9.1
