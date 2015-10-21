Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:38:33 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34923 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009210AbbJUCiCVm8hy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:38:02 +0200
Received: by pasz6 with SMTP id z6so39410154pas.2;
        Tue, 20 Oct 2015 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5qrRAgzqf7jHwgIRTCP2yOkQUgaa2mejCbIO2hVsf9M=;
        b=j7JEko7WQAfQDTC1adlXqj5+LZroygCbkIx09c/R2yHpUxFVWTnwT3aauOaPJSISVv
         EH+Uwwtq5ZySDcyhPeBSMjRf4pn+VP73Wu62+kv2mbEaZ0TYkqVKn3rafDzPCQVN7WGd
         0sGJaN5yy8BipaQGySo2HkuTqckc39bnK70rXxUpOKBN81jHrDmuQV3c+UIyazDNOCdO
         s1Q6rzLlbS7iCSMKRN8p69CKwuDY1Heul92XMJ6uyTlWMTnlyBiaaWMlchpmU2UK9vQI
         fgJa9kwuFxUAn0MqBKy+1s/V+sTNaiw8bnBcYEpy6CVzJldfDP6QOgsdGFRPHuBnpCZC
         I2Pg==
X-Received: by 10.66.131.81 with SMTP id ok17mr7441941pab.150.1445395076601;
        Tue, 20 Oct 2015 19:37:56 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.37.54
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:37:56 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/9] i2c: brcmstb: fix typo in i2c-brcmstb
Date:   Wed, 21 Oct 2015 11:36:54 +0900
Message-Id: <1445395021-4204-3-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49615
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

Fixes the "definitions" where it is spelled "defintions".

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 8e9637eea512..6b8bbf99880d 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -41,7 +41,7 @@
 #define BSC_CTL_REG_INT_EN_SHIFT			6
 #define BSC_CTL_REG_DIV_CLK_MASK			0x00000080
 
-/* BSC_IIC_ENABLE r/w enable and interrupt field defintions */
+/* BSC_IIC_ENABLE r/w enable and interrupt field definitions */
 #define BSC_IIC_EN_RESTART_MASK				0x00000040
 #define BSC_IIC_EN_NOSTART_MASK				0x00000020
 #define BSC_IIC_EN_NOSTOP_MASK				0x00000010
-- 
2.6.1
