Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 18:14:28 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:42063 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492452Ab0DGQNV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 18:13:21 +0200
Received: by mail-pz0-f186.google.com with SMTP id 16so1089490pzk.22
        for <multiple recipients>; Wed, 07 Apr 2010 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=h1KPBpKQldIhEd5S6o5Iylbw2HMwVgqvDUCRB6cBU2g=;
        b=Gxf9i3S61C59q1Oo2vZhapwOFeZF51zEFhgT354PKHUraVvbVhkfk1IghmwwHW3sGu
         Aow+B7RG94jaSS/KS+F15XC8ufy7nbkdfJsvTtsa0ZBUG7h2YEECGAAXsqUZEd3cZdyl
         GSuAaXn594sx/qkpHGlgVeVcHh49QdC6Lgaew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fDZ1tP8cV8o2fLWMuFBh1IM7Enb38w8mMbm7jBBalnMJ3Q9olI9FEhGWIEvfTzaOcZ
         HSVFX/1goVcHQtalti2LYtQdkbKPaB+v4069nYJgvULeAzdWT2gMNuw1Hlbf1SdyoUcm
         ANUkUaS4G0oL6gg8EW1yhkE1SF3N7MzMPj2FM=
Received: by 10.142.209.17 with SMTP id h17mr3404941wfg.303.1270656773949;
        Wed, 07 Apr 2010 09:12:53 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 6sm4027054ywd.8.2010.04.07.09.12.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 09:12:52 -0700 (PDT)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>
Subject: [PATCH v2 0/3] add high resolution sched_clock() for MIPS
Date:   Thu,  8 Apr 2010 00:05:37 +0800
Message-Id: <cover.1270653461.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from old revision:

  o Adds 32bit support, using a smaller scaling factor(shift) to avoid 128bit
  arithmatic, of course, it loses some precision.

  o Adds the testing results of the overhead of sched_clock() in 64bit kernel

  Clock func/overhead(us) Min Avg Max Jitter Std.Dev.
  ----------------------------------------------
  sched_clock(cnt32_to_63) 105 116.2 236 131 9.5
  getnstimeofday()	160 167.1 437 277 15
  sched_clock(Accumulation method[1])  193 200.9 243 50 2.9
  ----------------------------------------------

  As we can see, the cnt32_to_63() based sched_clock() have lower overhead than
  the other two.

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
ARM(arch/arm/plat-orion/time.c): just use a smaller scale factor and do 64bit
arithmatic, of course, it will also overflow but not that quickly.

[1] the algorithm looks like this:

static inline unsigned long long notrace read_c0_clock(void)
{
        static u64 clock;
        static u32 old_clock;
        u32 current_clock;

        raw_spin_lock(&clock_lock);
        current_clock = read_c0_count();
        clock += ((current_clock - old_clock) & MASK);
        old_clock = current_clock;
        raw_spin_unlock(&clock_lock);

	return clock;
}

Regards,
	Wu Zhangjin
 
Wu Zhangjin (3):
  MIPS: add a common mips_cyc2ns()
  MIPS: cavium-octeon: rewrite the sched_clock() based on
    mips_cyc2ns()
  MIPS: r4k: Add a high resolution sched_clock()

 arch/mips/Kconfig                     |   12 +++++
 arch/mips/cavium-octeon/csrc-octeon.c |   28 +-----------
 arch/mips/include/asm/time.h          |   38 +++++++++++++++++
 arch/mips/kernel/csrc-r4k.c           |   75 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c               |    5 ++
 5 files changed, 132 insertions(+), 26 deletions(-)
