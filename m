Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2010 23:52:48 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15340 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492013Ab0GIVwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jul 2010 23:52:42 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c379a410000>; Fri, 09 Jul 2010 14:53:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Jul 2010 14:52:39 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Jul 2010 14:52:39 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o69LqU0o012087;
        Fri, 9 Jul 2010 14:52:33 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o69LqPhA012085;
        Fri, 9 Jul 2010 14:52:25 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        Li Hong <lihong.hi@gmail.com>, Ingo Molnar <mingo@elte.hu>,
        Matt Fleming <matt@console-pimps.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] tracing: recordmcount.pl: Fix $mcount_regex for MIPS.
Date:   Fri,  9 Jul 2010 14:52:05 -0700
Message-Id: <1278712325-12050-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 09 Jul 2010 21:52:39.0815 (UTC) FILETIME=[0D02C970:01CB1FB1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

I found this issue in a locally patched 2.6.32.x, current kernels have
moved the offending code to an __init function which is skipped by
recordmcount.pl, so the bug is not currently being exercised.
However, I think the patch is still a good idea, to avoid future
problems if _mcount were to ever have its address taken in normal
code.

This is what I originally saw:

    Although arch/mips/kernel/ftrace.c is built without -pg, and thus
    contains no calls to _mcount, it does use the address of _mcount
    in ftrace_make_nop().  This was causing relocations to be emitted
    for _mcount which recordmcount.pl erronously took to be _mcount
    call sites.  The result was that the text of ftrace_make_nop()
    would be patched with garbage leading to a system crash.

In non-module code, all _mcount call sites will have R_MIPS_26
relocations, so we restrict $mcount_regex to only match on these.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Li Hong <lihong.hi@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 scripts/recordmcount.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index f3c9c0a..0171060 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -326,7 +326,7 @@ if ($arch eq "x86_64") {
     #                    14: R_MIPS_NONE *ABS*
     #	 18:   00020021        nop
     if ($is_module eq "0") {
-	    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
+	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_26\\s+_mcount\$";
     } else {
 	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
     }
-- 
1.6.6.1
