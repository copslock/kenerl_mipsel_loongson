Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2012 01:07:38 +0100 (CET)
Received: from e32.co.us.ibm.com ([32.97.110.150]:58395 "EHLO
        e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903867Ab2AXAH3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2012 01:07:29 +0100
Received: from /spool/local
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <jstultz@us.ibm.com>;
        Mon, 23 Jan 2012 17:07:22 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 23 Jan 2012 17:06:17 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 74C483E40055;
        Mon, 23 Jan 2012 17:06:16 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
        by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q0O06AEi160132;
        Mon, 23 Jan 2012 17:06:13 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
        by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q0O069a7004339;
        Mon, 23 Jan 2012 17:06:10 -0700
Received: from kernel.beaverton.ibm.com (kernel.beaverton.ibm.com [9.47.67.96])
        by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q0O068tD004236;
        Mon, 23 Jan 2012 17:06:09 -0700
Received: by kernel.beaverton.ibm.com (Postfix, from userid 1056)
        id B0A9EBFE5C; Mon, 23 Jan 2012 16:06:07 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yong Zhang <yong.zhang0@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH 3/3] clocksource: Convert mips pnx8550 to use clocksource_register_hz
Date:   Mon, 23 Jan 2012 16:05:50 -0800
Message-Id: <1327363550-19952-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 1.7.3.2.146.gca209
In-Reply-To: <1327363550-19952-1-git-send-email-john.stultz@linaro.org>
References: <1327363550-19952-1-git-send-email-john.stultz@linaro.org>
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12012400-3270-0000-0000-0000036FE78C
X-archive-position: 32317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john.stultz@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch converts the registration to use clocksource_register_hz()
but is clearly broken, as the pnx_clocksource doesn't seem to set a
proper mult/shift pair.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: Yong Zhang <yong.zhang0@gmail.com>
CC: linux-mips@linux-mips.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/mips/pnx8550/common/time.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pnx8550/common/time.c b/arch/mips/pnx8550/common/time.c
index 831d6b3..006ac88 100644
--- a/arch/mips/pnx8550/common/time.c
+++ b/arch/mips/pnx8550/common/time.c
@@ -104,7 +104,12 @@ __init void plat_time_init(void)
 
 	pnx8xxx_clockevent.cpumask = cpu_none_mask;
 	clockevents_register_device(&pnx8xxx_clockevent);
-	clocksource_register(&pnx_clocksource);
+	
+	/*
+	 * XXX - Nothing seems to set pnx_clocksource mult/shift! 
+	 * So I don't know what freq to use here. Help! -johnstul
+	 */
+	clocksource_register_hz(&pnx_clocksource, 0);
 
 	/* Timer 1 start */
 	configPR = read_c0_config7();
-- 
1.7.3.2.146.gca209
