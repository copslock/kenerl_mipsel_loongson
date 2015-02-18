Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 11:44:52 +0100 (CET)
Received: from baptiste.telenet-ops.be ([195.130.132.51]:57496 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012967AbbBRKoul5lVz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Feb 2015 11:44:50 +0100
Received: from ayla.of.borg ([84.193.93.87])
        by baptiste.telenet-ops.be with bizsmtp
        id tmkp1p00a1t5w8s01mkp4x; Wed, 18 Feb 2015 11:44:49 +0100
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1YO27d-0004qe-8S; Wed, 18 Feb 2015 11:44:49 +0100
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1YO27d-0005Lq-Nj; Wed, 18 Feb 2015 11:44:49 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] rtc: ds1685: Remove superfluous checks for out-of-range u8 values
Date:   Wed, 18 Feb 2015 11:44:39 +0100
Message-Id: <1424256279-20526-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45849
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

drivers/rtc/rtc-ds1685.c: In function ‘ds1685_rtc_read_alarm’:
drivers/rtc/rtc-ds1685.c:402: warning: comparison is always true due to limited range of data type
drivers/rtc/rtc-ds1685.c:409: warning: comparison is always true due to limited range of data type
drivers/rtc/rtc-ds1685.c:416: warning: comparison is always true due to limited range of data type
drivers/rtc/rtc-ds1685.c: In function ‘ds1685_rtc_set_alarm’:
drivers/rtc/rtc-ds1685.c:475: warning: comparison is always true due to limited range of data type
drivers/rtc/rtc-ds1685.c:478: warning: comparison is always true due to limited range of data type
drivers/rtc/rtc-ds1685.c:481: warning: comparison is always true due to limited range of data type

u8 cannot contain a value larger than 0xff, hence drop the checks.
Wrapping the checks in unlikely() indicated some sense of humor, though ;-)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/rtc/rtc-ds1685.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 8c3bfcb115b78731..5077078a9305b9d5 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -399,21 +399,21 @@ ds1685_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	 * of this RTC chip.  We check for it anyways in case support is
 	 * added in the future.
 	 */
-	if (unlikely((seconds >= 0xc0) && (seconds <= 0xff)))
+	if (unlikely(seconds >= 0xc0))
 		alrm->time.tm_sec = -1;
 	else
 		alrm->time.tm_sec = ds1685_rtc_bcd2bin(rtc, seconds,
 						       RTC_SECS_BCD_MASK,
 						       RTC_SECS_BIN_MASK);
 
-	if (unlikely((minutes >= 0xc0) && (minutes <= 0xff)))
+	if (unlikely(minutes >= 0xc0))
 		alrm->time.tm_min = -1;
 	else
 		alrm->time.tm_min = ds1685_rtc_bcd2bin(rtc, minutes,
 						       RTC_MINS_BCD_MASK,
 						       RTC_MINS_BIN_MASK);
 
-	if (unlikely((hours >= 0xc0) && (hours <= 0xff)))
+	if (unlikely(hours >= 0xc0))
 		alrm->time.tm_hour = -1;
 	else
 		alrm->time.tm_hour = ds1685_rtc_bcd2bin(rtc, hours,
@@ -472,13 +472,13 @@ ds1685_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	 * field, and we only support four fields.  We put the support
 	 * here anyways for the future.
 	 */
-	if (unlikely((seconds >= 0xc0) && (seconds <= 0xff)))
+	if (unlikely(seconds >= 0xc0))
 		seconds = 0xff;
 
-	if (unlikely((minutes >= 0xc0) && (minutes <= 0xff)))
+	if (unlikely(minutes >= 0xc0))
 		minutes = 0xff;
 
-	if (unlikely((hours >= 0xc0) && (hours <= 0xff)))
+	if (unlikely(hours >= 0xc0))
 		hours = 0xff;
 
 	alrm->time.tm_mon	= -1;
-- 
1.9.1
