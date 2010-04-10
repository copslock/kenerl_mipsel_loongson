Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 08:57:13 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:64099 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490984Ab0DJG5J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 08:57:09 +0200
Received: by pvc30 with SMTP id 30so2193336pvc.36
        for <multiple recipients>; Fri, 09 Apr 2010 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=h+1ydAdbF6itO3lddgYiG6ig8+jb7AYoSAft027qwQw=;
        b=aoJEmdmkBaMv8MzbxskrM+qtUgC/K97MlA5jIdod3xewTBIOhvM+Sb/a8ZqnOS1h24
         EXvrRNzJ2oxhwkfEBcrLpUq9nrqxgj897VodTA2+yRFgRJZqQaCCb53NrN7irAfKGVRg
         3uurQc9eoAeryubfPdCjANkLhBs7DnERt4SIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iPhQZ9ELyHzexh9WHFcztPHgzEDB+jYGNJlkFyPja8qzn5vrA1lV1PiK3Eqm7QrEY3
         jMX7ZJ/JsweMiCAsO3VoChUVUcqzWSX4BCTJoLLTelOvmkME5hbbUYqjm0vwTVo8yfPe
         3HadnDPa2aqmZtdsYvShtGBtxUQDb1WwoWahQ=
Received: by 10.143.25.3 with SMTP id c3mr724269wfj.17.1270882622843;
        Fri, 09 Apr 2010 23:57:02 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm1642896pzk.8.2010.04.09.23.57.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 23:57:02 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>,
        linux-mips@linux-mips.org
Subject: [PATCH v3 0/3] add high resolution sched_clock() for MIPS
Date:   Sat, 10 Apr 2010 14:49:56 +0800
Message-Id: <cover.1270881177.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Hi, Ralf, hi David.

I have tested it again in the 32bit and 64bit kernel on a Yeeloong netbook,
both of them work well. so, it should be applicable now.

BTW: 

to David, if the first two patches are ok for you, could you give a
"Acked-by:"?  thanks!

to Ralf Rösch, does this 32bit version work for you? If yes, welcome your
tested-by:, thanks ;)

----------------

Changes:

v2 -> v3:

  o remove the 'easy way' of 128bit arithmatic of mips_cyc2ns().
  o use 32bit type instead of 64bit for the input arguments(mult and shift) as
  the 'struct clocksource' does.
  o use a smaller scaling factor: 8, with this factor, if the clock frequency
  is 400MHz, it will overflow after about 521 days.

v1 -> v2:

  o Adds 32bit support, using a smaller scaling factor(shift) to avoid 128bit
  arithmatic, of course, it loses some precision.

  o Adds the testing results of the overhead of sched_clock() in 64bit kernel

  Clock func/overhead(ns) Min Avg Max Jitter Std.Dev.
  ----------------------------------------------
  sched_clock(cnt32_to_63) 105 116.2 236 131 9.5
  getnstimeofday()      160 167.1 437 277 15
  ----------------------------------------------

  As we can see, the cnt32_to_63() based sched_clock() have lower overhead.

----------------

This patchset adds a high resolution version of sched_clock() for the r4k MIPS.

The generic sched_clock() is jiffies based and has very bad resolution(1ms with
HZ set as 1000), this one is based on the r4k c0 count, the resolution reaches
about several ns(2.5ns with 400M clock frequency).

To cope with the overflow problem of the 32bit c0 count, based on the
cnt32_to_63() method in include/linux/cnt32_to_63.h. we have converted the
32bit counter to a virtual 63bit counter.

And to fix the overflow problem of the 64bit arithmatic(cycles * mult) in 64bit
kernel, we use the 128bit arithmatic contributed by David, but for 32bit
kernel, to balance the overhead of 128bit arithmatic and the precision lost, we
choose the method used in X86(arch/x86/kernel/tsc.c) and
ARM(arch/arm/plat-orion/time.c): just use a smaller scaling factor and do 64bit
arithmatic, of course, it will also overflow but not that quickly.

Regards,
        Wu Zhangjin

Wu Zhangjin (3):
  MIPS: add a common mips_cyc2ns()
  MIPS: cavium-octeon: rewrite the sched_clock() based on mips_cyc2ns()
  MIPS: r4k: Add a high resolution sched_clock()

 arch/mips/Kconfig                     |   12 +++++
 arch/mips/cavium-octeon/csrc-octeon.c |   29 +------------
 arch/mips/include/asm/time.h          |   34 +++++++++++++++
 arch/mips/kernel/csrc-r4k.c           |   76 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c               |    5 ++
 5 files changed, 129 insertions(+), 27 deletions(-)
