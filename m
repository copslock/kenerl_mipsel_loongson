Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 04:32:35 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33920 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006509AbbHSCceAPi10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Aug 2015 04:32:34 +0200
Received: by paccq16 with SMTP id cq16so102258148pac.1
        for <linux-mips@linux-mips.org>; Tue, 18 Aug 2015 19:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:content-type
         :mime-version:content-transfer-encoding;
        bh=MaLCWifzPZd2dqOKq0F/PXJjPTU/zB7gzlo9aC/Vciw=;
        b=HV+hV+HKspuYMdI2j5C5rCSkhaGei9+1JYMbIz6U7sqJehDC8652cwamxmXvec+iYV
         Iksr+RW+5loBPeYj/wBsOjLAsdLzOgQVmMlqG8lt0iV986UdpbbXWnX95YrGuvdCQ7XO
         Zq3At5hxuKzDdEStmZSSVRZRs/oOOXO5+AGeiq0Kkj1fURCQaM5VTGWFD0gv8+XS8oSK
         lu4R2SFkVEFnxNtvTov7ocWpKvZ5YXNnqNSvZHWsbzPI9g+1CYBH2c/bVlVIu3ZIXcKN
         6EIFMMT0oGto05qLBHEbPPqhp/7Jtt8GOVqBg9KZi+3EUZR7+razanYeIjK6MvDKshIu
         DIFA==
X-Gm-Message-State: ALoCoQlk1U/jMWGdD2tV74Vg/RtKLzeRNn5qlN2acXuU5S9wlL+Xv4E+juz0JDNIjpsWth0pvp7F
X-Received: by 10.68.220.199 with SMTP id py7mr19893904pbc.150.1439951547658;
        Tue, 18 Aug 2015 19:32:27 -0700 (PDT)
Received: from phoenix.local (118-171-143-134.dynamic.hinet.net. [118.171.143.134])
        by smtp.gmail.com with ESMTPSA id fs13sm19610697pdb.29.2015.08.18.19.32.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2015 19:32:26 -0700 (PDT)
Message-ID: <1439951543.14674.1.camel@ingics.com>
Subject: [PATCH] firmware: broadcom: bcm47xx_nvram: Fix module license
From:   Axel Lin <axel.lin@ingics.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?gb2312?Q?Rafa=810=920_Mi=810=920ecki?= <zajec5@gmail.com>,
        Paul Walmsley <paul@pwsan.com>, linux-mips@linux-mips.org
Date:   Wed, 19 Aug 2015 10:32:23 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <axel.lin@ingics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: axel.lin@ingics.com
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

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 87add3f..e415945 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -245,4 +245,4 @@ char *bcm47xx_nvram_get_contents(size_t *nvram_size)
 }
 EXPORT_SYMBOL(bcm47xx_nvram_get_contents);
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.1.0
