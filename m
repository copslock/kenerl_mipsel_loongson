Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 18:33:55 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:52979 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493787AbZKPRdu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 18:33:50 +0100
Received: by pxi3 with SMTP id 3so217993pxi.22
        for <multiple recipients>; Mon, 16 Nov 2009 09:33:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1e6rkzDvlgYiiymbpPye3T2SjBhka1Tee0ERH7/LB04=;
        b=ohpw4FgUaA5hkcAg3r3BCvV3ksyYUT7TqwYLAcapui77/DUInSpxXody+mVQfDscJ5
         vbNwj99T66Ji3NK1CE5qKR0DkADJGPv+LPX13HtYBnteg+eUd8aKqWuW66SLKq/bFxMu
         TZZLysAa2K7TRzbYRfcMsAssoPQ42nQeyH8xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M+n2R5wFNk0dmwzVFF7XLU70QOrzBIwVgb/nq/tcbC/X0xInq4SwFW1d6s6Yih6MTG
         TfkViekRgsDIXhBqz+XFiyCqMSaHZjaAolDpCeI+6zJcNeVSKz/+2AZaKRy0JNrw1v0x
         4DV/BIjqaoJ2AEtvUMwHUTPgWm1rH9oWgWi78=
Received: by 10.115.133.39 with SMTP id k39mr15580439wan.94.1258392821410;
        Mon, 16 Nov 2009 09:33:41 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1603406pzk.4.2009.11.16.09.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 09:33:41 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 0/3]  Add CPUFreq support for loongson2f
Date:	Tue, 17 Nov 2009 01:32:56 +0800
Message-Id: <cover.1258392326.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset adds CPUFreq support for loongson2f, 'Cause loongson2f doesn't
have a fixed MIPS Timer(relative to cpu frequency), If we enable CPUFreq, the
system time will be broken.  So, an external Timer is needed, Herein, In Lemote
loongson2f family machine, there is a CS5536 MFGPT Timer, in Dexxon Gdium, it
use i8253.

This v1 revision have incorporated with the feedbacks from "Dominik Brodowski"
and Ralf. And this Thread have replied more feedbacks from Ralf:

http://www.linux-mips.org/archives/linux-mips/2009-11/msg00292.html

Best Regards,
	Wu Zhangjin

Wu Zhangjin (3):
  [loongson] lemote-2f: add cs5536 MFGPT timer support
  MIPS: add basic options for CPUFreq support
  [loongson] 2f: add CPUFreq support

 arch/mips/Kconfig                                  |    3 +
 arch/mips/include/asm/clock.h                      |   64 ++++++
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   35 +++
 arch/mips/include/asm/mach-loongson/loongson.h     |    6 +-
 arch/mips/kernel/Makefile                          |    2 +
 arch/mips/kernel/cpu-probe.c                       |    2 +
 arch/mips/kernel/cpufreq/Kconfig                   |   41 ++++
 arch/mips/kernel/cpufreq/Makefile                  |    5 +
 arch/mips/kernel/cpufreq/loongson2_clock.c         |  166 +++++++++++++++
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c       |  202 ++++++++++++++++++
 arch/mips/loongson/Kconfig                         |   16 ++-
 arch/mips/loongson/common/cs5536/Makefile          |    5 +
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  217 ++++++++++++++++++++
 arch/mips/loongson/common/env.c                    |    3 +
 arch/mips/loongson/common/time.c                   |    3 +
 15 files changed, 767 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/clock.h
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
 create mode 100644 arch/mips/kernel/cpufreq/Kconfig
 create mode 100644 arch/mips/kernel/cpufreq/Makefile
 create mode 100644 arch/mips/kernel/cpufreq/loongson2_clock.c
 create mode 100644 arch/mips/kernel/cpufreq/loongson2_cpufreq.c
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
