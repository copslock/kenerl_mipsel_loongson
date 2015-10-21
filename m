Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:38:49 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34461 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009330AbbJUCiE4Hxzy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:38:04 +0200
Received: by padhk11 with SMTP id hk11so39492106pad.1;
        Tue, 20 Oct 2015 19:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B7FhQs5jnNlhU2Q8AkWZ9fUlyOdXb1QfA79wOILi9Xk=;
        b=ekV3Vl84XzhN2dsPhQlu1twj9+ivWgvqyOKF/9CLyxeVPm3C3Sy32Dbbbcq3r4NCbI
         nXZXSwAkGEuV5BWEZwOOCGdPbx59sv/A2p6Uowiwmh9dr9oEIJM2poN/zIjoo7Lrd40x
         pc6tCWa1TpUD/HtGoQfwEd+28T0sNVsWbWpRJ3veHPGaMLLG/fFQ7STtCBsAXnMmZPZK
         XzRi1Q/e4xI17y2ACHqYrrCTVttValoQl1xlIOVNNSWnlXJYL8VHkm7+lNowlnXGiX1p
         QOBqSAhHCcmMk/j8zC617FjewbeA/D0oHoTB3kke1xfKyNDOhB2xtTcLKRmqgM4n7gpM
         kBbQ==
X-Received: by 10.66.222.70 with SMTP id qk6mr7814220pac.68.1445395079343;
        Tue, 20 Oct 2015 19:37:59 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.37.56
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:37:58 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 3/9] i2c: brcmstb: add missing parenthesis
Date:   Wed, 21 Oct 2015 11:36:55 +0900
Message-Id: <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49616
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

Add the necessary parenthesis for NOACK condition.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 6b8bbf99880d..2d7d155029dc 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -305,7 +305,7 @@ static int brcmstb_send_i2c_cmd(struct brcmstb_i2c_dev *dev,
 	}
 
 	if ((CMD_RD || CMD_WR) &&
-	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
+	    (bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK)) {
 		rc = -EREMOTEIO;
 		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
 			cmd_string[cmd]);
-- 
2.6.1
