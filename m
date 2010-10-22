Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 22:58:54 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50267 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491200Ab0JVU6Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 22:58:24 +0200
Received: by mail-pw0-f49.google.com with SMTP id 6so177731pwj.36
        for <multiple recipients>; Fri, 22 Oct 2010 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=AFEUuMjMgobjDHrOpAy6j7wHdN/eMxBsyoaDuCHeavM=;
        b=Qhd2Fd7lFw6ZgFgz0Ixg/ixQUsRzZfYWPNlObRMlBcg52igl8ri7L26O9LQSivGBFD
         nSFb430xbwIPJJXSz73k6mMtLdxR4wzBaMkgQUvGrorUt3bbwC6nW7lSEjI5/eE0joKP
         01kdqLk9rUAQ5e6jEl9r9l0DoT/sUKmWxEr1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Padju+AVXetMIxkKMEgkFXklKs2vLJAd2umaWuR4fl5ujukrbLPh63od42HJiNrgRN
         OHK/paGT1G+wBk11ltAatrJoLxTjnS0K7wBJi90opcF9Be7aRrfUFxvNeO9818bY0AfJ
         8OOBezliBq4ssBDglvr0F/ClK1fb9hkQ5gLQM=
Received: by 10.143.33.1 with SMTP id l1mr2693036wfj.249.1287781103745;
        Fri, 22 Oct 2010 13:58:23 -0700 (PDT)
Received: from localhost.localdomain ([61.48.68.246])
        by mx.google.com with ESMTPS id v19sm5109741wfh.12.2010.10.22.13.58.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 13:58:22 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>, rostedt@goodmis.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [RFC 2/2] MIPS: tracing/ftrace: Fixes mcount_regex for modules
Date:   Sat, 23 Oct 2010 04:58:03 +0800
Message-Id: <485f5af61fae72dc9c1f0e31b1b5f1f57a5e7ed8.1287779153.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1287779153.git.wuzhangjin@gmail.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1287779153.git.wuzhangjin@gmail.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

In some situations(with related kernel config and gcc options), the
modules may have the same address space as the core kernel space, so
mcount_regex for modules should also match R_MIPS_26.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 scripts/recordmcount.pl |   46 +++++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index e67f054..e9c1a0f 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -299,14 +299,33 @@ if ($arch eq "x86_64") {
     $cc .= " -m64";
     $objcopy .= " -O elf64-sparc";
 } elsif ($arch eq "mips") {
-    # To enable module support, we need to enable the -mlong-calls option
-    # of gcc for module, after using this option, we can not get the real
-    # offset of the calling to _mcount, but the offset of the lui
-    # instruction or the addiu one. herein, we record the address of the
-    # first one, and then we can replace this instruction by a branch
-    # instruction to jump over the profiling function to filter the
-    # indicated functions, or swith back to the lui instruction to trace
-    # them, which means dynamic tracing.
+    # <For kernel>
+    # To disable tracing, just replace "jal _mcount" with nop;
+    # to enable tracing, replace back. so, the offset 14 is
+    # needed to be recorded.
+    #
+    #     10:   03e0082d        move    at,ra
+    #     14:   0c000000        jal     0
+    #                    14: R_MIPS_26   _mcount
+    #                    14: R_MIPS_NONE *ABS*
+    #                    14: R_MIPS_NONE *ABS*
+    #     18:   00020021        nop
+    #
+    # <For module>
+    #
+    # If no long call(-mlong-calls), the same to kernel.
+    #
+    # If the module space differs from the kernel space, long
+    # call is needed, as a result, the address of _mcount is
+    # needed to be recorded in a register and then jump from
+    # module space to kernel space via "jalr <register>". To
+    # disable tracing, "jalr <register>" can be replaced by
+    # nop; to enable tracing, replace it back. Since the
+    # offset of "jalr <register>" is not easy to be matched,
+    # the offset of the 1st _mcount below is recorded and to
+    # disable tracing, "lui v1, 0x0" is substituted with "b
+    # label", which jumps over "jalr <register>"; to enable
+    # tracing, replace it back.
     #
     #       c:	3c030000 	lui	v1,0x0
     #			c: R_MIPS_HI16	_mcount
@@ -318,19 +337,12 @@ if ($arch eq "x86_64") {
     #			10: R_MIPS_NONE	*ABS*
     #      14:	03e0082d 	move	at,ra
     #      18:	0060f809 	jalr	v1
+    #   label:
     #
-    # for the kernel:
-    #
-    #     10:   03e0082d        move    at,ra
-    #	  14:   0c000000        jal     0 <loongson_halt>
-    #                    14: R_MIPS_26   _mcount
-    #                    14: R_MIPS_NONE *ABS*
-    #                    14: R_MIPS_NONE *ABS*
-    #	 18:   00020021        nop
     if ($is_module eq "0") {
 	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_26\\s+_mcount\$";
     } else {
-	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
+	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_(HI16|26)\\s+_mcount\$";
     }
     $objdump .= " -Melf-trad".$endian."mips ";
 
-- 
1.7.1
