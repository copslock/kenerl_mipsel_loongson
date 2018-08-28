Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 22:13:52 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:34012
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeH1UNq6vQ0R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2018 22:13:46 +0200
Received: by mail-pf1-x444.google.com with SMTP id k19-v6so1209066pfi.1
        for <linux-mips@linux-mips.org>; Tue, 28 Aug 2018 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nrx5BjLid6WRT0H+QOg8OOAOoYWBRl3aOyPeYKp49o8=;
        b=ORg3rM9pJcwi49nThhGQpNPutYZBoA/O1ef4eqv121X6OBjeGxolkgnBpuB0eoWRiz
         1LngNeT655sV1/LHNHc+GZuS31pBFBtZKb7CMgZ6zgiuuHWg3hWeGv9PJq3rp0a1jAwz
         4adSGw6C3lFKRLwSKyWlcTIdLcMdM8gaZIRi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nrx5BjLid6WRT0H+QOg8OOAOoYWBRl3aOyPeYKp49o8=;
        b=FVnsU8bSMe0pMzg8q2ED9h9aBW0qeS5mDBRg8QX4GV4QIP15Enu/qZt5beZo4VK7HJ
         50tSYGAHs+VMmze+BV7IVEKZm/qUopCcHW1fGk3/FhiPkzUR9PMrDIEnWSbOyLaNOLR2
         Ya1atr9f+NOQ8nyS3Vx9CZ05LYeYstydWHHhvUlV4C3vIe+T0GQOIMW7albIkIGWd4lE
         cCBkAO/4ptl6tBjgXmeJ3yMhv6Krx8HkkVgbt2wmMM9roxuBcsx+jWjuxfRV4+m1+Wk7
         Nc4SoK/vpMm2HsI75wUQ3Nawoksduu7eJfkGVj2ZEZNZGYwqUXxEJ1RUUtpV1yDB1lGx
         Goxw==
X-Gm-Message-State: APzg51DDEr4ndp5yVkqmTaCrtLiJNuk4PYJAf9EiCJD4MEABEV1u/+PA
        lsbALBHZzDMO0nfQD2R67xVD8g==
X-Google-Smtp-Source: ANB0VdYnLkGyIBEfvQozaS1KFD8EqKhmXlAZbz8e/TpB8TwCSHR5OufdUIzOmCaUofKA6WjIhvbZPQ==
X-Received: by 2002:a62:808c:: with SMTP id j134-v6mr2969815pfd.120.1535487220306;
        Tue, 28 Aug 2018 13:13:40 -0700 (PDT)
Received: from localhost.localdomain ([49.207.48.21])
        by smtp.gmail.com with ESMTPSA id t86-v6sm3098181pfe.109.2018.08.28.13.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 13:13:38 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Jamie Iles <jamie.iles@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH for-4.9.y 03/14] kthread: fix boot hang (regression) on MIPS/OpenRISC
Date:   Wed, 29 Aug 2018 01:43:14 +0530
Message-Id: <1535487205-26280-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535487205-26280-1-git-send-email-amit.pundir@linaro.org>
References: <1535487205-26280-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Vegard Nossum <vegard.nossum@oracle.com>

commit b0f5a8f32e8bbdaae1abb8abe2d3cbafaba57e08 upstream.

This fixes a regression in commit 4d6501dce079 where I didn't notice
that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
NULL after our initialisation in copy_process().

We can simply get rid of the arch-specific initialisation here since it
is now always done in copy_process() before hitting copy_thread{,_tls}().

Review notes:

 - As far as I can tell, copy_process() is the only user of
   copy_thread_tls(), which is the only caller of copy_thread() for
   architectures that don't implement copy_thread_tls().

 - After this patch, there is no arch-specific code touching
   p->set_child_tid or p->clear_child_tid whatsoever.

 - It may look like MIPS/OpenRISC wanted to always have these fields be
   NULL, but that's not true, as copy_process() would unconditionally
   set them again _after_ calling copy_thread_tls() before commit
   4d6501dce079.

Fixes: 4d6501dce079c1eb6bf0b1d8f528a5e81770109e ("kthread: Fix use-after-free if kthread fork fails")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net> # MIPS only
Acked-by: Stafford Horne <shorne@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
Cc: Jamie Iles <jamie.iles@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
To be applied on 4.4.y and 3.18.y as well.
Build tested on v4.4.153 and v3.18.120.

 arch/mips/kernel/process.c     | 1 -
 arch/openrisc/kernel/process.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 513a63b9b991..ba315e523b33 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -118,7 +118,6 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	unsigned long childksp;
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 7095dfe7666b..962372143fda 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -152,8 +152,6 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	top_of_kernel_stack = sp;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Locate userspace context on stack... */
 	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
 	sp -= sizeof(struct pt_regs);
-- 
2.7.4
