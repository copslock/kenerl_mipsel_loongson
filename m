Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 22:53:33 +0100 (CET)
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:35550 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992221AbdBFVwauJvIT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 22:52:30 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id arD2cb3S2cWiHarD3clgsC; Mon, 06 Feb 2017 14:52:30 -0700
X-Authority-Analysis: v=2.2 cv=JLBLi4Cb c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=8Aiz8qQ5bdL30ZDUwwMA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id B4E2533ABBBC; Mon,  6 Feb 2017 13:52:28 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] MIPS: BMIPS: enable CPUfreq
Date:   Mon,  6 Feb 2017 13:51:19 -0800
Message-Id: <20170206215119.87099-5-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170206215119.87099-1-code@mmayer.net>
References: <20170206215119.87099-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfEQK0/vvn0KpNRERG9YSzE3h5eByvsczI0RuK7pHlGZD7N0JhgWBvdmAzJZh2QU1EvXuYPTYnHX0VrbB8TEcqzVQQBOE794/Yme4UgEDnhFaIcdWK0Vh
 fY0SxjNRJYeeVxOqfcTOCZZL73CVsAHYnF5u5A5N1ipnMwlvpxVyExiBsRXF8rtdDdxwo0znewfQAlG5lXGzYIueVniSDgYa+8E4VGZyWoO7tw7Z0+krXNux
 ty9ALEz1JW2PYAW/zmjPkZqwyglSlYMTjEaq7UrLHxgynz/aF24Cpwf+iRqPFeMM0BXIedUG9ypa0Va9fogBcRuk3Yi3N0PWUX6qsj5T2Di2MkZs+DY1D2Hg
 Ze98VrOFazSX094WN6C1IzecBjTpZw==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56666
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

Enable all applicable CPUfreq options.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/mips/configs/bmips_stb_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 3be15cb..3cefa6b 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -15,6 +15,14 @@ CONFIG_EXPERT=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
+CONFIG_BMIPS_CPUFREQ=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
-- 
2.7.4
