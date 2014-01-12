Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2014 22:29:52 +0100 (CET)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38321 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816852AbaALV3sFoNqz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jan 2014 22:29:48 +0100
Received: by mail-oa0-f49.google.com with SMTP id n16so7046081oag.8
        for <multiple recipients>; Sun, 12 Jan 2014 13:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GXW0AUwRF6t++2H01Rs3xR5ExHh0PsESc1sZaNKL5iE=;
        b=U+8zkffmxbo7UazEYjv1HQ9XH48bOCOt7D9yjOpgf/f4tuUVUeTgUp4u0+PXKpNm40
         W3x1ByWBaXAQ9pqxDxFlHj6RDdzvu601iN4pBTfT43hjmxapGonGDhDNw8euYj/LghBg
         7fWQ1rIRMhIMVO2bGs+mIDrT5+zkVYRfdrye4V2FhKwp/Xlr1yjUoiB19f09dT1Bz9SO
         FkztklC1GyBcsCTItHPhe16Z64RATn9yKNvnspnzBuWP31rkL2oYlEkUPLIAztt/eL+o
         jCwmqxdyNz7qctkOaGxblQuIWOSg13O4nvs1YyN0pEkVKNgsZK90nob0Q8Z+D3jg998R
         4GhQ==
X-Received: by 10.182.16.33 with SMTP id c1mr18100450obd.4.1389562181166;
        Sun, 12 Jan 2014 13:29:41 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id m4sm21274968oen.7.2014.01.12.13.29.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 13:29:40 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2 0/3] MIPS: L1_CACHE_SHIFT updates
Date:   Sun, 12 Jan 2014 13:29:29 -0800
Message-Id: <1389562172-13242-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

This patchset cleanups the MIPS_L1_CACHE_SHIFT values and also fixes it
for Broadcom BCM63xx DSL SOCs.

Thanks!

Florian Fainelli (3):
  MIPS: introduce MIPS_L1_CACHE_SHIFT_<N>
  MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
  MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value

 arch/mips/Kconfig              | 26 +++++++++++++++++++++++---
 arch/mips/pmcs-msp71xx/Kconfig |  1 +
 arch/mips/ralink/Kconfig       |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
1.8.3.2
