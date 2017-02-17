Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 21:27:37 +0100 (CET)
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:52725 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992178AbdBQU1VZ3vxi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 21:27:21 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id ep7XcGS2JcWiHep7YcX4tu; Fri, 17 Feb 2017 13:27:14 -0700
X-Authority-Analysis: v=2.2 cv=JLBLi4Cb c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=pGLkceISAAAA:8 a=D19gQVrFAAAA:8
 a=VwQbUJbxAAAA:8 a=yp69CLIppT4I7jDT29QA:9 a=Fp8MccfUoT0GBdDC_Lng:22
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 1871234888EB; Fri, 17 Feb 2017 12:27:09 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date:   Fri, 17 Feb 2017 12:27:03 -0800
Message-Id: <20170217202704.33596-1-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfH9WYzlz+tJDVJ+NhfC4WFzN0X6kCXegMbyS0NqSOHSrPjtaL92qA5x60wALkD711R64i90HmkybK5q++99gfU4jNQkVJTn+bj+j+L55rH83lTGTO7us
 ujkxtIzVD91XOUR33OiltuQmz+VKKLW9SHoSMKKEzvxAwtUNDuuAlcKPgSaRbrV5Enyz2jf0g9EKqxrOlPqPB9klEPWQ/5WqkmzXIl4UBY9mjdTYN+PlRZT4
 vL11XJvheslB9GWoKVZZnGjvquUyV27pNgG4UU+61KR6GCM5x8QT9ZmZtHwmsdSV//hg5hhS/6ne4bNze1F2c9RXX1CglFssmCJ4oaaCZZzVlP2gwrQ4TlbH
 tZgltQF3N64nnT7/acZ/FwTN9ladIg==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: code@mmayer.net
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

From: Markus Mayer <mmayer@broadcom.com>

Add maintainer information for bmips-cpufreq.c.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---

This is based on PM's linux-next from today (February 17).

This patch could be squashed into patch 3/4 of the original series if that
is acceptable (see [1]) or it can remain separate.

[1] https://lkml.org/lkml/2017/2/7/775

Changes in v2:
  - added bcm-kernel-feedback-list@broadcom.com

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 107c10e..d4ac248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2692,6 +2692,13 @@ F:	drivers/irqchip/irq-brcmstb*
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
+BROADCOM BMIPS CPUFREQ DRIVER
+M:	Markus Mayer <mmayer@broadcom.com>
+M:	bcm-kernel-feedback-list@broadcom.com
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/bmips-cpufreq.c
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
 M:	Prashant Sreedharan <prashant@broadcom.com>
-- 
2.7.4
