Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 06:00:08 +0100 (CET)
Received: from ixqw-mail-out.ixiacom.com ([66.77.12.12]:20606 "EHLO
        ixqw-mail-out.ixiacom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491081Ab1A1FAF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jan 2011 06:00:05 +0100
Received: from [10.64.33.43] (10.64.33.43) by IXCA-HC1.ixiacom.com
 (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Thu, 27 Jan 2011
 20:59:55 -0800
Message-ID: <4D424D4B.5090002@ixiacom.com>
Date:   Thu, 27 Jan 2011 20:59:55 -0800
From:   Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Publishing mips_hpt_frequency in /proc/cpuinfo
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <EChew@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echew@ixiacom.com
Precedence: bulk
X-list: linux-mips

The CPU frequency is known to the Linux kernel. For example:

> CPU revision is: 00019374 (MIPS 24Kc)
> Atheros AR7161 rev 2, CPU:680.000 MHz, AHB:170.000 MHz, DDR:340.000 MHz
> ...
> Calibrating delay loop... 452.19 BogoMIPS (lpj=2260992)

Unfortunately that information is not available from userspace:

> cpu model               : MIPS 24Kc V7.4
> BogoMIPS                : 452.19

This makes it difficult to use CPU timers (rdhwr) from user space
applications.


Is there any reason not to publish mips_hpt_frequency in /proc/cpuinfo ?


Earl


--- proc.c      2011-01-17 14:05:16.397444347 -0800
+++ /tmp/proc.c 2011-01-27 20:56:18.807454356 -0800
@@ -43,6 +43,9 @@
        seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
                      cpu_data[n].udelay_val / (500000/HZ),
                      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
+       seq_printf(m, "timer frequency\t: %u.%03u\n",
+                     mips_hpt_frequency / 1000000,
+                     mips_hpt_frequency % 1000000 / 1000);
        seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
        seq_printf(m, "microsecond timers\t: %s\n",
                      cpu_has_counter ? "yes" : "no");
