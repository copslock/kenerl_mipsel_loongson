Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:13:27 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35790 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026144AbcDFML4b0w74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:11:56 +0200
Received: by mail-pf0-f194.google.com with SMTP id r187so4127090pfr.2;
        Wed, 06 Apr 2016 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXzErbNrQ4FWrOtdA3S0wF7XAoSmjWb8ftgOC2QmNus=;
        b=WcUUmPe5I5VTAjdOZlrxyWA/LkZij1+HzRGQN3B45gUn/51SAnlJMs5/DCuQxdO61d
         gVySFMLbqhm91gYpy4Dv4okWvWGgcRh6m0qTWFxxKBENx4F8l0Kiqgp07QI7vplTwNyn
         4y4+3tj2b+1a7GaI91KbV3Tnt4K6vAQhT2hGWgEgz0dw0IZ3DHKbFELJ7GzzjPlIoGyg
         Sc0TkLu7oXwKSnBoshYseA/82cPFWSF65H5oH7M5KwvD4ATeuML7xfPI79/GkyzBS3Rj
         8znZ9BGvSZX+aQLfvDOlaI1AFJbPBkO6Iw0iHW/h+thYxbVtT2QXK33lqnZgilZHeSYK
         BNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXzErbNrQ4FWrOtdA3S0wF7XAoSmjWb8ftgOC2QmNus=;
        b=Y+WgtJrcdYXFcFUbel5Hn8DxK3WQz23teBhBsLcYbaB2BjmiBER6q8C2YkSFylE2bv
         m7ZTsKPcLJtuyqHQ/n6l3PmWAxH2kBv6dAmQVyXXhjnYXFiJlOzGJvDVrxOHIaYkRQgK
         2XHCdgtGwuSDeznsbb+eU274/XwXRtq+His3xKSM7HjpoJP3czqnssGu1dC0+/JT02Ep
         RU+ZT5t2BsahmPIp4AYBe9taX1LxmFq64dVrfIJ4EzCnDhIejY/1qWJfvvmeQH9Jdgvf
         7AMSVOFGaMw418RXjj3I+TEcuAYrkbaDbhmSPOj3glmLd/ZdSKI8YlXwrl1f1Jw+gvc2
         8aMQ==
X-Gm-Message-State: AD7BkJIuz1HrfaY+ATavFCzsl2u2QlhpH1lGDgbcyiE+xoKhr5mclObn1MXjF+oGavsInA==
X-Received: by 10.98.71.92 with SMTP id u89mr37684562pfa.100.1459944710733;
        Wed, 06 Apr 2016 05:11:50 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 3sm4676177pfn.59.2016.04.06.05.11.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:11:49 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 7/7] MAINTAINERS: add Loongson1 architecture entry
Date:   Wed,  6 Apr 2016 20:09:37 +0800
Message-Id: <1459944577-6423-8-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
References: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds Loongson1 architecture entry.
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7..f6032a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7271,6 +7271,15 @@ S:	Supported
 F:	Documentation/mips/
 F:	arch/mips/
 
+MIPS/LOONGSON1 ARCHITECTURE
+M:	Keguang Zhang <keguang.zhang@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/loongson32/
+F:	arch/mips/include/asm/mach-loongson32/
+F:	drivers/*/*loongson1*
+F:	drivers/*/*/*loongson1*
+
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
1.9.1
