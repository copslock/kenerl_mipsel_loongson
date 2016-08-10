Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2016 10:14:28 +0200 (CEST)
Received: from mail9.hitachi.co.jp ([133.145.228.44]:39454 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992037AbcHJIOVjI4SH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Aug 2016 10:14:21 +0200
Received: from mlsw6.hitachi.co.jp (unknown [133.144.234.166])
        by mail9.hitachi.co.jp (Postfix) with ESMTP id 4B574109BD83;
        Wed, 10 Aug 2016 17:14:18 +0900 (JST)
Received: from mfilter6.hitachi.co.jp by mlsw6.hitachi.co.jp (8.13.8/8.13.8) id u7A8EILU025538; Wed, 10 Aug 2016 17:14:18 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter6.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id u7A8EG5S026594;
        Wed, 10 Aug 2016 17:14:17 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id 05F8713E03F;
        Wed, 10 Aug 2016 17:14:17 +0900 (JST)
Received: from [10.198.219.51] by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id u7A8EG0e019363; Wed, 10 Aug 2016 17:14:16 +0900
Subject: [V4 PATCH 0/2] kexec: crash_kexec_post_notifiers boot option related
 fixes
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Xunlei Pang <xpang@redhat.com>,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        xen-devel@lists.xenproject.org, Daniel Walker <dwalker@fifo99.com>,
        Vivek Goyal <vgoyal@redhat.com>
Date:   Wed, 10 Aug 2016 17:09:46 +0900
Message-ID: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

Daniel Walker reported problems which happens when
crash_kexec_post_notifiers kernel option is enabled
(https://lkml.org/lkml/2015/6/24/44).

In that case, smp_send_stop() is called before entering kdump routines
which assume other CPUs are still online.  This causes some issues
depending on architectures.  For example, for x86, kdump routines fail
to save other CPUs' registers and disable virtualization extensions.
For MIPS OCTEON, it fails to stop the watchdog timer.

To fix this problem, call a new kdump friendly function,
crash_smp_send_stop(), instead of the smp_send_stop() when
crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
weak function, and it just call smp_send_stop().  Architecture
codes should override it so that kdump can work appropriately.
This patch set supports only x86 and MIPS.

NOTE:
- Right solution would be to place crash_smp_send_stop() before
  __crash_kexec() invocation in all cases and remove smp_send_stop(),
  but we can't do that until all architectures implement own
  crash_smp_send_stop()
- crash_smp_send_stop()-like work is still needed by
  machine_crash_shutdown() because crash_kexec() can be called without
  entering panic()

Changes in V4:
- Keep to use smp_send_stop if crash_kexec_post_notifiers is not set
- Rename panic_smp_send_stop to crash_smp_send_stop
- Don't change the behavior for Xen's PV kernel
- Support MIPS

Changes in V3: https://lkml.org/lkml/2016/7/5/221
- Revise comments, description, and symbol names (the logic doesn't
  change)
- Make crash_kexec_post_notifiers boot option modifiable after boot

Changes in V2: https://lkml.org/lkml/2015/7/23/864
- Replace smp_send_stop() call with crash_kexec version which
  saves cpu states and does cleanups instead of changing execution
  flow
- Drop a fix for Problem 1
- Drop other patches because they aren't needed anymore

V1: https://lkml.org/lkml/2015/7/10/316

---

Hidehiro Kawai (2):
      x86/panic: Replace smp_send_stop() with kdump friendly version in panic path
      mips/panic: Replace smp_send_stop() with kdump friendly version in panic path


 arch/mips/cavium-octeon/setup.c  |   14 +++++++++++
 arch/mips/include/asm/kexec.h    |    1 +
 arch/mips/kernel/crash.c         |   18 ++++++++++++++-
 arch/mips/kernel/machine_kexec.c |    1 +
 arch/x86/include/asm/kexec.h     |    1 +
 arch/x86/include/asm/smp.h       |    1 +
 arch/x86/kernel/crash.c          |   22 +++++++++++++++---
 arch/x86/kernel/smp.c            |    5 ++++
 kernel/panic.c                   |   47 ++++++++++++++++++++++++++++++++------
 9 files changed, 99 insertions(+), 11 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
