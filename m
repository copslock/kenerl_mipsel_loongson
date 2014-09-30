Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:04:39 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64140 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010179AbaI3SBl19Rni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:41 +0200
Received: by mail-pa0-f50.google.com with SMTP id kx10so5752583pab.23
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAXCMmVwJSULMwiRV//srkVmaF6y7Bt28jllwBmlSX0=;
        b=UQWLtII3AKEXnouKAsGaowR5gbZBB8/A3XkbVEHmB0ACUBjj4BTUkZ/pSGotRbD788
         O5Nowv3Epq62WR95Gwai76Au+kIHRRcJSXH5i5fBESYeWrA7R41g4OTkqrqiyN3fsrTV
         lfpxZAKTwb45Dobr8P0mhJxmLbZZSfHQpkN1DIc8bNo+A6JjBIKryRTBvGEheGtcmFZ2
         HBqx0zD6xRCxfuZdDYs8DrGUWDZNjO+HnlM6xTR/UrWeNrjIkR29ChsDiHD/dMpYsAwq
         LQyt4RojVo3i3GCuZKorABcldRtJDjurrkcgjLsB1Yrb6cdnDahflvnmq0+LsxzJJ0jr
         QlXA==
X-Received: by 10.66.145.167 with SMTP id sv7mr70694399pab.5.1412100095581;
        Tue, 30 Sep 2014 11:01:35 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id od12sm4477834pdb.96.2014.09.30.11.01.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:35 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 11/16] sh: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:51 -0700
Message-Id: <1412100056-15517-12-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 04afe5b..8e68926 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -53,6 +53,8 @@ static void native_machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 static void native_machine_halt(void)
-- 
1.9.1
