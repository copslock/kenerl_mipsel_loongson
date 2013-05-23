Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 14:27:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38002 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817293Ab3EWM1jJfql0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 May 2013 14:27:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4NCRctq014113
        for <linux-mips@linux-mips.org>; Thu, 23 May 2013 14:27:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4NCRbEf014112
        for linux-mips@linux-mips.org; Thu, 23 May 2013 14:27:37 +0200
Date:   Thu, 23 May 2013 14:27:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Loongson2 cpu_wait function
Message-ID: <20130523122737.GA12530@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

During the 3.10 merge cycle many MIPS platforms were broken by the
generic idle loop patches.  A patch series to fix this has already been
merged but I'm wondering if fb40bc3e94933007d3e42e96daf1ec8044821cb8
[MIPS: Idle: Re-enable irqs at the end of r3081, au1k and loongson2
cpu_wait.] is sufficient and correct for Loongson 2.

In particular:

 o drivers/cpufreq/loongson2_cpufreq.c protects accesses to LOONGSON_CHIPCFG0
   in loongson2_cpu_wait with a spinlock.  This spinlock is not used anywhere
   else in the kernel so it would appear there is still a race with other
   accesses to LOONGSON_CHIPCFG0.
 o It's not SMPly correct - even if cpufreq_exit restores the old value of
   cpu_wait on a SMP system another processor might still be executing
   loongson2_cpu_wait().
 o I'd appreciate if at least some basic power saving would be used even if
   CONFIG_LOONGSON2_CPUFREQ was disabled, that is loongson2_cpu_wait should
   go back to arch/mips/kernel/idle.c.
 o Could somebody test if Loongson 2 is working?  Thanks!

  Ralf
