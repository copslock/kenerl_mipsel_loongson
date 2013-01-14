Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:13:20 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4472 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831952Ab3ANQMnlFnPm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:12:43 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:07:16 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 irvexchcas06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server id 14.1.355.2; Mon, 14 Jan 2013 08:09:38 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1B7E240FE5; Mon, 14
 Jan 2013 08:09:37 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 08/10] MIPS: Netlogic: use preset loops per jiffy
Date:   Mon, 14 Jan 2013 21:42:00 +0530
Message-ID: <1358179922-26663-9-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF2BE3Q42012102-07-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Doing calibrate delay on a hardware thread will be inaccurate since
it depends on the load on other threads in the core. It will also
slow down the boot process when done for 128 hardware threads. Switch
to a pre-computed loops per jiffy based on the core frequency. The
value is computed based on the core frequency and roughly matches the
value calculated by calibrate_delay().

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/time.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
index 20f89bc..5c56555 100644
--- a/arch/mips/netlogic/common/time.c
+++ b/arch/mips/netlogic/common/time.c
@@ -98,6 +98,10 @@ void __init plat_time_init(void)
 {
 	nlm_init_pic_timer();
 	mips_hpt_frequency = nlm_get_cpu_frequency();
+	if (current_cpu_type() == CPU_XLR)
+		preset_lpj = mips_hpt_frequency / (3 * HZ);
+	else
+		preset_lpj = mips_hpt_frequency / (2 * HZ);
 	pr_info("MIPS counter frequency [%ld]\n",
 			(unsigned long)mips_hpt_frequency);
 }
-- 
1.7.9.5
