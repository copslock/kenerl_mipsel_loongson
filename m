Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 17:51:16 +0200 (CEST)
Received: from mail-pz0-f179.google.com ([209.85.222.179]:59625 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492168AbZFNPvK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 17:51:10 +0200
Received: by pzk9 with SMTP id 9so1379742pzk.22
        for <multiple recipients>; Sun, 14 Jun 2009 08:50:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gohRbRtnSeJ1oCEj12wMFALe8dFvklpjsnGUI60n9c4=;
        b=BTi+Auokq/s3SRRZ/xwbAMffwQn1zoBN3wsupsStFfKm6oOcl7bSLC5547qj4YtHZb
         OpM9HKEFZdFXWzMxcLQ3w2JYNR3z32/sIyDdqa2zyu0NG45ADzZNKGrqVSDyheJJaT4l
         Y/9Ep0mGb4DfHUYDAdZunB793NgDGcn8+ueQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=og6G/jfcUFg+DLjeRe1vKZceAeH4saKElHzy4iZgwr4zHgGGX3xcZgCs6NMNDEcj7S
         zkQBcQA1zUZI+RAXESrhmDn2YFCtdX/NhKwkKhYp9Kjih0OHuzp25WH4xAEg0wZGaHiy
         6Sz6N4usEbL4PIBgwYlnIoU9p1wzRRlHx2uWA=
Received: by 10.114.208.12 with SMTP id f12mr9379284wag.226.1244994627145;
        Sun, 14 Jun 2009 08:50:27 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id n40sm4674652wag.65.2009.06.14.08.50.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 08:50:25 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: [PATCH v3] mips-specific ftrace support 
Date:	Sun, 14 Jun 2009 23:50:16 +0800
Message-Id: <cover.1244994151.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23406
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
the tracers are arch-dependent. the arch-dependent part is that: sched_clock().
the original sched_clock() in mips is jiffes based, only give 10ms precision in
1000HZ, which is not enough for ftrace. to get high-precise timestamp, we must
implement a new native_sched_clock() via reading the MIPS clock counter, but
since it is only 32bit long, so, overflow should be handled carefully.

this -v3 patch series is based on the -v2 patch series and incorporates the
feedback from Steven Rostedt and Thomas Gleixner.

!!NOTE!!

this -v3 not support modules yet, really hope this can be fixed in -v4 patch.

read the following document, and play with it:
        Documentation/trace/ftrace.txt

Wu Zhangjin (7):
  mips static function tracer support
  add an endian argument to scripts/recordmcount.pl
  mips dynamic function tracer support
  filter local function prefixed by $L
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
 arch/mips/kernel/ftrace.c           |  344 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/ftrace_clock.c     |   71 +++++++
 arch/mips/kernel/mcount.S           |  184 +++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c       |    5 +
 arch/mips/kernel/ptrace.c           |   14 ++-
 arch/mips/kernel/scall64-o32.S      |    2 +-
 arch/mips/kernel/vmlinux.lds.S      |    1 +
 kernel/trace/trace_clock.c          |    2 +-
 scripts/Makefile.build              |    1 +
 scripts/recordmcount.pl             |   30 +++-
 20 files changed, 799 insertions(+), 11 deletions(-)
 create mode 100644 arch/mips/include/asm/syscall.h
 create mode 100644 arch/mips/kernel/ftrace.c
 create mode 100644 arch/mips/kernel/ftrace_clock.c
 create mode 100644 arch/mips/kernel/mcount.S
