Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 02:07:46 +0100 (CET)
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:52364 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993903AbdBBBGo5b6cl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 02:06:44 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id Z5rGcu5aQsa1kZ5rHcJ48D; Wed, 01 Feb 2017 18:06:44 -0700
X-Authority-Analysis: v=2.2 cv=W+NIbVek c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=11j9IE0nUPRNsVqZ2AoA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id ABF1C3378516; Wed,  1 Feb 2017 17:06:42 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Date:   Wed,  1 Feb 2017 17:06:01 -0800
Message-Id: <20170202010601.75995-4-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170202010601.75995-1-code@mmayer.net>
References: <20170202010601.75995-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfPNei28lr/vlhlgBUAytNpxMCU7DvrrZSQhB3XrgGYRW0odzXrCoLBYNWMmZ+GKHM1uIhSkvbhm+E8vz1YhbKIJ0MwGt9Y0MpORcYJwc0tLco9sSZSAq
 +bU5RYFBd/3RMuETw22GNloutHF8W4ihh8669q2oYsKi6iOcZnNXAN+wc9jGQmPCEx3r4Np3kKy/+1cIceA0ngJrXYQmSq7Sku8cp9HdTxzdDqTCqWGBUvGU
 ZZPwYNjF5CW64dZc9DGCopkS3QnWbARNinxP7Ju4IyHzXXxQ6svzIc+jBetOKVNXdGj3cLpz3noKpaKiNZrAaaIrujvMwFzX94iO7SR8Op5E/6kZZgymsJuq
 s4MH9z1Y626xFOGf22cRYqDw+F13fA==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56584
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
 arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 4eb5d6e..6fda604 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -26,6 +26,16 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_BMIPS_CPUFREQ=y
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
 CONFIG_MAC80211=y
-- 
2.7.4
