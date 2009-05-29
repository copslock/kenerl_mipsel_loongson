Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 15:58:59 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:42734 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024472AbZE2O6x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 15:58:53 +0100
Received: by pzk40 with SMTP id 40so5435643pzk.22
        for <multiple recipients>; Fri, 29 May 2009 07:58:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=A2AlSCX9uV1ebpxCkFoXzMPGWgz2pDvwmMqgn/Z48HI=;
        b=OVlGAV3JGJD0jT+++jQ7Gs+kN81Z7cSP0OADkgNtz2WQFUnrZ8LXQ6WFotYM56Qdtz
         pg05ngC+sSD62Ngzu0ATZ6mTHg6wRc9r6L1E1/aqIZKRBZc4kUJNi718ASPpUtjnm5o7
         XRMUWlCruA5fU5W2w81SoK7Noq/vJBbTcgONo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PTaSt5FpqGy0PdpyK4kBfmMxV0ps2LGj+xrkx90wD4rmKD7z7VOUuLlNSWgdt3Xa6t
         CdPf2iPVwA5MDbN2sV/r83WCUlLexDGCh7bb4ppTlBzjKaJ6qOg/ckphB/fDNk8BBCo0
         7oniY/mq36VptrG62Z6F6EiAKoyXoJnSZ1USo=
Received: by 10.115.95.20 with SMTP id x20mr2581860wal.40.1243609122333;
        Fri, 29 May 2009 07:58:42 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id l38sm2201787waf.38.2009.05.29.07.58.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 07:58:40 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH v2 0/6] mips-specific ftrace support
Date:	Fri, 29 May 2009 22:58:08 +0800
Message-Id: <cover.1243604390.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

ftrace is a mcount based kernel tracing tool/framework, which is originally
from RT_PREEMPT(http://rt.wiki.kernel.org).

ftrace is short for function tracer, this is its original name, but now, it
becomes a kernel tracing framework, lots of kernel tracers are built on it,
such as irqoff tracer, wakeup tracer and so forth.  these tracers are
arch-independent(?), but some of them are arch-dependent, such as the original
ftrace: function tracer, and dynamic function tracer, function graph tracer,
and also, system call tracer.

here is the mips porting of these four arch-dependent tracers, it will enable
the following new kernel config options in linux-mips system.

kernel hacking --->
           Tracers -->
                [*] Kernel Function Tracer
                [*]   Kernel Function Graph Tracer
                ...
                [*] Trace syscalls
                                ...
                [*] enable/disable ftrace tracepoints dynamically

in reality, because the timestamp getting function are arch-dependent, lots of
the tracers are arch-dependent. the arch-dependent part is that: sched_clock.
the original sched_clock in mips is jiffes based, only give 10ms precision in
1000HZ, which is not enough for ftrace. to get high-precise timestamp, we must
implement a new native_sched_clock via reading the MIPS clock counter, but
since it is only 32bit long, so, overflow should be handled carefully.

this -v2 patch series is based on the -v1 patch series and incorporates the
feedback from Steven Rostedt and Thomas Gleixner.

read the following document, and play with it:
        Documentation/trace/ftrace.txt

Wu Zhangjin (6):
  mips static function tracer support
  mips dynamic function tracer support
  add an endian argument to scripts/recordmcount.pl
  mips function graph tracer support
  mips specific clock function to get precise timestamp
  mips specific system call tracer

 arch/mips/Kconfig                   |    7 +
 arch/mips/Makefile                  |    2 +
 arch/mips/include/asm/ftrace.h      |   35 ++++-
 arch/mips/include/asm/ptrace.h      |    2 +
 arch/mips/include/asm/reg.h         |    5 +
 arch/mips/include/asm/syscall.h     |   84 +++++++++
 arch/mips/include/asm/thread_info.h |    5 +-
 arch/mips/kernel/Makefile           |   12 ++
 arch/mips/kernel/csrc-r4k.c         |    2 +-
 arch/mips/kernel/entry.S            |    2 +-
 arch/mips/kernel/ftrace.c           |  350 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/ftrace_clock.c     |   71 +++++++
 arch/mips/kernel/mcount.S           |  185 ++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c       |    5 +
 arch/mips/kernel/ptrace.c           |   14 ++-
 arch/mips/kernel/scall64-o32.S      |    2 +-
 arch/mips/kernel/vmlinux.lds.S      |    1 +
 kernel/trace/trace_clock.c          |    2 +-
 scripts/Makefile.build              |    1 +
 scripts/recordmcount.pl             |   32 +++-
 20 files changed, 805 insertions(+), 14 deletions(-)
 create mode 100644 arch/mips/include/asm/syscall.h
 create mode 100644 arch/mips/kernel/ftrace.c
 create mode 100644 arch/mips/kernel/ftrace_clock.c
 create mode 100644 arch/mips/kernel/mcount.S
