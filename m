Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:39:08 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34518 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009552AbbJUCiIFClWy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:38:08 +0200
Received: by padhk11 with SMTP id hk11so39493472pad.1;
        Tue, 20 Oct 2015 19:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mn5tnTF58c6rIQkY/4MyNZGNzIA65+a3StSKvX/DZwE=;
        b=ytKPazuJpi583TqBUXg1qfIcpuaefozlkNoaSf3oh6UUz4O8QPQVH3QdaJ8fj7m6za
         bJpUczmXbG2DoxUC3xpKK6HxdzMNGMaJMFEarEi6aWIm1zbun1ECdU1e6UAzdIYxDKF7
         Jh5gTcqHhy1AY7tYsH1ushfa4s+PbRXdJo0j/Sw7bK5I8BTGHCQQpZKjvm2BHlsWFPDJ
         LGtOXzeMwHSLM42vYS/SfPqA4mVp5t8N8cd7Q0iqpY1LU2k1pjMbZRmdXADO7RT4esk3
         F/05nrekkWUhZ3HD+Ct5TJHd6mnTEp06+KdHMWof7/PS+yYbzH7AkRVl6fXnbfB0gXDC
         70FQ==
X-Received: by 10.66.121.110 with SMTP id lj14mr7571785pab.61.1445395082365;
        Tue, 20 Oct 2015 19:38:02 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.37.59
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:38:01 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 4/9] i2c: brcmstb: enable ACK condition
Date:   Wed, 21 Oct 2015 11:36:56 +0900
Message-Id: <1445395021-4204-5-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49617
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

Removes the condition of a message with under 32 bytes in length. The
messages that do not require an ACK are I2C_M_IGNORE_NAK flag.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 2d7d155029dc..53eb8b0c9bad 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -330,7 +330,7 @@ static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
 	int no_ack = pmsg->flags & I2C_M_IGNORE_NAK;
 
 	/* see if the transaction needs to check NACK conditions */
-	if (no_ack || len <= N_DATA_BYTES) {
+	if (no_ack) {
 		cmd = (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
 			: CMD_WR_NOACK;
 		pi2creg->ctlhi_reg |= BSC_CTLHI_REG_IGNORE_ACK_MASK;
-- 
2.6.1
