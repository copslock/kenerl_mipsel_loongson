Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:38:17 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36210 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009191AbbJUCh74iW-y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:37:59 +0200
Received: by pacfv9 with SMTP id fv9so40945744pac.3;
        Tue, 20 Oct 2015 19:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U4tZPiPFaOKPQJ2+aso0mE0SmbALdnMqMlsviagSkiI=;
        b=cyIS/ScQWZVvFw8Vs4Mi6LMceMpaBfc2bEEghHCvnwrLLKWCFWrHKEwpDAVMMPreAj
         lfi0eWOKDDi4p7L8dQeFp18fPkHyijHW+hw3bdMWZKej393YxIFO0/ADA3TtgzlWzU+q
         LNxqSkJd/ib09eLkzDx6roru/zNqqY3ccmx1qLQwJLiZyOBtzzP78AJlDersEIRouI4S
         Y+OgeawoUQhMTkDANju06dRJ6md9H/I6VvI8xvu1ngJTqVnLX9m+gzFd4HCVyAmzZ7xl
         fNMpeT6BUq1x9FWUyLh/w5IDU6x8hjhlIetntgMD4Lf6R/LA2bxML1ovxfXpNMmKG/on
         Buzw==
X-Received: by 10.67.30.136 with SMTP id ke8mr7796433pad.16.1445395073862;
        Tue, 20 Oct 2015 19:37:53 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.37.51
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:37:53 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/9] i2c: brcmstb: make the driver buildable on BMIPS_GENERIC
Date:   Wed, 21 Oct 2015 11:36:53 +0900
Message-Id: <1445395021-4204-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49614
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

The BCM7xxx ARM and MIPS platforms share a similar hardware block for
I2C.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 08b86178e8fb..fd983c5b36f2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -394,7 +394,7 @@ config I2C_BCM_KONA
 
 config I2C_BRCMSTB
 	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.6.1
