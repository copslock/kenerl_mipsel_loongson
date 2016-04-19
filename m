Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 00:26:54 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35128 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026501AbcDSW0wPBAOB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 00:26:52 +0200
Received: by mail-pa0-f48.google.com with SMTP id fs9so10814303pac.2;
        Tue, 19 Apr 2016 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=n7Z2CmQJwXQx3kAWEONzbVVC7kors9zux2/xkYPj2Eo=;
        b=CuO13gq0pu8YvKKv7jQQv/xW8eoVCoRbLXOt3JMo75nkKDY8XW4t1zZV+ABGbu5033
         kFX50gToDkoETgnJGc1NvsUAiWKZu+Zwodf9vkmeoYbQC3MQyCuFQt2mmFGqNFIOlD8L
         k7s9qAC+ZFaFJpPL2YbP8IqULbsZrIBcTkIgVg5NNrYLAFcSabFrf1qi8I2hyRbimq1y
         HtWem2q+PCTVadB2ZOaQ4pgpImBnsGi+g7CuwlALSL0XyNduafJzenVml743/dEUjns0
         1ajZ9QOJ7QCuxmTq8VmQ5qdTakhgqvF0AjHAWxOYTtXZIpuQoyrHds30/ixa0jGIm8cb
         YwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n7Z2CmQJwXQx3kAWEONzbVVC7kors9zux2/xkYPj2Eo=;
        b=Ha5G+K9eDEFyRsj0moJSVm716uKUwcm63Hmr3TvsXxhxtOYJyfPIFbOev6VTMxg2qb
         iNytjxRF0BrzfX7VvFbRy3SB89hcsafe6kIq3OVrIBgM7pimOMAYltPDfvJwDJ3rmVIE
         gZmfv8Yib2wBgiWmfoiHJJC1/pGuJ/fQBf9k/8obuIusbcDkwwPBaTXaZsBu4PXYou39
         C1SRAS7shaix+ZD6N0vvWhtEr9/iwR1BeXSnym/Y7+6d4NHZOAaHopGKubuwLDx3qsQN
         fjlYUQIZdwljVuIkGXfUpTTrNkZDiDODcp/S2pP7YnRtYWIzsLJym2GsZT6eV113nAst
         1WXw==
X-Gm-Message-State: AOPr4FWlORL0Fzwj0cOYmDXVWw30JXJEeODk0ghXzmBVlUxFPwJCqLZGOZqUc5pDBpzheQ==
X-Received: by 10.66.221.136 with SMTP id qe8mr7483167pac.7.1461104806155;
        Tue, 19 Apr 2016 15:26:46 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id v189sm26059478pfb.85.2016.04.19.15.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 15:26:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jaedon.shin@gmail.com,
        Florian Fainelli <florian.f.fainelli@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Adjust mips-hpt-frequency for BCM7435
Date:   Tue, 19 Apr 2016 15:24:33 -0700
Message-Id: <1461104673-21878-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian.f.fainelli@gmail.com>

The CPU actually runs at 1405Mhz which gives us a 175625000 Hz MIPS timer
frequency (CPU frequency / 8).

Fixes: 8394968be4c7 ("MIPS: BMIPS: Add BCM7435 dtsi")
Signed-off-by: Florian Fainelli <florian.f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7435.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index cce752b27055..a874d3a0e2ee 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -7,7 +7,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		mips-hpt-frequency = <163125000>;
+		mips-hpt-frequency = <175625000>;
 
 		cpu@0 {
 			compatible = "brcm,bmips5200";
-- 
2.1.0
