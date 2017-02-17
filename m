Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 19:31:10 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:41895 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992121AbdBQSbEB6N7M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 19:31:04 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id enJ0c2MrmC3JIenJ1cHlkG; Fri, 17 Feb 2017 11:30:57 -0700
X-Authority-Analysis: v=2.2 cv=XbT59Mx5 c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
 a=JVbjxlH5M4_l6XesofAA:9 a=Fp8MccfUoT0GBdDC_Lng:22 a=W4TVW4IDbPiebHqcZpNg:22
 a=AjGcO6oz07-iQ99wixmX:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 574BF34883F0; Fri, 17 Feb 2017 10:30:54 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date:   Fri, 17 Feb 2017 10:30:50 -0800
Message-Id: <20170217183050.31889-1-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfH9CepMBTSdfRYHYN3vQAcYz1nTKRUWz5+o//ftRcYhhfJUiQmfLHEDv6KuVGGG9phiWZ1MbupOiaS646yX01F2PG2QTbaaIhnrGNxpf5CxXyb8HpRV0
 eYawzhEBRMzoK/gaileFPvZ/bQVGlajUtG6CvGBzJEDct84pZf83UXW7q1SxE4kfdLOBvlEcrz8BIW0tMFSELUHeolt+Kv/pB9GkZ0umq9GwgeBVrb+GzeGn
 xa8wWRbTh3iYi0t9wFhma1btPa7TLmtacNtUX5PPndJBYLDr9SHVUoYwMSLlyyGD/GhlQe+Xxn1Qv3QCOg9fWf/1yICY3JFPWtGwdqwGSQ1E+nmah6sNF6rW
 MMAmTStCBDNL9fn1WmqlK2gdd7us+Q==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56862
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
---

This is based on PM's linux-next from today (February 17).

This patch could be squashed into patch 3/4 of the original series if that
is acceptable (see [1]) or it can remain separate.

[1] https://lkml.org/lkml/2017/2/7/775

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 107c10e..db251c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
+BROADCOM BMIPS CPUFREQ DRIVER
+M:	Markus Mayer <mmayer@broadcom.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/bmips-cpufreq.c
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
 M:	Prashant Sreedharan <prashant@broadcom.com>
-- 
2.7.4
