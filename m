Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:09:05 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:58672 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491806Ab0ENLJB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:01 +0200
Received: by pwi3 with SMTP id 3so114515pwi.36
        for <multiple recipients>; Fri, 14 May 2010 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XlUfRYf/UoP+Pe+jhTQpWdrYi3k8GPPW1W1GgwAqMR8=;
        b=QSLcCVKo5+xnZRDAdKcjLppqQyAOhjjiCH86rn6pb1IXzLhHRmUzPP3LfvTnUsEKhk
         LVaICn9csRvSuzGbb/UxOJ09ZX/lPNw7QrEaXOOyL4WfQg8ZOacU1H9p/N0KJXWqvCk/
         PR4r5yJ4NKA610IcDRYMrkQPgNVpsFbqRMC0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n2CwJyuMj+XjYKGgetZAK+4kIkl6j0Kq23G319RUOQkUz/XpA1no+YrbV6JidnNYBZ
         tSbosdXuS/rdVSUUVGhptfiLOBA8vXdjIqoZBFgRX2k6hAOjLMnDm6E/dLal1NCDTNCk
         2NeWzzUpUcB9qZ9dOxZTOrvf4a8QYxUpUTo0Y=
Received: by 10.115.117.40 with SMTP id u40mr989512wam.202.1273835333170;
        Fri, 14 May 2010 04:08:53 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.08.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:08:52 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v7 0/9] tracing: MIPS: add misc fixups and cleanups
Date:   Fri, 14 May 2010 19:08:25 +0800
Message-Id: <cover.1273834561.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds misc fixups and cleanups for Ftrace of MIPS:

  + Fix the support of 32bit support with -mmcount-ra-address of gcc 4.5
    o tracing: MIPS: mcount.S: Fix the argument passing of the 32bit support with
      gcc 4.5, The argument is passed by $12 in 32bit, not t0.
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
v6 -> v7:

  o Apply the feedback from David Daney:
  define a macro MCOUNT_RA_ADDRESS_REG instead of the magic number $12 for the patch
  "tracing: MIPS: mcount.S: Fix the argument passing of the 32bit
    support with gcc 4.5"

v5 -> v6:

  o splits up the old v5 revision into several patches to make the maintainer
  happier to review it.

Regards,
        Wu Zhangjin


Wu Zhangjin (9):
  tracing: MIPS: mcount.S: merge the same continuous #ifdefs
  tracing: MIPS: mcount.S: cleanup the arguments of
    prepare_ftrace_return
  tracing: MIPS: mcount.S: cleanup of the comments
  tracing: MIPS: mcount.S: Fix the argument passing of the 32bit
    support with gcc 4.5
  tracing: MIPS: Fixup of the 32bit support with -mmcount-ra-address
  tracing: MIPS: cleanup of the instructions
  tracing: MIPS: Reduce the overhead of dynamic Function Tracer
  tracing: MIPS: cleanup of function graph tracer
  tracing: MIPS: cleanup of the address space checking

 arch/mips/kernel/ftrace.c |  184 +++++++++++++++++++++++++++------------------
 arch/mips/kernel/mcount.S |   55 ++++++++-----
 2 files changed, 146 insertions(+), 93 deletions(-)
