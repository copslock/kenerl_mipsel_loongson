Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:05:31 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53635 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010198AbaI3SBtNO3y9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:49 +0200
Received: by mail-pa0-f50.google.com with SMTP id kx10so5827963pab.37
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xhae8JG4IKgahHtVJsKokrChJAWx38LPDikheOagtpI=;
        b=yWC9GhHUClICcw4veDar3e7EnMQnZAVzycH3e+Jnsd6+pbnAfbyuyMQOlqlkLfNVhO
         AbafPdPKfwEHtr4ihZCNAmpRaTS/JmdTBa1LZYdp7uYYFjqU7h3bVGpVDjGwOk07Bqe4
         uV/b1nrvBVbP9UPUUTIW8rWf9MmxxoQnwa+rr3q98MnVseCh/jgwe7FzGPzvskL2D7Gt
         NxWdCcS+cRoOfWc+JSL0c8to8LMVlz9esAEx8DepnRukgobo0KGKOJwhbtX7yks9PTWq
         YUFckjVzsY1oqrUnq1sFsQkS7PtMHpuOHQbGpmDnQKA1x7KjKqOs4llrWov8y9v2VbSZ
         EsGA==
X-Received: by 10.70.102.238 with SMTP id fr14mr27253716pdb.105.1412100103305;
        Tue, 30 Sep 2014 11:01:43 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id js7sm15716799pbc.62.2014.09.30.11.01.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:42 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 14/16] x86/xen: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:54 -0700
Message-Id: <1412100056-15517-15-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42920
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

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/xen/enlighten.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index c0cb11f..645d00f 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1322,6 +1322,8 @@ static void xen_machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 	xen_reboot(SHUTDOWN_poweroff);
 }
 
-- 
1.9.1
