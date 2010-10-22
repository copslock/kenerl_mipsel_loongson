Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 22:58:30 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50267 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491193Ab0JVU6X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 22:58:23 +0200
Received: by pwj6 with SMTP id 6so177731pwj.36
        for <multiple recipients>; Fri, 22 Oct 2010 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=77qy4QhYDMfVfPtNWY9GNkHmW+WmzJ7Rrfo8GZEu41k=;
        b=VuJlHq8kyVMc9LabnPZoTP3y8tFbtu9r0pPkto/xoqkai+WdrPw8Unj7fF6CTqdzUd
         5lrVaRcNPxIhQXeqQMsEkFY5d0MbfhtyQ9HWDyIxOL0ZRioyK66QaMRDQAvYjGnpQXop
         O46pfy6ffk+VImKsgLmXrAs403VlwtqJ6CUbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NhVo/Tf61c7UCiMrNYzHS7gi7Xo5NjMPRbiPlaGFpLodCwVVMz1GShWKpg8mMkaQaL
         fTUliiCx0xlOrkll/m8n+hBJzhG8rEiKZ7+cARC19FyTJnYuFmpVzJ4RMHb5S83P2rFF
         n8MZ5UOROu6nsk4u1F4fR9GYjfqmI+bfzB1n4=
Received: by 10.142.216.11 with SMTP id o11mr2770270wfg.238.1287781096322;
        Fri, 22 Oct 2010 13:58:16 -0700 (PDT)
Received: from localhost.localdomain ([61.48.68.246])
        by mx.google.com with ESMTPS id v19sm5109741wfh.12.2010.10.22.13.58.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 13:58:14 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>, rostedt@goodmis.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [RFC 0/2] Fixes the modules support of dynamic function tracer for MIPS
Date:   Sat, 23 Oct 2010 04:58:01 +0800
Message-Id: <cover.1287779153.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Hi, all

Currently, our in_module() defined in arch/mips/kernel/ftrace.c and
scripts/recordmcount.pl for MIPS only considers the module and the core kernel
have different address space and long call is assumed to be used.

But as David pointed before, the module may be in the same space as the core
kernel, therefore, with the current implementation, dynamic function tracer for
MIPS will not work for that situation.

This patchset is created to fix it.

As we know, to jump from an address to _mcount, for _mcount is in kernel space,
if the address is also in kernel space, then, no long call is needed(for the
"jal" can jump to a place whose offset is smaller than 2^28=256MB and
no kernel image is possible to be bigger than 256MB), otherwise, (only
consider the address passed by ftrace_make_{nop,call}), to jump from
the address to _mcount, long call via "jalr" is needed:

if (in_kernel_space(addr)) {
	jal _mcount;
} else {
	load the address of _mcount to a register
	jalr <register>
}

Now, after implementing in_kernel_space() in the 1st patch, that
situation(module and core kernel are in the same address space) is also covered.

But the 1st patch is not enough to fix the whole problem, we also need to
record the right calling site(for long call, not really the calling site, but
the position for loading the address to the register) for the module in that
situation. Because no long call is needed for that situation, to get the
calling site to _mcount, we need to search the R_MIPS_26 like the kernel, the
2nd patch does it.

Regards,
	Wu Zhangjin

Wu Zhangjin (2):
  MIPS: tracing/ftrace: Replace in_module() with a generic
    in_kernel_space()
  MIPS: tracing/ftrace: Fixes mcount_regex for modules

 arch/mips/kernel/ftrace.c |   66 ++++++++++++++++++++++++--------------------
 scripts/recordmcount.pl   |   46 +++++++++++++++++++-----------
 2 files changed, 65 insertions(+), 47 deletions(-)
