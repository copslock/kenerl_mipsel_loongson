Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:34:21 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdCPOc0mHRo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:32:26 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D458A88;
        Thu, 16 Mar 2017 14:32:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 08/35] MIPS: Update lemote2f_defconfig for CPU_FREQ_STAT change
Date:   Thu, 16 Mar 2017 23:29:27 +0900
Message-Id: <20170316142907.261390617@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142906.685052998@linuxfoundation.org>
References: <20170316142906.685052998@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b3f6046186ef45acfeebc5a59c9fb45cefc685e7 upstream.

Since linux-4.8, CPU_FREQ_STAT is a bool symbol, causing a warning in
kernelci.org:

arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid for CPU_FREQ_STAT

This updates the defconfig to have the feature built-in.

Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15000/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/configs/lemote2f_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -39,7 +39,7 @@ CONFIG_HIBERNATION=y
 CONFIG_PM_STD_PARTITION="/dev/hda3"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEBUG=y
-CONFIG_CPU_FREQ_STAT=m
+CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
