Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:39:28 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35058 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009763AbbJUCiKk06Jy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:38:10 +0200
Received: by pasz6 with SMTP id z6so39413426pas.2;
        Tue, 20 Oct 2015 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tNcbt9rgMe6V1skAvgLSoL2dUCahB03tdPFH60Ylr20=;
        b=piN9xz7IkEWBw7oxEfJ2vFIMiLV+F2LLf1X7r11usUGTojHA7iy4Q3xX0YsfK1VQhP
         /LuVR5WIZbyqshV9SYto81vACqWJl0bydM6fUfrfzwR64qEs5xD0yvphW4Wiu9/3Q+kF
         Zb7vdZ7bV1ScZ+D+W+peg6DdaduqykImzbnPV6UleA4Mxge3Su/AepVJCaSdLzweYy59
         hwF688sA3JBkAtSeJdvifAUwPh+XjiLHjmBaiQRp3IeZ81w/pbYiSPXAeviQuO6t2uhS
         eOEFXk+JI6owtNCzWSVZoG4L0hqpJl19PXLG5kIHU6QgLqqkwSEgmz4lf3dqNWodFFiG
         goTg==
X-Received: by 10.68.143.4 with SMTP id sa4mr7571972pbb.111.1445395085077;
        Tue, 20 Oct 2015 19:38:05 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.38.02
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:38:04 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 5/9] i2c: brcmstb: fix start and stop conditions
Date:   Wed, 21 Oct 2015 11:36:57 +0900
Message-Id: <1445395021-4204-6-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Fixes conditions for RESTART, NOSTART and NOSTOP. The masks of start and
stop is already in brcmstb_set_i2c_start_stop(). Therefore, the caller
does not need a mask value.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 53eb8b0c9bad..dcd1209f843f 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -464,7 +464,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 			pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
 
 		if (i < (num - 1) && (msgs[i + 1].flags & I2C_M_NOSTART))
-			brcmstb_set_i2c_start_stop(dev, ~(COND_START_STOP));
+			brcmstb_set_i2c_start_stop(dev, 0);
 		else
 			brcmstb_set_i2c_start_stop(dev,
 						   COND_RESTART | COND_NOSTOP);
@@ -485,8 +485,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 			bytes_to_xfer = min(len, N_DATA_BYTES);
 
 			if (len <= N_DATA_BYTES && i == (num - 1))
-				brcmstb_set_i2c_start_stop(dev,
-							   ~(COND_START_STOP));
+				brcmstb_set_i2c_start_stop(dev, 0);
 
 			rc = brcmstb_i2c_xfer_bsc_data(dev, tmp_buf,
 						       bytes_to_xfer, pmsg);
-- 
2.6.1
