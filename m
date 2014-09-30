Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:04:56 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:61346 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010180AbaI3SBn5dLbZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:43 +0200
Received: by mail-pd0-f181.google.com with SMTP id z10so5612666pdj.12
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AXCXelfFBF9Qup1zIS8kAW0koqpAsX+wMSHV+onBGiQ=;
        b=cRpyTkRrkvfbaSD+MQoYF5i8oJdCHhGsKjqZQb4M1oZyTFQb1ZKmCBvMva2VBOt5gn
         im9NveAX09uE8Fv/RlxANtb7rX7MgFfEhUE+FXZ9tsMnOrYzBu84LFmUmSvE8ADmx5+v
         dYFtm7tpuee+PLiXwxnCij0xpdrRe3zaBlhjqYapKbjeBSYN+lc9IpXhLe3DlsiGIOTa
         bkQakGxZubmnnpJGepOW4bupkaskL9jQRLlwwiTASos1nhREgrzi709z6AyUCqSD398b
         v6pXnP9vkwJLoEmb/5NO7gazUo6vK1lXP0ibtpfmihlEZUDGDHXuctci+2bn3L7kzG0Z
         EPyw==
X-Received: by 10.68.132.65 with SMTP id os1mr72153041pbb.82.1412100098050;
        Tue, 30 Sep 2014 11:01:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id v11sm15871201pas.24.2014.09.30.11.01.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:37 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: [RFC PATCH 12/16] unicore32: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:52 -0700
Message-Id: <1412100056-15517-13-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42918
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

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/unicore32/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index b008e99..421fde6 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -66,6 +66,8 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 	machine_halt();
 }
 
-- 
1.9.1
