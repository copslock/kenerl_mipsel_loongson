Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 22:07:41 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35812 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031192AbcESUHiJ8Twe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 22:07:38 +0200
Received: by mail-wm0-f67.google.com with SMTP id s63so9373013wme.2;
        Thu, 19 May 2016 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5OurTHGB7FlYIDaajGmxPxHEVC1OQTTk6QmIpDZJh0=;
        b=KBzAoUhFObZaFyDLHpOkzbVkPpT5ik4LlOAn0SX/DTrckM6eo9eb5THUkrV8zA/Y1f
         z66eU6P75KD/4S4H0CiW7xpVAVUf5jPKF/B/VPcjLBN1TN7ugMEG5pE21N7vxfIp2Xmp
         k1VPwF8PQUBUTqaDCxx0ozl6Eh/cWVyFcnZWKsLAHZitpaZFhyn2cX6tY30mzolyJ9mN
         l2VsQza5my39ibAvXJGpJFB+lZN6XF375q5kttW7qDu3PVCxUk4vZvmO9LOM5NENa8Mo
         OqcsSag6KJUoZGH/+TAA6rYfRgvQJTNvszYJPAAYz4lW2hFk9FTXlebD08/zge9zCsFj
         WEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5OurTHGB7FlYIDaajGmxPxHEVC1OQTTk6QmIpDZJh0=;
        b=Slqt70OWCtjGHg7RGdb/i/uzyNON9Wf/9reZoagpyBqTzbffm+B/RyWj0GECE6QTcf
         jWlhoKXqaE8wUyGvNHCACs73iTgZDo4S2PENSUWr+ED3mLeUFGkNk8hdmX2l3v606GK6
         reekY1AXjpcLnmLAH1P5wCMAhnokQqutWd0qtngcpvBYqquSXafwi24ZK8ya4cDTZjxE
         OPxfBeevAGd/Lqt4RR+ktZqJFiR18ux8HRLw67sv3WH0Lva9MAaBkmCQO5sE1KxBKk1I
         E0J49xXJKJGD4CbKhm+UwDaCAa6PhHjNX+Np9Ysuivz9w/gHdl3u1d+b/8D4hFOrLJCb
         GrIg==
X-Gm-Message-State: AOPr4FUYm6LtnBmCB4PaCnoKA1PGTrVNRzkSlziBeGK/7ltra9a/K0ArrVHKHxwqe0PIRw==
X-Received: by 10.28.211.213 with SMTP id k204mr12423482wmg.35.1463688452836;
        Thu, 19 May 2016 13:07:32 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id az2sm16111423wjc.6.2016.05.19.13.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 13:07:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/3] MIPS: ralink: fix MT7628 pinmux typos
Date:   Thu, 19 May 2016 22:07:34 +0200
Message-Id: <1463688456-23795-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/ralink/mt7620.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 0d3d1a9..caabee1 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -223,9 +223,9 @@ static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
 #define MT7628_GPIO_MODE_GPIO		0
 
 static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
-	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pwm1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM1),
-	GRP_G("pmw0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pwm0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM0),
 	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_UART2),
-- 
2.1.4
