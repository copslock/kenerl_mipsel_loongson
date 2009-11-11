Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 08:10:26 +0100 (CET)
Received: from mail-px0-f178.google.com ([209.85.216.178]:40748 "EHLO
	mail-px0-f178.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492124AbZKKHKT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 08:10:19 +0100
Received: by pxi8 with SMTP id 8so605234pxi.27
        for <multiple recipients>; Tue, 10 Nov 2009 23:10:12 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HMoQZ5+JDhpylB8+d3VsHpuCDeD922L9nMeIxMKcfx8=;
        b=eFn+vezpg4190fH2EoOIwe3O/9H5g4gGZTWwVMdlYl/L7cK221vjC5fiQxwaDZ7RND
         k7O1DzTqa0n7nFK9PH1vvfCzbfvnXxDhSKs/ouCkdo5rlZx7gD4l4oUogI5NwG1abxeh
         d1ghRMTLAHhjICk/q2pAhjAhIrJpIajObcb04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sSXMNQZ63QohpqClQjktl++wngloqhoO8e6OCGN6P8iBEY4X1coDejqHY+7oH757aW
         lkkr9aGw7dKPUwbbYkYpyp9Jw6AnddTSGhFHTmsU5xJRESlVS6u/UFQIPAy0BYu7cnBz
         cK1noyOvMBkFB90XKFsP7GjeZ0ZvHfuot7/Ow=
Received: by 10.114.165.20 with SMTP id n20mr2524184wae.6.1257923412334;
        Tue, 10 Nov 2009 23:10:12 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm830254pzk.7.2009.11.10.23.10.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 23:10:11 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/3] add CPUFreq support for loongson2f
Date:	Wed, 11 Nov 2009 15:09:56 +0800
Message-Id: <cover.1257923011.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset add CPUFreq support for loongson2f family machines, to untilize
this support, the machines need an external timer to ensure the system timer is
normal for the MIPS Timer's frequency is relative to the processor's frequency,
without an external timer, the system timer will be "mussy".

Thanks & Regards,
       Wu Zhangjin

Wu Zhangjin (3):
  [loongson] lemote-2f: add cs5536 MFGPT timer support
  MIPS: add basic options for CPUFreq support
  [loongson] 2f: add Cpufreq support

 arch/mips/Kconfig                                  |    3 +
 arch/mips/include/asm/clock.h                      |   64 ++++++
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   35 +++
 arch/mips/include/asm/mach-loongson/loongson.h     |    6 +-
 arch/mips/kernel/Makefile                          |    2 +
 arch/mips/kernel/cpu-probe.c                       |    2 +
 arch/mips/kernel/cpufreq/Kconfig                   |   41 ++++
 arch/mips/kernel/cpufreq/Makefile                  |    5 +
 arch/mips/kernel/cpufreq/loongson2_clock.c         |  166 +++++++++++++++
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c       |  200 ++++++++++++++++++
 arch/mips/loongson/Kconfig                         |   12 +-
 arch/mips/loongson/common/cs5536/Makefile          |    5 +
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  217 ++++++++++++++++++++
 arch/mips/loongson/common/env.c                    |    3 +
 arch/mips/loongson/common/time.c                   |    3 +
 15 files changed, 761 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/clock.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
 create mode 100644 arch/mips/kernel/cpufreq/Kconfig
 create mode 100644 arch/mips/kernel/cpufreq/Makefile
 create mode 100644 arch/mips/kernel/cpufreq/loongson2_clock.c
 create mode 100644 arch/mips/kernel/cpufreq/loongson2_cpufreq.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
