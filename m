Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 17:40:16 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:42019 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFXPkLfEFrT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 17:40:11 +0200
Received: by mail-we0-f172.google.com with SMTP id u57so558570wes.17
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=esh580jhtZbEbieOaQdHV3udSpX+iYvfjUHx9WOTC2A=;
        b=GU83bBIuRGcKc2Rhj2JD7bZYTcbTlFPxH+tyzVX5NhRcItOpbBbWOOgfflPD1NVKBS
         6UkDp24dD/AeTvmvpS4YQn0nOsmYrtWZYYAyVhwZjr6rF/PjihZSGnhbrCDJuVD4trfF
         cBTBF2cPpKAJkFP6Qn/1jgVNdfh3CxwabH5ao0iRrKetgbAngQZpiaTEHDhqetE6tCfu
         wcImZ4FH+UYt7qs90Ydky3K+51JELaw3TvOEigSSBcFHCVMNnWAfX7RRNMhH9Ezb9vHH
         d9lTTkIYWGHXaPXbLxIG8pnpmXdKT8+catUKUXS9iO2D9k4awpiao3p3hxY477LLNFTD
         kXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=esh580jhtZbEbieOaQdHV3udSpX+iYvfjUHx9WOTC2A=;
        b=mU9hsfvX6iqAtM+lWmkyLEd7VUAj2rqwQst5Cv6pYgOCd2ijyTKqdegfqkeKR7krTU
         YtbM0GlFAv2DukazF/zYhLvSO7nd5Q6lV9ZL+ApL4y4+jNe3tH/Tyur77qzMGHscygdL
         KDd61ccKM4ddeocmNlxgBuxLKV11+hZzecE0ikhho8+WwwXuV4nu46LaWigUtnaIYToB
         EnaEY1jBrUKwMRlGBjYexKuIG7RAf2/Kk+mwHKvpsUo8WINIU/neHoq+bH24z2nMjZXp
         w3OAp5/AEnv6l/asSRHpF4Mi39SJsXumjE12Wur5wqQozEa2zKRy9DPAdSZn9wfg7Zz+
         5iww==
X-Gm-Message-State: ALoCoQmD+GXSKBM8t4ATrwoB5XfPBttT5DEL5RbggfLUEubIVJrbxzKeQiYK4IuSEcWxxxFI0Yy/
X-Received: by 10.194.189.230 with SMTP id gl6mr2385902wjc.118.1403624401992;
        Tue, 24 Jun 2014 08:40:01 -0700 (PDT)
Received: from google.com ([2620:0:1040:202:2e44:fdff:fe1c:7ea6])
        by mx.google.com with ESMTPSA id h3sm1246373wjz.48.2014.06.24.08.40.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 08:40:01 -0700 (PDT)
Date:   Tue, 24 Jun 2014 16:39:59 +0100
From:   Daniel Walter <dwalter@google.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ar7: replace mac address parsing
Message-ID: <20140624153959.GA19564@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalter@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalter@google.com
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

Replace sscanf() with mac_pton().

Signed-off-by: Daniel Walter <dwalter@google.com>
---

 arch/mips/ar7/platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 7e2356f..653cbff 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -307,10 +307,7 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
 	}
 
 	if (mac) {
-		if (sscanf(mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
-					&dev_addr[0], &dev_addr[1],
-					&dev_addr[2], &dev_addr[3],
-					&dev_addr[4], &dev_addr[5]) != 6) {
+		if (!mac_pton(mac, dev_addr)) {
 			pr_warning("cannot parse mac address, "
 					"using random address\n");
 			eth_random_addr(dev_addr);
