Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 12:10:09 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33987 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822668Ab3JaLJmJ2M15 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Oct 2013 12:09:42 +0100
Received: by mail-pa0-f42.google.com with SMTP id kp14so2368847pab.29
        for <linux-mips@linux-mips.org>; Thu, 31 Oct 2013 04:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pVlwOtswNBL+VMZUrQr48J57sRS0MjPcTKQ+joE4VO4=;
        b=LUlmJ4xuDeabmS1oa3gYvire5uA+L2/JI1wWYGBTv7OgF67pZIRqD9CAtLv0wYpQac
         rg88mudQwOTuaNoGqltt6JLC0Cx87AEo2owGGZ1+pqdnJDhhWJsNHu9gpUE3uemPFeos
         Gcb53WDyOph7lItiw/POLgxC0x1raXyVRZnfGQF6cxSmNaIge2U0kH2MsSAXOSs6Tqu6
         7sApgPY++2mneTwQ67b+2OFMc9m/sIGalh9uzQOCSwKHjaP0G+szWPItmyWH+U8+oUX5
         SHa+97GCzNUxQ73jYB1dWkXxdPk8TTIqJqDZsFiu1LdEmlnjFBGfa1tc6AYvmDQbQqoj
         MkJw==
X-Gm-Message-State: ALoCoQmyxeSSXOToLSgIapiO548T0zDlNcRTPvh9zxURTzQ44NC+hn5a7z+4De4pPNKzu/kFOjYC
X-Received: by 10.68.197.104 with SMTP id it8mr2462872pbc.17.1383217775952;
        Thu, 31 Oct 2013 04:09:35 -0700 (PDT)
Received: from linaro.sisodomain.com ([115.113.119.130])
        by mx.google.com with ESMTPSA id hz10sm3446333pbc.36.2013.10.31.04.09.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 04:09:35 -0700 (PDT)
From:   Tushar Behera <tushar.behera@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@linaro.org, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/5] MIPS: ralink: Use devm_ioremap_resource
Date:   Thu, 31 Oct 2013 16:38:03 +0530
Message-Id: <1383217687-12037-2-git-send-email-tushar.behera@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
References: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
Return-Path: <tushar.behera@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tushar.behera@linaro.org
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

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: linux-mips@linux-mips.org
CC: John Crispin <blogic@openwrt.org>
CC: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/ralink/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index e49241a..2027857 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -126,7 +126,7 @@ static int rt_timer_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	rt->membase = devm_request_and_ioremap(&pdev->dev, res);
+	rt->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rt->membase))
 		return PTR_ERR(rt->membase);
 
-- 
1.7.9.5
