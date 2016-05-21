Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:00:45 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36156 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027994AbcEUMAGQcZGI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:06 +0200
Received: by mail-lb0-f196.google.com with SMTP id r5so6875945lbj.3;
        Sat, 21 May 2016 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zcFCgrKE50OcjBBpDyanc2Z6UaauaH+yIDhHJM37rg8=;
        b=RhkOXj+/KF4UazXxhvZDTQDvy47Fcd52nqhttHUq5W27mLTPkEWKUlgModnW4JWIFv
         QNp8P5RfdYmTN467Sp88u/VZVhtUBzI829rD1iU/HNIKcWsBhJzgIBfXwRuq7i+tpCon
         kxRcrwD7qL2pp4PUKqhtYzkneW/ppkGzmzwdx8nVxw7Nv2TI6Ty82HHAi4M4jWpF6GcV
         lDKve91PFZZYURELJ9uFBEo3SFq1a31xht9+Tw/rO2Wvfxv+4gcUaAxukPgptbyvMsv/
         U7E2ZZARrucKJAR5o2pfvDeVwNRuvydmLodQgPq66Fjg+nvx/0NcE3B7A6EisY+cY8MB
         TjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=zcFCgrKE50OcjBBpDyanc2Z6UaauaH+yIDhHJM37rg8=;
        b=HR2r9rHgeyqXigR6OFb7pGo8b3xMXFK6PBkgG2v/vezj4vQPTcesygFGC7HELrwoQK
         C5qVWg0dqTdkxOCdTTHYP6Ph5pqUVPVUMzVHa8A+K2ur/zRXAIUf4+/VNgK576CRAdam
         diAJ3Ls0/dUXCYx+caE9AIhQCqLiLixgMEeZCFk5J9VW2NDMt8dDLgJJQMckacvxJu80
         +IVHXeWRgDYtewEc+6pIxNXRa+DEjc49uuM9m/TdLGmXhQlEjHor8XOSksH5mM8aQvOz
         yr5KGji6qEbK51hc8rWTCY9TWVj8aRdmbMPhkeJi7Bvfx7ExGDGw88AtQ445SDtOVOxt
         aEUQ==
X-Gm-Message-State: AOPr4FWn4U0MoGxcq7Z9nOxMS20daV3KcSYUYwIeaVrsQaDEazTfrcMhHYbNwbBNv12XxQ==
X-Received: by 10.112.124.228 with SMTP id ml4mr2321883lbb.113.1463832000947;
        Sat, 21 May 2016 05:00:00 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id zi6sm4187616lbb.5.2016.05.21.04.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 04:59:59 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0182/1529] Fix typo
Date:   Sat, 21 May 2016 13:59:56 +0200
Message-Id: <20160521115956.9339-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
index ce02894..d607d64 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
@@ -140,7 +140,7 @@ static inline int au1300_gpio_getinitlvl(unsigned int gpio)
 * Cases 1 and 3 are intended for boards which want to provide their own
 * GPIO namespace and -operations (i.e. for example you have 8 GPIOs
 * which are in part provided by spare Au1300 GPIO pins and in part by
-* an external FPGA but you still want them to be accssible in linux
+* an external FPGA but you still want them to be accessible in linux
 * as gpio0-7. The board can of course use the alchemy_gpioX_* functions
 * as required).
 */
-- 
2.8.2.534.g1f66975
