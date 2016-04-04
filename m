Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 13:42:35 +0200 (CEST)
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36400 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026028AbcDDLmdXuSei (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 13:42:33 +0200
Received: by mail-pf0-f174.google.com with SMTP id e128so121413098pfe.3;
        Mon, 04 Apr 2016 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kFIk8pw6DIdu4XMuoj4znc1+kUrMpGyD1ckMarOvwqQ=;
        b=lNwJqEoCXUDvFSURxjnDIBI8ygvmaAqHkyHbyk6A7uiPJxwvBSWdTEWa0rzrshAu9a
         D+wvdF3KxV7+nV4Ndu3y21ZK4W5HTwkLPng91u5tispXDctSC/QD+vAEdke7cJm3oOzX
         S9PFTetTiwP7is3dYv4VR/2JeHdAku4dqqclrbgJ9EC3OlJgYA2uhvpWV3ufzs9mnb5Q
         huHZTLDbeN7BKfzEGbc92HDkCcm5ZefXzR8NGY1nidbc8c4Rd+RW6RJLxGJIgU2fR7HW
         AjrR1cvSsk6/84KuIko9Ed87figLzCoP8WkYLzXM5Yok9hj/mWeKNQwX5shcxWo4r8eb
         MCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kFIk8pw6DIdu4XMuoj4znc1+kUrMpGyD1ckMarOvwqQ=;
        b=LVeCXgHB4ZiXkj89IF8SwYokuPxupnY2KQQM6F1bj82DRm0TRoWvUpWkYhD0j58hbS
         CsRbeBp1tOnI7gRo3XMIVgTPBq14FqNjAy6GevwFySAPcVzuhqN7Ywmp7B6vVaLF8Cwv
         EYrML0Z2icdPlmvaYLyfQXC6IWXYcjXPfA2UVEfX15orm9QCU6TNnGMjfJifSlsYTJuD
         0qz2iAU82iK0Pb7B8Qcpji8TPcqc6gd9YGCgeG+a1HeNTk5yQq/ib9MOqClmuNZmlgxt
         /2crFj8fM4ruDdCe9+vDe+e66j+SQjNDOObwvTE4+mh8TfkKkVzZA8mf1L6tCWfMO/jt
         m45w==
X-Gm-Message-State: AD7BkJLNi3vd8lB3XIN5JofVeGMwG4SpYILqyRYwVIGMBle8Dnj/QhppZYXRJZMwnWnStQ==
X-Received: by 10.98.73.132 with SMTP id r4mr20102831pfi.118.1459770147272;
        Mon, 04 Apr 2016 04:42:27 -0700 (PDT)
Received: from localhost.localdomain ([103.24.124.194])
        by smtp.gmail.com with ESMTPSA id fk10sm41161887pab.33.2016.04.04.04.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 04:42:25 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
        linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] MIPS: remove duplicate definition
Date:   Mon,  4 Apr 2016 17:12:15 +0530
Message-Id: <1459770135-6228-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

mips defconfig and allmodconfig are failing with the error:

In file included from ../arch/mips/kernel/asm-offsets.c:13:0:
include/linux/sched.h:2656:20: error: conflicting types for 'exit_thread'

exit_thread() was already defined in include/linux/sched.h.

Fixes: 8664c52c094e ("MIPS: Make flush_thread and exit_thread inline.")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log of next-20160404 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/120536697 (defconfig)
https://travis-ci.org/sudipm-mukherjee/parport/jobs/120536714 (allmodconfig)

patch has been build tested with defconfig and allmodconfig.

 arch/mips/include/asm/processor.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 06469df..cfa15ba 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -359,10 +359,6 @@ static inline void flush_thread(void)
 {
 }
 
-static inline void exit_thread(void)
-{
-}
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
-- 
1.9.1
