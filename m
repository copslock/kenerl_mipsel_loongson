Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39DiZP06265
	for linux-mips-outgoing; Mon, 9 Apr 2001 06:44:35 -0700
Received: from bvdexchange.eicon.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39DiYM06262
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 06:44:34 -0700
Received: by BVDEXCHANGE with Internet Mail Service (5.5.1960.3)
	id <H7Q47FJX>; Mon, 9 Apr 2001 15:45:02 +0200
Message-ID: <7B3DBD648709D5119E870002A528BE6C12D7BD@BVDEXCHANGE>
From: Tommy Christensen <tommy.christensen@eicon.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: _save_fp_context corrupts kernel sp
Date: Mon, 9 Apr 2001 15:44:58 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.1960.3)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,
this bug was triggered by the 'crashme' program, which deliberately does
various bad things.

The problem occurs when _save_fp_context cannot write to the user stack.
Since the fixup
routine for this lacks a nop at the end, the following "random"
instruction is executed (in
my case it adjusted the stack pointer, which is pretty lethal).

The patch below corrects this.

Regards,
Tommy S. Christensen, Eicon Networks


--- r4k_fpu.S.orig      Sun Dec 10 08:56:02 2000
+++ r4k_fpu.S   Mon Apr  9 10:55:27 2001
@@ -94,6 +94,7 @@
         ctc1   t0,fcr31
        END(_restore_fp_context)
 
+       .set    reorder
        .type   fault@function
        .ent    fault
 fault: li      v0, -EFAULT
