Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 21:52:34 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:41520
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeCNUw14vpM0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2018 21:52:27 +0100
Received: by mail-qk0-x244.google.com with SMTP id s78so5023158qkl.8;
        Wed, 14 Mar 2018 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TuIcBMbKJVC7d7hFcyT5+6GqO7a+cU58/fsIl4kmons=;
        b=KkexHSMH9xcBD9TP9uLnSQTvtAtzKgS0BLXVnOlDeI1kF3ldBVjBs0PWUxJdZhpcA9
         3qjBO6fDMKirGPIb4gUNGHrX1FsVCq7RI548v1jilreCm6jdHMcW0NZsCgn5aW6NZB9B
         SuF7WsyPOC9mtFELWSWpw6VH67HqMz+hsHbdpagiGqaw8FuoIKYmvF1IjdGyPsTWCTb1
         a0j0NmQxhrR5UmtyAf8C/1UfUdqmawo9HZyxcVGwu5FPzZFOO/RXnhV9q6QbFF6y+u4d
         wInlWaOC/FdBuDgo2ZK7UOFiRLPYSkk9uUhJXqt/9REaHl1TlKNipuAaaG4bsHp8fgax
         PwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TuIcBMbKJVC7d7hFcyT5+6GqO7a+cU58/fsIl4kmons=;
        b=mQLICFbGxxfcdf/OJkEgjKwVHlG2++m0rlLKOvvnMIx4nkKDK12cM9ftFQ1ph4I80F
         uyYKr2bIjkQCd90tBtbGfM8NofrEmgZMZIbSR7htqny4aGejKwzZ1+BVsQE7+bNmBbkj
         rLjs9tgCFhIYF1f/KCDRexCMn+IhJo0J8uVUMkXjF20SXgLzyC3bZhdxW905oYRktOM9
         eeJcH7EhXOG8BAfwgnk089yh9JZS7J3olr0DglKUy+wXbafLnphaXe+JvniheZDWtYTk
         TBhwadvCDp4LlV7D3gqf3ZmaQgQrVLzNU8jPNgZBzBn3m2eje52zGLCCy3Lcc65eBeMK
         huCA==
X-Gm-Message-State: AElRT7EEzZXaDs0k/copNwiKy3RRGWddoT4T65mZFHvpKw4SHpkc9amt
        foZh1yVBsn8XlXGyb2JxmuNEbx/x5hAKF8Q8KRM=
X-Google-Smtp-Source: AG47ELvxs8tI4ovw4LYYl9WnjOgPeVdJtaAfQjx47VJzx8+UktWw9SmhCiypE7XQ2V4v84urAT3Y9dTr7i/ZSrAncvY=
X-Received: by 10.55.157.66 with SMTP id g63mr9063341qke.107.1521060741652;
 Wed, 14 Mar 2018 13:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.46 with HTTP; Wed, 14 Mar 2018 13:52:21 -0700 (PDT)
In-Reply-To: <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
References: <20180312175307.11032-3-deepa.kernel@gmail.com>
 <201803132313.a4R8Y434%fengguang.wu@intel.com> <CABeXuvqNKfuvffU24Xydixv6Ro8R=2nAH4bruzx0AW=ax-6yOQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 14 Mar 2018 21:52:21 +0100
X-Google-Sender-Auth: QhLFsyx3N4JlhiSHq39H04slYE8
Message-ID: <CAK8P3a1fxWAK94GH0cpzh6CHXgL4uJuDNCGpdJen5ib1HH1xoA@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v4 02/10] include: Move compat_timespec/ timeval
 to compat_time.h
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        sebott@linux.vnet.ibm.com,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Robert Richter <rric@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gerald.schaefer@de.ibm.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, cohuck@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, kbuild-all@01.org,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Mar 14, 2018 at 4:50 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The file arch/arm64/kernel/process.c needs asm/compat.h also to be
> included directly since this is included conditionally from
> include/compat.h. This does seem to be typical of arm64 as I was not
> completely able to get rid of asm/compat.h includes for arm64 in this
> series. My plan is to have separate patches to get rid of asm/compat.h
> includes for the architectures that are not straight forward to keep
> this series simple.
> I will fix this and update the series.
>

I ran across the same thing in two more files during randconfig testing on
arm64 now, adding this fixup on top for the moment, but maybe there
is a better way:

commit 4f3e9e1211799a79b201a1af309a1ec3864147ec
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Mar 14 18:23:16 2018 +0100

    arm64: fix perf_regs.c

    arch/arm64/kernel/perf_regs.c: In function 'perf_reg_abi':
    arch/arm64/kernel/perf_regs.c:50:6: error: implicit declaration of
function 'is_compat_thread'; did you mean 'is_compat_task'?
[-Werror=implicit-function-declaration]
    arch/arm64/kernel/hw_breakpoint.c: In function 'is_compat_bp':
    arch/arm64/kernel/hw_breakpoint.c:182:16: error: implicit
declaration of function 'is_compat_thread'; did you mean
'is_compat_task'? [-Werror=implicit-function-declaration]

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/kernel/hw_breakpoint.c
b/arch/arm64/kernel/hw_breakpoint.c
index 413dbe530da8..74bb56f656ef 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -30,6 +30,7 @@
 #include <linux/smp.h>
 #include <linux/uaccess.h>

+#include <asm/compat.h>
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac612146e..1b463a4efe49 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -6,6 +6,7 @@
 #include <linux/bug.h>
 #include <linux/sched/task_stack.h>

+#include <asm/compat.h>
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
