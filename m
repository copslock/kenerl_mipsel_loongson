Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 19:56:07 +0100 (CET)
Received: from mout.web.de ([212.227.17.11]:50992 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbdARSz4s0Hy- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 19:55:56 +0100
Received: from [192.168.1.2] ([78.48.198.118]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MK20H-1cSYU93Fiv-001VAG; Wed, 18
 Jan 2017 19:55:45 +0100
Subject: [PATCH 2/3] MIPS: MT: Move an assignment for the variable "retval" in
 mipsmt_sys_sched_setaffinity()
To:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
References: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <186a1226-41df-6364-2eb9-9a2132571759@users.sourceforge.net>
Date:   Wed, 18 Jan 2017 19:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:T8M2o2HT6dqoKNkLXjIxpMo5cpg7KCPBNPR7sUDEPEiJp0DlIBg
 NsboSVUyUXE4Rre9IMLgBQjnERJd2rlFT9G/efWNnx2+QROytrqB6KYzTFpTIOWTayiqAt9
 dETZa4b1zwr54ELQB0xz7wi8S7rUxQndqX8F+H2X3gH4HslWOU1gOtleRqgiZvLIEWOvfKL
 jsZecTQkAN78aVizSHnlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZPIf5upr0fc=:KQbx64Nxya+TjSIxM7Mxvd
 Zkq3lcWHRcnErejM86cV14Z6VJeMFgYj0XcgKus529toEcbbKpkj4vOs4lSmc5H8XG0/OasA6
 yp+MYBtBjBoBMG2ndJ1fLBdlUgn+YugLXdoPtIi9R4LEBgL4tUZsvlL0WHYMCcG1QHG4YN8Jy
 XuOkFOhBzqyx4xXwPWq6TNUhz3Qv5r7csL8jsWzFTAVeLuzCzmVQNgRcpGOEFa+HHPnVw6IVq
 jiOX+VOK2CP8GPBmxiEbxj++RKO6SV8eatjURciO2UQL2Bj4dbZZUkRreYdrZUj8wrM7SjIMh
 nIS1Bpt6Bbmw+k2ByXcw2WMATY5NBN9N2hcJRRFKdn48bKWAZwOsPfR4TQDmJEHvc2IOhgLgc
 MKmjedzzBuSSR6pnHC2Q5erJ+0azrgR4S/jVy7R2qug8xlxYuzfgqGrCwbAaQewTK+O1ZMQfH
 aZXVHIR9evKjvgimk1xnf/J+0sOHU+n/AmqP4RPBog6O7FlQDGzLiflXulVfjLx1A+DpsC0uO
 BSDqn2zm1wshwAy2aQKVJtnP3YBszX1hPPh6B4ezGvIDj6EG2odnaYLU8n7+d+8H6Da+zh0D7
 BtyFScwdflrKBevGLzC3DA9Do0wS5y8I/2yPcKjRc1OPdbSUlO1xCqJSccNsmYoybkPyWv+76
 2QM1EoWz0pm7OGi1PC5KiATsQ9/HZOL5uqT1Ja7tdq2GsNN8UEMN5EXln05E5QzZVicXmwRdk
 uaDhDRTMUdoYsShN+OnZqzvhyvk7eZG0PPYsIY+ir3C+UKwOXBfKD4NfbH0t/gSTf4aGgP70m
 c6p5MIg
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 19:18:37 +0100

A local variable was set to an error code in one case before a concrete
error situation was detected. Thus move the corresponding assignment into
an if branch to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/mips-mt-fpaff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 789d7bf4fef3..ddde22787287 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -99,9 +99,10 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 		retval = -ENOMEM;
 		goto out_free_new_mask;
 	}
-	retval = -EPERM;
-	if (!check_same_owner(p) && !capable(CAP_SYS_NICE))
+	if (!check_same_owner(p) && !capable(CAP_SYS_NICE)) {
+		retval = -EPERM;
 		goto out_unlock;
+	}
 
 	retval = security_task_setscheduler(p);
 	if (retval)
-- 
2.11.0
