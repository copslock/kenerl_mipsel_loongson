Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:02:34 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36170 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010189AbaI3SB0lrgwN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:26 +0200
Received: by mail-pa0-f51.google.com with SMTP id lj1so5322320pab.10
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TzcCHtPdGztIVjoHbZsaQvqPX/Y0aBGG2kKGL2CTln8=;
        b=NiOI/zSrZYv37kCzWtq/pdRCNoe5VOPwE7K4NALys8mSlNNzj38H4UhtTsaBl0f/2H
         4u4oUyAnO7YZ1AIpNxwdmhwLYblmPJpP8DCnhGUQdXBIYxhrvw7qVX7RslKIIzW9c7hK
         eSoyrnoZFY1+5VDsNmMjTqK0O2zo7Dgn8Azl4kakEuTgvEytmD7GSKCmtSzH5J4CbcL4
         MwX6grHVRmuY++NQ8Qg2J53oJls5I/BkE3d4xxZrNHo6DvUjv9TW7JovCH1fbAVGoFwm
         ViJ+kTz3MPBoVFfPTpFlh2KvPrVOl4GwSF2e7z2ktiRKVYnkp13rBJOmhdgYaoU5vJqA
         beaA==
X-Received: by 10.68.164.35 with SMTP id yn3mr72338597pbb.104.1412100080773;
        Tue, 30 Sep 2014 11:01:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id z1sm15802127pdb.21.2014.09.30.11.01.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:20 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 05/16] arm64: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:45 -0700
Message-Id: <1412100056-15517-6-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42910
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 398ab05..cc0c63e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -157,6 +157,8 @@ void machine_power_off(void)
 	smp_send_stop();
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 }
 
 /*
-- 
1.9.1
