Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 13:40:16 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:44424 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009607AbbGJLj47KQlT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 13:39:56 +0200
Received: from mlsv5.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 67088B1D383;
        Fri, 10 Jul 2015 20:39:53 +0900 (JST)
Received: from mfilter06.hitachi.co.jp by mlsv5.hitachi.co.jp (8.13.1/8.13.1) id t6ABdrnD001968; Fri, 10 Jul 2015 20:39:53 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter06.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6ABdpYw023935;
        Fri, 10 Jul 2015 20:39:52 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 78F66490042;
        Fri, 10 Jul 2015 20:39:51 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t6ABdpev008753; Fri, 10 Jul 2015 20:39:51 +0900
X-AuditID: 85900ec0-9cdc8b9000001a57-6a-559faef01209
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 6D781236561;
        Fri, 10 Jul 2015 20:39:28 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id E38CD53C21A;
        Fri, 10 Jul 2015 20:39:50 +0900 (JST)
Received: from [10.198.219.30] (unknown [10.198.219.30])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id 9EF86495B93;
        Fri, 10 Jul 2015 20:39:50 +0900 (JST)
X-Mailbox-Line: From nobody Fri Jul 10 20:33:31 2015
Subject: [PATCH 0/3] kexec: crash_kexec_post_notifiers boot option related
 fixes
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.10495.stgit@softrs>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48171
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

This is a bugfix patch set for crash_kexec_post_notifiers boot option
which allows users to call panic notifiers and kmsg dumpers before
kdump.

The main patch is PATCH 3/3, and it fixes two problems reported by
Daniel Walker (https://lkml.org/lkml/2015/6/24/44). 

 Problem 1:
 If crash_kexec_post_notifiers boot option is specified, some
 shutting down process which assume other cpus are still alive
 don't work properly.

 Problem 2:
 If crash_kexec_post_notifiers boot option is specified, register
 information of other cpus are not saved to crash dumps.

PATCH 3/3 is also another solution for a bug reported by Daisuke
Hatayama (https://lkml.org/lkml/2015/5/15/284).  So, this patch
replace commits 5375b70 and f45d85f which fix the bug.

---

Hidehiro Kawai (3):
      panic: Disable crash_kexec_post_notifiers if kdump is not available
      kexec: Pass panic message to crash_kexec()
      kexec: Change the timing of callbacks related to "crash_kexec_post_notifiers" boot option


 Documentation/kernel-parameters.txt |    4 ++
 arch/arm/kernel/traps.c             |    2 +
 arch/arm64/kernel/traps.c           |    2 +
 arch/metag/kernel/traps.c           |    2 +
 arch/mips/kernel/traps.c            |    2 +
 arch/powerpc/kernel/traps.c         |    2 +
 arch/s390/kernel/ipl.c              |    2 +
 arch/sh/kernel/traps.c              |    2 +
 arch/x86/kernel/dumpstack.c         |    2 +
 arch/x86/platform/uv/uv_nmi.c       |    2 +
 include/linux/kernel.h              |    1 +
 include/linux/kexec.h               |    7 +++-
 kernel/kexec.c                      |   62 ++++++++++++++++++++++++++++++-----
 kernel/panic.c                      |   23 ++++---------
 14 files changed, 80 insertions(+), 35 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
