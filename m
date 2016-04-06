Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:37:55 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35839 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026155AbcDFMgWaydEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:36:22 +0200
Received: by mail-pa0-f66.google.com with SMTP id zy2so3965042pac.2;
        Wed, 06 Apr 2016 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+pRiiHA7XkVAYU/GGzoNKmRLfohg1tOJ5czNF82LvZI=;
        b=MUDq4RVH/+8OrX31PEGI2D/DtmPKEZxPRS1pX25heKbsW40qfXNFTBVm+fXOt0SNmX
         Cv7Erje1cTcOBTgOVtAKwi9WCeTC59Dd0EjJzMAgy5hP+DBzw363kYZoHAFpWc5qelfY
         3CK1EKtVPGXS/zTA3KPJc1C9A1g8jYyK7R49ZmftCBvy5tQoAUXr7SjFxeRDtUx3ktPN
         9R5X2XdO/0sAF5A7fuTpR14eJnOQlygL/KPJ+pHaGcfeQ69wVkMyUdozMo2bPDdmUq7G
         xeYbn6eqA5SO9EDDIFdvV8eZmt0hgEsjxSSf7Tqcb+hrSLEr7ENfDXihJQ2/cZOBT4do
         lJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+pRiiHA7XkVAYU/GGzoNKmRLfohg1tOJ5czNF82LvZI=;
        b=PYcKI+Epq/hQgkzCE+8GCVsQQvIHJrxYjhFrtb9GT8KqxGEqg5xCRyajyEwpXS7ZLY
         nzaS/2c/jx5uiKIe+ZT2b+6YunI9mxNzBuecjznMzheD+QXdt/wURnVyrCmG7lfRvmjq
         f4RtrDy2qBgZRTl00u0cYwF+Et+i24F+TPmvrtGUA0oay1HI+wdq6OixQczB3YegLoQk
         qejiKVPIg121tGxg9SpX6veDYDrGRN22R6Uh0+SM2AmCXj1UDt6zm9hXeR/0UUodp67n
         W2RN1gYQbZB1oM6fbf2T9iyNOCMoEiZHQgliLJHW0B2eUi5dA6W4XwXvHFxyr/itioAP
         4Hag==
X-Gm-Message-State: AD7BkJLNysDqJDWAlvt9zk9bT0Msc/NJ8syCn7I0lUyXjJYfdwrf8sMcUXM6BvVMN+xErQ==
X-Received: by 10.66.146.196 with SMTP id te4mr70655176pab.125.1459946176788;
        Wed, 06 Apr 2016 05:36:16 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 27sm4851789pfo.58.2016.04.06.05.36.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:36:15 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
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
Subject: [PATCH V1 7/7] MAINTAINERS: add Loongson1 architecture entry
Date:   Wed,  6 Apr 2016 20:34:55 +0800
Message-Id: <1459946095-7637-8-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52913
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

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
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
