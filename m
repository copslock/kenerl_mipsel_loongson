Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 03:07:19 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36738 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835278Ab3FNBHPnofS4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 03:07:15 +0200
Received: by mail-pd0-f177.google.com with SMTP id p10so16102pdj.22
        for <multiple recipients>; Thu, 13 Jun 2013 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lCvWIyPmiZwhIFJP7hdcdwPDybLnJuzP2n1Y0v/1os0=;
        b=ktZiPsqY2tfuj2iyWapB929I0LHrcX7zNlbFCWHHQ134w5u278FwYfsSPY5AV00OQy
         YDxmGa6HGlFQmbUaLiUI6BJUBKt9fScC7xsK9NYREo7x7bTgbxgAPIInE+gSd4kjVA8B
         v7SHafACNLddBNqdK2ndMY+a1UkWMIJZqtCUjqcqleWAiittt0JXqdYh/Fq4Hahyi9Zq
         532OU5tVVl12Bm/wNQzA+4nCVdp1UFqoHyKzR+DNmegxBGnxRn5qIadwrh+aOx5xe06o
         9mSBkauX/TImcOWE2QAkMS7kJyxloZM/Zc5X6GOA9QpvNUsPdCpUv6slPX7Qpn7+tIWM
         V9dg==
X-Received: by 10.66.145.201 with SMTP id sw9mr72249pab.63.1371172029224;
        Thu, 13 Jun 2013 18:07:09 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id al2sm34745pbc.25.2013.06.13.18.07.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 18:07:08 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5E175li016037;
        Thu, 13 Jun 2013 18:07:06 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5E1741E016036;
        Thu, 13 Jun 2013 18:07:04 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] smp.h: Use local_irq_{save,restore}() in !SMP version of on_each_cpu().
Date:   Thu, 13 Jun 2013 18:07:03 -0700
Message-Id: <1371172023-16004-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Thanks to commit f91eb62f71b (init: scream bloody murder if interrupts
are enabled too early), "bloody murder" is now being screamed.

With a MIPS OCTEON config, we use on_each_cpu() in our
irq_chip.irq_bus_sync_unlock() function.  This gets called in early as
a result of the time_init() call.  Because the !SMP version of
on_each_cpu() unconditionally enables irqs, we get:

------------[ cut here ]------------
WARNING: at init/main.c:560 start_kernel+0x250/0x410()
Interrupts were enabled early
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.0-rc5-Cavium-Octeon+ #801
Stack : 0000000000000046 ffffffff808e0000 0000000000000006 0000000000000004
	  0000000000000001 0000000000000000 0000000000000046 0000000000000000
	  ffffffff80a90000 ffffffff8015c020 0000000000000000 ffffffff8015c020
	  ffffffff80a79f70 ffffffff80a80000 ffffffff8072b9c0 ffffffff808a7d77
	  ffffffff80a79f70 ffffffff808a8168 0000000000000000 00000004178a9948
	  0000000417801230 ffffffff805f7610 0000000010000078 ffffffff805fa01c
	  ffffffff8089bd18 ffffffff801595fc ffffffff8089bd28 ffffffff8015d384
	  ffffffff808a7e80 ffffffff8089bc30 0000000000000000 ffffffff80159710
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 ffffffff80139520 0000000000000000 0000000000000009
	  ...
Call Trace:
[<ffffffff80139520>] show_stack+0x68/0x80
[<ffffffff80159710>] warn_slowpath_common+0x78/0xb0
[<ffffffff801597e8>] warn_slowpath_fmt+0x38/0x48
[<ffffffff8092b768>] start_kernel+0x250/0x410

---[ end trace 139ce121c98e96c9 ]---

Suggested fix: Do what we already do in the SMP version of
on_each_cpu(), and use local_irq_save/local_irq_restore.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/linux/smp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index e6564c1..d8fb04b 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -141,9 +141,10 @@ static inline int up_smp_call_function(smp_call_func_t func, void *info)
 			(up_smp_call_function(func, info))
 #define on_each_cpu(func,info,wait)		\
 	({					\
-		local_irq_disable();		\
+		unsigned long flags;		\
+		local_irq_save(flags);		\
 		func(info);			\
-		local_irq_enable();		\
+		local_irq_restore(flags);	\
 		0;				\
 	})
 /*
-- 
1.7.11.7
