Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:23:48 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:56482 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491917Ab0ELNXo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:23:44 +0200
Received: by pwj6 with SMTP id 6so511839pwj.36
        for <multiple recipients>; Wed, 12 May 2010 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3TDN87lHPm1AlPhk7XbnOWgVybOvcKtcZe0swu3crnk=;
        b=Q5LGvZf8/AOeSJrmFZxw5QlozluVammd7ZRdondm0D5n2J9IqPcbrmnBtMB5LjRV0t
         4EIe7xRrRUKkm6wWeuQgp6H9U6kO9ZikAf6dBG7v4CtRQNNjBmEq6oilzEGLM3yufRt9
         G++zVIN+7CGvft/iKtk208oryQ4du4PMS+pOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SLXlosydJoyG1gTHP2vhxh71YacSE1qt5AfyxcJra79b5a6O4ai5w2wzk1CqkEf2m4
         wISYxsJc0+wN8OBbrnfljn0bgyaCvkK4JZrxLJYRx+jjNbeBNhonzx4x8NuGBQuJGVTR
         bAohVAiM90+UkgGcgznDcQGFd1zHXYeJBpHFY=
Received: by 10.115.84.6 with SMTP id m6mr5841189wal.59.1273670616783;
        Wed, 12 May 2010 06:23:36 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.23.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:23:36 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 0/9] tracing: MIPS: add misc fixups and cleanups
Date:   Wed, 12 May 2010 21:23:08 +0800
Message-Id: <cover.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds misc fixups and cleanups for Ftrace of MIPS:

  + Fix the support of 32bit support with -mmcount-ra-address of gcc 4.5
    o tracing: MIPS: mcount.S: Fixup of the 32bit support with gcc 4.5
      The argument is passed by $12 in 32bit, not t0.
    o tracing: MIPS: Fixup of the 32bit support with -mmcount-ra-address
      For 32bit kernel, the offset of "b 1f" should be 5 instructions, not only 4.
 
  + Speedup the dynamic function tracer
    o tracing: MIPS: Reduce the overhead of dynamic Function Tracer
      In the old implementation, we have encode the 'nop' instruction and the
      instruction of calling to mcount at run-time, which may add some
      overhead.  We reduce this overhead via encoding them when initializing
      the dynamic function tracer.

  + Lots of cleanups
    o The other patches.

----------------

Changes from v5:

  o splits up the old v5 revision into several patches to make the maintainer
  happier to review it.

Regards,
	Wu Zhangjin

Wu Zhangjin (9):
  tracing: MIPS: mcount.S: merge the same continuous #ifdefs
  tracing: MIPS: mcount.S: Fixup of the 32bit support with gcc 4.5
  tracing: MIPS: mcount.S: cleanup the arguments of
    prepare_ftrace_return
  tracing: MIPS: mcount.S: cleanup of the comments
  tracing: MIPS: Fixup of the 32bit support with -mmcount-ra-address
  tracing: MIPS: cleanup of the instructions
  tracing: MIPS: Reduce the overhead of dynamic Function Tracer
  tracing: MIPS: cleanup of function graph tracer
  tracing: MIPS: cleanup of the address space checking

 arch/mips/kernel/ftrace.c |  179 +++++++++++++++++++++++++++------------------
 arch/mips/kernel/mcount.S |   49 +++++++-----
 2 files changed, 135 insertions(+), 93 deletions(-)
