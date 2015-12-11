Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 23:57:35 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36733 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008262AbbLKW5dUOwaa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Dec 2015 23:57:33 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 15C83DAA;
        Fri, 11 Dec 2015 22:57:26 +0000 (UTC)
Date:   Fri, 11 Dec 2015 14:57:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
Message-Id: <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
        <1449667265-17525-5-git-send-email-pmladek@suse.com>
        <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
        <20151211124159.GB3729@pathway.suse.cz>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Fri, 11 Dec 2015 13:41:59 +0100 Petr Mladek <pmladek@suse.com> wrote:

> On Fri 2015-12-11 12:10:02, Geert Uytterhoeven wrote:
> > On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
> > >                      13 =>   8 KB for each CPU
> > >                      12 =>   4 KB for each CPU
> > >
> > > +config NMI_LOG_BUF_SHIFT
> > > +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
> > > +       range 10 21
> > > +       default 13
> > > +       depends on PRINTK && HAVE_NMI
> > 
> > Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.
> 
> __h, the NMI buffer is enabled on arm via NEED_PRINTK_NMI.
> 
> The buffer is compiled when CONFIG_PRINTK_NMI is defined. I am going
> to fix it the following way:
> 
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>  	int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>  	range 10 21
>  	default 13
> -	depends on PRINTK && HAVE_NMI
> +	depends on PRINTK_NMI
>  	help
>  	  Select the size of a per-CPU buffer where NMI messages are temporary
>  	  stored. They are copied to the main log buffer in a safe context

I'm wondering why we're building kernel/printk/nmi.o if HAVE_NMI is not
set.

	obj-$(CONFIG_PRINTK_NMI)		+= nmi.o

and

	config PRINTK_NMI
		def_bool y
		depends on PRINTK
		depends on HAVE_NMI || NEED_PRINTK_NMI

This is a bit messy.  NEED_PRINTK_NMI is an added-on hack for one
particular arm variant.  From the changelog:

   "One exception is arm where the deferred printing is used for
    printing backtraces even without NMI.  For this purpose, we define
    NEED_PRINTK_NMI Kconfig flag.  The alternative printk_func is
    explicitly set when IPI_CPU_BACKTRACE is handled."


- why does arm needs deferred printing for backtraces?

- why is this specific to CONFIG_CPU_V7M?

- can this Kconfig logic be cleaned up a bit?
