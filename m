Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:02:18 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61837 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010186AbaI3SBYWnC6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:24 +0200
Received: by mail-pd0-f175.google.com with SMTP id v10so1199927pde.34
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xODcnWye9e26D/cYKydhptCAo4/qMB6B5smOr7yy5Ag=;
        b=PnPEu7DoVXBPTDnYESzx4pzDFHEDjX64WSaGL2Z0wCT7T3FvKObwX4E2rn5HurUX2p
         Mf69hxe+wyNbtCJeRDwDrm85wR0WW0DKdGFe8Vi0NfDbymUy7OpqyPrvsCoNI41ZCd+7
         yV9Sl7sMBZM1shpzFNJbZBO78Mw4okfUQij3m2N/mByPdB8deGo5avMB+fWhm8UH6K/E
         vRzGXz/H4yekJJFYrpDwRQs6cPxUkl3CRsvJXFHmBpII5/WZQhHbet+UTvuk2w20Fcsk
         cvNlcEf3/GcAK9d/Zc2QXEQLvvCdjPSyohI88E9a1+W2tBMZ3VsakbTLoUB+knA2iisV
         am3Q==
X-Received: by 10.70.101.138 with SMTP id fg10mr38976119pdb.1.1412100078313;
        Tue, 30 Sep 2014 11:01:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id f2sm15796187pdo.29.2014.09.30.11.01.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:17 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@arm.linux.org.uk>
Subject: [RFC PATCH 04/16] arm: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:44 -0700
Message-Id: <1412100056-15517-5-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42909
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

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 250b6f6..848c578 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -207,6 +207,8 @@ void machine_power_off(void)
 
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 /*
-- 
1.9.1
