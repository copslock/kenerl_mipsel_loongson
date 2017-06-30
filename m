Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 07:48:16 +0200 (CEST)
Received: from mail-pg0-x232.google.com ([IPv6:2607:f8b0:400e:c05::232]:33243
        "EHLO mail-pg0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdF3FrNUOC0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 07:47:13 +0200
Received: by mail-pg0-x232.google.com with SMTP id f127so58490955pgc.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 22:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNf+3ZdwA0pkw3e3Ly13LkN0CHKMZ6CDCOKI2VxOsC0=;
        b=daNU1VF1Nj0sLN79j/jQhOFcsy3HCsY0wFIFQWib+U3BZ7/COA/pbMYEnklW6Bsdac
         syIDqOXtoBb6BA5W7StOu++qINIolIIyZiIGnocY/p+GLOXEijkMEjx2YwOH4f+pSCBu
         u4QKrauok7qjQv6lX84p/w2eOF+6bBtzsOwiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNf+3ZdwA0pkw3e3Ly13LkN0CHKMZ6CDCOKI2VxOsC0=;
        b=HkQQE1E/AhfWMzd3KSzXSxjnd3jLi1FMsBN5Ccse3MKjT3ZobowkooKVhSx4yZA/T8
         2q0c4rcvvEUu/febUIFjeM1rse4kwbZ+ay3uVYsNwQCU/LNYz2CU0lWSMDD8QZswV80Y
         d7ctkXiThAJz64PebPuMrgNdG6u3IYYYdNlc3QqZKNtSCA1Vh1bCb7kWcrslpdRUSEku
         xGBghdmUcAS+4y0u0nbi7Ru1ByG0Xe64/iUntdgAOw+7srxAAG/GkkwnRK7/TPVPNefy
         xC6VLC32nhJOvJ90p/xEO9gQHzoFQkskVRbQ2hB34mkcjgKv71zoiYuEnQc6SXDB5HVN
         S+wQ==
X-Gm-Message-State: AKS2vOxVUyJP/k4cK7ZlOUdtA2h6zzo5CL4aTZ8CDqQHNA82Z0B1yZij
        u5CeCYAcxyvTd1LOgoNqyw==
X-Received: by 10.101.85.206 with SMTP id k14mr18987953pgs.153.1498801627575;
        Thu, 29 Jun 2017 22:47:07 -0700 (PDT)
Received: from localhost.localdomain ([106.51.129.233])
        by smtp.gmail.com with ESMTPSA id a187sm11405550pgc.37.2017.06.29.22.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 22:47:06 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>, John Crispin <blogic@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 07/16] MIPS: ralink: Fix invalid assignment of SoC type
Date:   Fri, 30 Jun 2017 11:16:31 +0530
Message-Id: <1498801600-20896-8-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
References: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: John Crispin <blogic@openwrt.org>

commit 0af3a40f09a2a85089037a0b5b51471fa48b229e upstream.

Commit 418d29c87061 ("MIPS: ralink: Unify SoC id handling") introduced
broken code. We obviously need to assign the value.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11993/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/ralink/rt288x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 15506a1ff22a..9dd67749c592 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -109,5 +109,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	soc_info->mem_size_max = RT2880_MEM_SIZE_MAX;
 
 	rt2880_pinmux_data = rt2880_pinmux_data_act;
-	ralink_soc == RT2880_SOC;
+	ralink_soc = RT2880_SOC;
 }
-- 
2.7.4
