Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:17:30 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:60449 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492462AbZJYPRY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:17:24 +0100
Received: by pzk35 with SMTP id 35so7469042pzk.22
        for <multiple recipients>; Sun, 25 Oct 2009 08:17:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QVJhEPu0tzHdK6L05R4o9/FxqBSPIfcZ+ZbT3qSGFb4=;
        b=JC7FOBuXfN8uYzoDND3SqshwS9vdbAWkQRkHymARO4Bb6ZSW+9ydof9suK+1wJrZZl
         zWn+E1w76A8PdLGk8ukI2wpyHfjdJaPqlq4S0jHJyDAlUhZZSiAsJEn/dmOZ3hGN8HuI
         dqapMx13I30IZzO1QCngnWk3Vww5KCi041D5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tf+TF42eQ+eFnEr8Cg3ujmFPYXApvxZ9E9BPCQRS5bhGVTbKhcDIxFUkVTKBzXpD4L
         Fmg4v7xnZGXUNrkqYnnAII5s1vMwHkhXOnZLzb0K082Won5zrZAB+4dnvrTSreQ+IBSS
         L8aovln4B+ZKYFmxN+XIRTYi8b0JJgzcpaYoQ=
Received: by 10.114.248.20 with SMTP id v20mr20542725wah.132.1256483835795;
        Sun, 25 Oct 2009 08:17:15 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:17:14 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v5 00/11] ftrace for MIPS
Date:	Sun, 25 Oct 2009 23:16:51 +0800
Message-Id: <cover.1256482555.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Under the help of the -mlong-calls option of gcc, This revision comes with the
module tracing support. and there are also lots of cleanups and fixes.
therefore, it is ready to upstream.

Currently, function graph tracer support have some overhead for searching the
stack address of the return address(ra). we hope the PROFILE_BEFORE_PROLOGUE
macro will be enabled by default in the next version of gcc, and then the
overhead can be removed via hijacking the ra register directly for both
non-leaf and leaf function.

Thanks very much to the people in the CC list for their feedbacks, all the
lastest changes goes to this git repo:

git://dev.lemote.com/rt4ls.git	linux-mips/dev/ftrace-upstream

Welcome to play with it and give more feedbacks. 

Thanks & Regards,
       Wu Zhangjin

Wu Zhangjin (11):
  tracing: convert trace_clock_local() as weak function
  MIPS: add mips_timecounter_read() to get high precision timestamp
  tracing: add MIPS specific trace_clock_local()
  tracing: add static function tracer support for MIPS
  tracing: enable HAVE_FUNCTION_TRACE_MCOUNT_TEST for MIPS
  tracing: add an endian argument to scripts/recordmcount.pl
  tracing: add dynamic function tracer support for MIPS
  tracing: not trace mips_timecounter_init() in MIPS
  tracing: add IRQENTRY_EXIT for MIPS
  tracing: add function graph tracer support for MIPS
  tracing: add dynamic function graph tracer for MIPS

 arch/mips/Kconfig              |    5 +
 arch/mips/Makefile             |    4 +
 arch/mips/include/asm/ftrace.h |   37 ++++++++-
 arch/mips/include/asm/time.h   |   19 ++++
 arch/mips/kernel/Makefile      |    9 ++
 arch/mips/kernel/csrc-r4k.c    |   41 +++++++++
 arch/mips/kernel/ftrace.c      |  190 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mcount.S      |  177 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/mips_ksyms.c  |    5 +
 arch/mips/kernel/time.c        |    2 +
 arch/mips/kernel/trace_clock.c |   33 +++++++
 arch/mips/kernel/vmlinux.lds.S |    1 +
 include/linux/clocksource.h    |    2 +-
 kernel/time/clocksource.c      |    4 +-
 kernel/trace/trace_clock.c     |    2 +-
 scripts/Makefile.build         |    1 +
 scripts/recordmcount.pl        |   44 +++++++++-
 17 files changed, 568 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/kernel/ftrace.c
 create mode 100644 arch/mips/kernel/mcount.S
 create mode 100644 arch/mips/kernel/trace_clock.c
