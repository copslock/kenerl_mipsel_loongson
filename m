Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 May 2015 00:10:07 +0200 (CEST)
Received: from mail-yh0-f73.google.com ([209.85.213.73]:33794 "EHLO
        mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012800AbbEHWKFyVHv0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 May 2015 00:10:05 +0200
Received: by yhl29 with SMTP id 29so2671951yhl.1
        for <linux-mips@linux-mips.org>; Fri, 08 May 2015 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:message-id:date;
        bh=0r/eu+D+sf++zLyxmNO0uHeiq1z4Qo4pC/nrTCyH4hw=;
        b=Dt/Eo7+s8KT+axkhCjp4Hvs9Oe8Sn7trUH9Q+ro5abcAIXXjC+7TjQ3t9d98LxX4ah
         ou+TiiTTi/9rCVyIinUDMC9PYLPY3qbEvgQnCuUXVgFedYrC0wbcVbcoHwir3uJVWwTW
         npMurU7R/Jyq/Fltl2ufMkEWI9NSFp/ajZkQZcnt6AW7rgV/VYPIsJ9AVOVtBRPD1VUF
         ExRwSZolbvYP3Xo08jswgw+bY3b163+nv6nY6lyTxw0Y790NP/TIULWHddGCuVkFaHtq
         lBlh/2WNJHCwveTaKOZk6Y5Jam5JSXejdZgUZYWsGbLNufmNXVvmwrMc9Gm02qf1JiCy
         2EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:message-id:date;
        bh=0r/eu+D+sf++zLyxmNO0uHeiq1z4Qo4pC/nrTCyH4hw=;
        b=aiKYaILK/xmBMJKLKb5Lsgm0xLKZP42gEGYw4q9f9t1zXpdDFJ47q0eM6/RQHU/t6/
         PtOArRG5jELXrhgWJlflG0Ki2/e/f7gHdp1cK/M0Neea3PERMNw1bG6QX1orKFEKYmdX
         /AJIyassmxSHBCw4csYRvgTjBE60iv0T6Ku10UxNwSYuuME7P3m2f8g0ImPQN48lF8vm
         TKUcm3LlGmIu/pXEx7qTaHRXuI6K71UebAIS1SwKH1uTWBXDYYIxpRHY7aEoLUtIUI0z
         Ry24jcVPs6p/kmoRp14/Olg3vcNMV4Y1yu9lKpxZk9W1sMvyK7c2jgrZLlUCCENZVIDs
         vsVg==
X-Gm-Message-State: ALoCoQmYeoEM7y/Z0XqY8Hyq+zmOb0xMt+QALP0oWgZasc159Q14S9xd7x8uuu4Kwls07uazNXKP
X-Received: by 10.140.238.201 with SMTP id j192mr288891qhc.14.1431123002098;
        Fri, 08 May 2015 15:10:02 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id x25si340522yha.2.2015.05.08.15.10.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 15:10:02 -0700 (PDT)
Received: from puck.mtv.corp.google.com ([172.27.88.166])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 6q1LSrb9.1; Fri, 08 May 2015 15:10:02 -0700
Received: by puck.mtv.corp.google.com (Postfix, from userid 68020)
        id 14218220495; Fri,  8 May 2015 15:10:00 -0700 (PDT)
From:   Petri Gynther <pgynther@google.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 1/2] MIPS: traps: remove extra Tainted: line from __show_regs() output
Message-Id: <20150508221001.14218220495@puck.mtv.corp.google.com>
Date:   Fri,  8 May 2015 15:10:00 -0700 (PDT)
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

__show_regs() calls show_regs_print_info(), which already outputs
the Tainted: information. So, no need to output it twice.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 arch/mips/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index ba32e48..d2d1c19 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -269,7 +269,6 @@ static void __show_regs(const struct pt_regs *regs)
 	 */
 	printk("epc   : %0*lx %pS\n", field, regs->cp0_epc,
 	       (void *) regs->cp0_epc);
-	printk("    %s\n", print_tainted());
 	printk("ra    : %0*lx %pS\n", field, regs->regs[31],
 	       (void *) regs->regs[31]);
 
-- 
2.2.0.rc0.207.ga3a616c
