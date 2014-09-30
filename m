Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:03:09 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:43084 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010191AbaI3SB3JBH4w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:29 +0200
Received: by mail-pa0-f48.google.com with SMTP id eu11so2214175pac.21
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0ih17lI6gLUFbnReJlh1XiIUybLfUhsfMTgyyqRLFE=;
        b=JJ1JFLtC0WTcVqWHax+xx1aKWBWGCpkaWUAfurr2/+S8wX0o+EO/DGlAkCw2e4T8fj
         fCK2NWlKRhrbhmUu+GVwmx/mANJ73tnqkDqcatiBQY7vRA7HU/FCFFn3QvLrNcfvdAxr
         lAM6vFQhd1gh19amzz1JwO5IkOJ3VXM2wbJCFHxbJNp4512/hPXs9xdbMDvsqRUlWfmd
         QQ9nmVibgb3cGOfYG4fyJMtjY+x7ThPjXAZd77nr+oM9qGtZPR5lFKUkH2IZzW4dnjqx
         dOKShG+rXyic944v/Z7mvmtCV+yiIO0Pl8YJ6b9xu00dy3xUlYeS9/dWkKhdkBDY0zeF
         Yk6A==
X-Received: by 10.70.65.34 with SMTP id u2mr90724887pds.58.1412100083255;
        Tue, 30 Sep 2014 11:01:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id z1sm15802187pdb.21.2014.09.30.11.01.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:22 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: [RFC PATCH 06/16] avr32: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:46 -0700
Message-Id: <1412100056-15517-7-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42912
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

Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/avr32/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/avr32/kernel/process.c b/arch/avr32/kernel/process.c
index 42a53e74..6bd6289 100644
--- a/arch/avr32/kernel/process.c
+++ b/arch/avr32/kernel/process.c
@@ -50,6 +50,8 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 void machine_restart(char *cmd)
-- 
1.9.1
