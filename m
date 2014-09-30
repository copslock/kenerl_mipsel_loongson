Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:03:28 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:48700 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010192AbaI3SBbp0Cen (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:31 +0200
Received: by mail-pa0-f41.google.com with SMTP id eu11so4621982pac.0
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9/IS+ZKFFBcD9R5m5I1IT3+QCzRy1+NN7vHGygIi9w=;
        b=n4qqwYKuxk4+u9l9Ui1UVXzXAp5TZP3eVIsdhuLJaTL88bSxsTAa8YUbZ2wyg0vTKL
         mOMHOOEAlH1q9UcBXgv9HU5JAlpFRpDqlD2onxLYv1q324ZoWNmXe2oplAUL9XGYESuY
         dQ4pG9CW6H9PsrDOwLKUxqm00EFulIyTtzERgfwzgrNXpPTU9ZNe0vWAxsTFK7g5bEim
         qT8pLeaSXBe/7wBaD/TkwjPEpURxG3WlkR07sjTef8JYOvRsH4KygejqgvNnnqVOi+34
         XzRbqR7nFIVVj+EDjNUhHOCpWY4aoRLzADkCET42Qtr5se6L4Lytj9ixllhsljq57Agc
         Sf8g==
X-Received: by 10.70.118.38 with SMTP id kj6mr5588109pdb.167.1412100085704;
        Tue, 30 Sep 2014 11:01:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id ad6sm15688353pac.30.2014.09.30.11.01.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:25 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>
Subject: [RFC PATCH 07/16] c6x: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:47 -0700
Message-Id: <1412100056-15517-8-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42913
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

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/c6x/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
index 57d2ea8..ddf088e 100644
--- a/arch/c6x/kernel/process.c
+++ b/arch/c6x/kernel/process.c
@@ -75,6 +75,8 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 	halt_loop();
 }
 
-- 
1.9.1
