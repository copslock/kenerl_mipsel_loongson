Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:31:04 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:64735 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492040AbZKNGa6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:30:58 +0100
Received: by pwi15 with SMTP id 15so2473620pwi.24
        for <multiple recipients>; Fri, 13 Nov 2009 22:30:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NwrL45j5ia3yJ4VL9MMeVNmenWzzabTRS6fPqLLwE8g=;
        b=jTAKiQ01bBWX9IyRIrlS3GDqOExw1WxLpUXCSaJrBC2B1MAK6gVEcCUsAIghRDO6rj
         yfGmLc2y4NIqTrspY4QbdlErUhrbBVFq+oIo14oijDc+e0a4KC0phxk3EtBZe1HzJp2g
         yg0MTeSlDcoQ1FZBxQMwXzSv42n3+EVoYz+ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fd5P7hNpDnZkeoH0yfJvQtFN+kRiSrr0+79E8aAGetBlh+uwaPkW6XYJubOQpADJ/Z
         si5XcvGoEc3/ZiWrnORz4kIxxfDfANKQzPrCR4WUDg59aSd0TAL6N0PeKoV7xnHLgQgf
         LQSSnFdcdojaI154WKa3K522wUHHHxeAI7JmE=
Received: by 10.114.87.5 with SMTP id k5mr9134504wab.145.1258180247796;
        Fri, 13 Nov 2009 22:30:47 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2675298pzk.12.2009.11.13.22.30.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:30:45 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
Subject: [PATCH v8 00/16] ftrace for MIPS
Date:	Sat, 14 Nov 2009 14:30:31 +0800
Message-Id: <cover.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds ftrace support for MIPS, including static ftracer, dynamic
ftracer and function graph tracer, and also, a MIPS specific
trace_clock_local() function is added to get high precision timestamp.

Differ from the v7, This v8 revision incoporates the feedbacks from David, Ralf
and Maciej. thanks goes to them.

  o Remove the needless -mlong-calls introduced in the old "tracing: add static
  function tracer support for MIPS"

    static ftracer already support module tracing for there is an existing
    -mlong-calls for modules in arch/mips/Makefile:
        MODFLAGS                        += -mlong-calls

  o Make dynamic ftracer work without -mlong-calls.

    Now, we need to consider the kernel and module respectively, the kernel part
    is without -mlong-calls, the module part is with -mlong-calls.
    
    In scripts/recordmcount.pl, we need to get the right offset, and in
    arch/mips/kernel/ftrace.c, we need to replace the right instruction in
    ftrace_make_nop() & ftrace_make_call().

    And what I must mention here:

      I. we will not really get the offset of calling to _mcount in
      scripts/recordmcount.pl for the modules with -mlong-calls, we get the
      offset of "lui,v1,hi16_mcount".

     II. and in the ftrace_make_nop(), we not really replace the instruction by a
     nop, but by a "b 1f" instead. so, ftrace_make_nop not mean its original
     meaning.

  o Make function graph tracer work without -mlong-calls

    'Cause -pg with and without -mlong-calls generate different number of
    instructions, we need to consider this and move the searching pointer to
    the right position in ftrace_get_parent_addr().

All of the updates have been tested with gcc-4.4/binutils-2.19.1 and
gcc-4.5(including David's mcount-ra-address)/binutils-2.20 on a YeeLoong
netbook. and the source code have been pushed into:

git://dev.lemote.com/rt4ls.git  linux-mips/dev/ftrace-upstream

BTW: What about this revision? Hope it is the last revision from me, but I can
not promise for the kernel developers are always "rigorous": they need the best
solution ;) So, more feedbacks are welcome!

Thanks & Regards,
	Wu Zhangjin

Wu Zhangjin (16):
  tracing: convert trace_clock_local() as weak function
  tracing: add mips_timecounter_read() for MIPS
  tracing: add MIPS specific trace_clock_local()
  tracing: add static function tracer support for MIPS
  tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
  tracing: add an endian argument to scripts/recordmcount.pl
  tracing: add dynamic function tracer support for MIPS
  tracing: add IRQENTRY_EXIT section for MIPS
  tracing: define a new __time_notrace annotation flag
  tracing: not trace the timecounter_read* in kernel/time/clocksource.c
  tracing: not trace mips_timecounter_read() for MIPS
  tracing: add function graph tracer support for MIPS
  tracing: add dynamic function graph tracer for MIPS
  tracing: make ftrace for MIPS work without -fno-omit-frame-pointer
  tracing: reserve $12(t0) for mcount-ra-address of gcc 4.5
  tracing: make function graph tracer work with -mmcount-ra-address

 arch/mips/Kconfig              |    5 +
 arch/mips/Makefile             |    9 ++
 arch/mips/include/asm/ftrace.h |   97 ++++++++++++++-
 arch/mips/include/asm/irq.h    |   29 +----
 arch/mips/include/asm/time.h   |   20 +++
 arch/mips/kernel/Makefile      |    9 ++
 arch/mips/kernel/csrc-r4k.c    |   42 ++++++
 arch/mips/kernel/ftrace.c      |  275 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/irq.c         |   30 +++++
 arch/mips/kernel/mcount.S      |  189 +++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c  |    5 +
 arch/mips/kernel/smp.c         |    3 +-
 arch/mips/kernel/smtc.c        |   21 ++-
 arch/mips/kernel/time.c        |    2 +
 arch/mips/kernel/trace_clock.c |   33 +++++
 arch/mips/kernel/vmlinux.lds.S |    1 +
 arch/mips/sgi-ip22/ip22-int.c  |    3 +-
 arch/mips/sgi-ip22/ip22-time.c |    3 +-
 include/linux/ftrace.h         |   12 ++
 kernel/time/clocksource.c      |    5 +-
 kernel/trace/trace_clock.c     |    2 +-
 scripts/Makefile.build         |    1 +
 scripts/recordmcount.pl        |   60 ++++++++-
 23 files changed, 812 insertions(+), 44 deletions(-)
 create mode 100644 arch/mips/kernel/ftrace.c
 create mode 100644 arch/mips/kernel/mcount.S
 create mode 100644 arch/mips/kernel/trace_clock.c
