Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 15:26:25 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:58901 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008431AbbLOO0XYb1Nq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Dec 2015 15:26:23 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34BBCADAC;
        Tue, 15 Dec 2015 14:26:22 +0000 (UTC)
Date:   Tue, 15 Dec 2015 15:26:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20151215142621.GE3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <20151211153054.48da5d4139b93dd4ed438f4c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151211153054.48da5d4139b93dd4ed438f4c@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

On Fri 2015-12-11 15:30:54, Andrew Morton wrote:
> On Fri, 11 Dec 2015 23:21:13 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Fri, Dec 11, 2015 at 02:57:25PM -0800, Andrew Morton wrote:
> > > This is a bit messy.  NEED_PRINTK_NMI is an added-on hack for one
> > > particular arm variant.  From the changelog:
> > > 
> > >    "One exception is arm where the deferred printing is used for
> > >     printing backtraces even without NMI.  For this purpose, we define
> > >     NEED_PRINTK_NMI Kconfig flag.  The alternative printk_func is
> > >     explicitly set when IPI_CPU_BACKTRACE is handled."
> > > 
> > > 
> > > - why does arm needs deferred printing for backtraces?
> > > 
> > > - why is this specific to CONFIG_CPU_V7M?



> > > - can this Kconfig logic be cleaned up a bit?
> > 
> > I think this comes purely from this attempt to apply another round of
> > cleanups to the nmi backtrace work I did.
> > 
> > As I explained when I did that work, the vast majority of ARM platforms
> > are unable to trigger anything like a NMI - the FIQ is something that's
> > generally a property of the secure monitor, and is not accessible to
> > Linux.  However, there are platforms where it is accessible.
> 
> OK, thanks.  So "not needed at present, might be needed in the future,
> useful for out-of-tree debug code"?

It is possible that I got it a wrong way on arm. The NMI buffer is
usable there on two locations.

First, the temporary is currently used to handle IPI_CPU_BACKTRACE.
It seems that it is not a real NMI. But it seems to be available
(compiled) on all arm system. This is why I introduced NEED_PRINTK_NMI
Kconfig flag to avoid confusion with a real NMI.

Second, there is the FIQ "NMI" handler that is called from
/arch/arm/kernel/entry-armv.S. It is compiled only if _not_
defined $(CONFIG_CPU_V7M). It calls nmi_enter() and nmi_stop().
It looks like a real NMI handler. This is why I defined HAVE_NMI
if (!CPU_V7M).

A solution would be to define HAVE_NMI on all Arm systems and get rid
of NEED_PRINTK_NMI. If you think that it would cause less confusion...


> > there's this effort to apply further cleanups - to me, the changelogs
> > don't seem to make that much sense, unless we want to start using
> > printk() extensively in NMI functions - using the generic nmi backtrace
> > code surely gets us something that works across all architectures...
> 
> Yes, I was scratching my head over that.  The patchset takes an nmi-safe
> all-cpu-backtrace and generalises that into an nmi-safe printk.  That
> *sounds* like a good thing to do but yes, some additional justification
> would be helpful.  What real-world value does this patchset really
> bring to real-world users?

The patchset brings two big advantages. First, it makes the NMI
backtraces safe on all architectures for free. Second, it makes
all NMI messages almost[*] safe on all architectures.

Note that there already are several messages printed in NMI context.
See the mail from Jiri Kosina. They are not easy to avoid.

[*] The temporary buffer is limited. We still should keep
the number of messages in NMI context at minimum.

Best Regards,
Petr
