Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 17:43:21 +0100 (CET)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38513 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012590AbbBEQnTpJGbQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 17:43:19 +0100
Received: by pdbft15 with SMTP id ft15so8748613pdb.5;
        Thu, 05 Feb 2015 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=bMg60+r7xYy0HgAioOLKbhSkeihNqeh2gqCNl3tdwR0=;
        b=h6djuFZNTJ5E3d3MqzdtXxk4e8F0F1W2IX06eAi0nykhFs1JBss41uOMOputK04wHP
         2LYAfNAegCd7n5bTOdaNwQx0OnfJ0DvB8lwc51JKxUXsE962uZoFkmluW75sUuoXrkPr
         7x9IL8FuXAgWji3ipQXHTzI01KZK/rXrNThcvDjAT/THrLXbMYUpIKRnHSNRwIIEt479
         efKHtTT2DltgpiaOcrrr++9UM1fEgimaqr/7LLzu8djtbEETGFs/EdWz3ro6ptCYHqT7
         /PpkAw4Jdll/dvT6CyOulKi+FiY9P5Iihc2ZBfj5c2w/N9iujulZeO5Uc19mvxKLxpva
         VsTg==
X-Received: by 10.66.65.195 with SMTP id z3mr6933963pas.104.1423154593996;
        Thu, 05 Feb 2015 08:43:13 -0800 (PST)
Received: from yggdrasil (111-243-150-103.dynamic.hinet.net. [111.243.150.103])
        by mx.google.com with ESMTPSA id rr9sm5552862pbc.39.2015.02.05.08.43.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2015 08:43:13 -0800 (PST)
Date:   Fri, 6 Feb 2015 00:43:08 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org
Cc:     Lars Persson <larper@axis.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Fix syscall_trace_enter compilation error
Message-ID: <20150206004026-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Commit cf6ce084 (MIPS: Fix syscall_get_nr for the syscall exit
tracing.) broke 3.13 and 3.14 stable tree due to the missing syscall
argument. So, get the syscall from regs[2] before it's trashed.

This patch should go to the 3.13 and 3.14 stable tree.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lars Persson <larper@axis.com>
Cc: linux-mips@linux-mips.org

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 64e18f9..01f1413 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -799,7 +799,7 @@ asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 	user_exit();
 
-	current_thread_info()->syscall = syscall;
+	current_thread_info()->syscall = regs->regs[2];
 
 	/* do the secure computing check first */
 	secure_computing_strict(regs->regs[2]);
