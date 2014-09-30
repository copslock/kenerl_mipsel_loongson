Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:04:22 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56847 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010116AbaI3SBjQ3NB- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:39 +0200
Received: by mail-pa0-f42.google.com with SMTP id et14so2292695pad.29
        for <multiple recipients>; Tue, 30 Sep 2014 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1jTsrjIy7XPXCWfuk8ulIaPqKvEJId6ShVaPWTNgoDI=;
        b=yj1Za2whQ+BkBD6abAdE/tJhcGNoxf7xsJcIp9AmS0GHifa7jXcob/SfPz4CvyTvnY
         7UKp7SIwgokc6jPRkvEBVwgVZcThfmd2hv1B3Uudx1ZfwB9Mm0nRs+6t/Ymu1SciNo+t
         KpracvyPWSQN7rMcx+s8rl1ru+EMCmhVTTGT18EHiJNtcoX5krsAq7aafF7mSVWpFIrK
         28RHyXYvzObpvfEwuzLTZjC+m3mp1zLd7FJ+U+vx1bBUB0JE9l//KMFZLyy29fOTfC4n
         roZss9jVs8Y2MMwlZ/AOONeLLBve995VihX65mlkukMWvuc5hGHZ4rHZw8tGn5iGwCD8
         XwYA==
X-Received: by 10.66.162.40 with SMTP id xx8mr72097131pab.31.1412100093148;
        Tue, 30 Sep 2014 11:01:33 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id b4sm15815976pdh.2.2014.09.30.11.01.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:32 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [RFC PATCH 10/16] mips: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:50 -0700
Message-Id: <1412100056-15517-11-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42916
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

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/kernel/reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..c3391d7 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -41,4 +41,6 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
-- 
1.9.1
