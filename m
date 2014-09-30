Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:03:47 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37471 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010193AbaI3SBezf0EF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:34 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz1so6811475pad.16
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G0j+0t6HwoK+I4qL8X6NYSytTW0aLPSKNWyNS9RwGws=;
        b=ar0WknupWuj7t5RxWGK2ZAcgfwJZYO35npLS7rTzQKmgUoCwJW5vikVpOE9lCLrWv+
         Hqqd8c4qUNjJWLMJryad8L7GFwvnxjb+P30NOlyCUxq4DC6w4WRrFL39ao2QCHB2qXR8
         EQbFVP4QnbblnKjsy5byCrGE16KeCEWPg1j++xzHkdlW9AVrep1BTfTjqN1dMnikIY2V
         LWmmvQdWWLlG32mvq/bqIQmONjiEKseZC2IgSA9MoAqBAS7ZGBpwoJ3H+ZwZgEGGh8tF
         rfb6IijCBqJLmxUiEuiD/e6t7irOIwKY9tGDUTymCdcO4zQ+IufVl4lIIHylqlVsQd+G
         9mvQ==
X-Received: by 10.70.9.227 with SMTP id d3mr95078159pdb.16.1412100088167;
        Tue, 30 Sep 2014 11:01:28 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id fn4sm15864289pab.39.2014.09.30.11.01.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:27 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 08/16] ia64: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:48 -0700
Message-Id: <1412100056-15517-9-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42914
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

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/ia64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index deed6fa..489b0d8 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -677,6 +677,8 @@ machine_power_off (void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 	machine_halt();
 }
 
-- 
1.9.1
