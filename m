Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 13:29:12 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:43476 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493117AbZKTM3F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 13:29:05 +0100
Received: by pwi15 with SMTP id 15so2123692pwi.24
        for <multiple recipients>; Fri, 20 Nov 2009 04:28:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=I7r3+L0XfG9gSwVeuNlmx0xIh/p5A2mf1u/pOcojQBI=;
        b=mif8Cnd92hy5xlgMLS0akYlGO1D0drBvK6UhgZtXXJw9laK2ldhxRZBzpfJ3win1oC
         58Jvc2mfxM0Tc+DmX+R+8h/VHqqXBkvxUCkcd5qxcMutddAC+yTatGQoyJB87Mui+HwU
         VdKS8gvBLUpZNASKckx0zsW/NEId3OecQcHWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=v+5EsV4HXvV8cIloZJFfVDQutbvgyUpNii0f/9Hb3Vzp2hJ8dk2ZeUtuFKWJMZani2
         yOCTDnne5N2KRwyojOKIS16/1gcpkmpViidiMUIg9K5Gc7HDXsRMfHgFPQz121a+tEjf
         ygQYQm8ZcFaXy+lpMTKDRzMQrA2DOigKH1YBg=
Received: by 10.114.2.25 with SMTP id 25mr1946222wab.103.1258720136105;
        Fri, 20 Nov 2009 04:28:56 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm891563pxi.3.2009.11.20.04.28.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 04:28:54 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org
Cc:	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v9 00/10] ftrace for MIPS
Date:	Fri, 20 Nov 2009 20:28:28 +0800
Message-Id: <cover.1258719323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

After getting the feedback of v8 revision from Thomas, I have written a
cnt3_to_63() based sched_clock() for MIPS and send it out as a standalone
patch("MIPS: Add a high precision sched_clock() via cnt32_to_63()").

This v9 revision only reserve the Ftrace parts. So, Steven or Ralf, Is it time
to apply it? Thanks!

Best Regards,
     Wu Zhangjin

Wu Zhangjin (10):
  tracing: add static function tracer support for MIPS
  tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
  tracing: add an endian argument to scripts/recordmcount.pl
  tracing: add dynamic function tracer support for MIPS
  tracing: add IRQENTRY_EXIT section for MIPS
  tracing: add function graph tracer support for MIPS
  tracing: add dynamic function graph tracer for MIPS
  tracing: make ftrace for MIPS work without -fno-omit-frame-pointer
  tracing: reserve $12(t0) for mcount-ra-address of gcc 4.5
  tracing: make function graph tracer work with -mmcount-ra-address

 arch/mips/Kconfig              |    5 +
 arch/mips/Makefile             |    9 ++
 arch/mips/include/asm/ftrace.h |   91 +++++++++++++-
 arch/mips/include/asm/irq.h    |   29 +----
 arch/mips/kernel/Makefile      |    7 +
 arch/mips/kernel/ftrace.c      |  275 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/irq.c         |   30 +++++
 arch/mips/kernel/mcount.S      |  189 +++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c  |    5 +
 arch/mips/kernel/smp.c         |    3 +-
 arch/mips/kernel/smtc.c        |   21 ++-
 arch/mips/kernel/vmlinux.lds.S |    1 +
 arch/mips/sgi-ip22/ip22-int.c  |    3 +-
 arch/mips/sgi-ip22/ip22-time.c |    3 +-
 scripts/Makefile.build         |    1 +
 scripts/recordmcount.pl        |   60 ++++++++-
 16 files changed, 691 insertions(+), 41 deletions(-)
 create mode 100644 arch/mips/kernel/ftrace.c
 create mode 100644 arch/mips/kernel/mcount.S
