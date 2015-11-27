Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 15:26:24 +0100 (CET)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35008 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006631AbbK0O0WxWeIP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 15:26:22 +0100
Received: by oige206 with SMTP id e206so62421840oig.2
        for <linux-mips@linux-mips.org>; Fri, 27 Nov 2015 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I2vk9UrkMVuA4iRXv34fL4QjvM2xbGQlnm0qys9HMsk=;
        b=jLn+CBWc0WP+jby7IvlctCkZ3PgSHBySTPiSccHTS1RZx4ePGcZj2Q+pIlEnp+IgA7
         sJB9jbR27GL545plR6j/g2Bj3QVRTG6nxnSsIhwxnKPVFYwyrZbRJuXJjXaXyjgEq2k6
         hDhB752DBZKbLVJ9/aiOFyw610NPEuHlKL35akD241rHnYJPPKDxRxoKF1pJScb+d6ZC
         bN+Q1KbKCOo3mrHhM/nbsxFQaRJ4O/7bjvrbIkFKk3e3jFTSP46sDqkWQe5GDyBrHfo3
         GRvT8DxOpRhgbw8KVfswf/T7dlsL2D/xldpHk/2odPIP8pgDNdwPdkZ0O7quTbXfhph7
         qQlQ==
MIME-Version: 1.0
X-Received: by 10.202.81.87 with SMTP id f84mr11078009oib.0.1448634377042;
 Fri, 27 Nov 2015 06:26:17 -0800 (PST)
Received: by 10.76.177.193 with HTTP; Fri, 27 Nov 2015 06:26:16 -0800 (PST)
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
        <1448622572-16900-2-git-send-email-pmladek@suse.com>
Date:   Fri, 27 Nov 2015 17:26:16 +0300
Message-ID: <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BLACKFIN ARCHITEC..." 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "open list:CRIS PORT" <linux-cris-kernel@axis.com>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Hi Peter,

On Fri, Nov 27, 2015 at 2:09 PM, Petr Mladek <pmladek@suse.com> wrote:
> printk() takes some locks and could not be used a safe way in NMI
> context.
>
> The chance of a deadlock is real especially when printing
> stacks from all CPUs. This particular problem has been addressed
> on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> trace on all CPUs").
>
> This patch reuses most of the code and makes it generic. It is
> useful for all messages and architectures that support NMI.
>
> The alternative printk_func is set when entering and is reseted when
> leaving NMI context. It queues IRQ work to copy the messages into
> the main ring buffer in a safe context.
>
> __printk_nmi_flush() copies all available messages and reset
> the buffer. Then we could use a simple cmpxchg operations to
> get synchronized with writers. There is also used a spinlock
> to get synchronized with other flushers.
>
> We do not longer use seq_buf because it depends on external lock.
> It would be hard to make all supported operations safe for
> a lockless use. It would be confusing and error prone to
> make only some operations safe.
>
> The code is put into separate printk/nmi.c as suggested by
> Steven Rostedt. It needs a per-CPU buffer and is compiled only
> on architectures that call nmi_enter(). This is achieved by
> the new HAVE_NMI Kconfig flag.
>
> One exception is arm where the deferred printing is used for
> printing backtraces even without NMI. For this purpose,
> we define NEED_PRINTK_NMI Kconfig flag. The alternative
> printk_func is explicitly set when IPI_CPU_BACKTRACE is
> handled.
>
> Another exception is Xtensa architecture that uses just a
> fake NMI.

It's called fake because it's actually maskable, but sometimes
it is safe to use it as NMI (when there are no other IRQs at the
same priority level and that level equals EXCM level). That
condition is checked in arch/xtensa/include/asm/processor.h
So 'fake' here is to avoid confusion with real NMI that exists
on xtensa (and is not currently used in linux), otherwise code
that runs in fake NMI must follow the NMI rules.

To make xtensa compatible with your change we can add a
choice whether fake NMI should be used to kconfig. It can
then set HAVE_NMI accordingly. I'll post a patch for xtensa.

-- 
Thanks.
-- Max
