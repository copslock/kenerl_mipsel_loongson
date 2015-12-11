Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2015 00:31:06 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40365 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011700AbbLKXbCMcAwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Dec 2015 00:31:02 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4F5089E7;
        Fri, 11 Dec 2015 23:30:55 +0000 (UTC)
Date:   Fri, 11 Dec 2015 15:30:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Petr Mladek <pmladek@suse.com>,
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
Message-Id: <20151211153054.48da5d4139b93dd4ed438f4c@linux-foundation.org>
In-Reply-To: <20151211232113.GZ8644@n2100.arm.linux.org.uk>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
        <1449667265-17525-5-git-send-email-pmladek@suse.com>
        <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
        <20151211124159.GB3729@pathway.suse.cz>
        <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
        <20151211232113.GZ8644@n2100.arm.linux.org.uk>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50562
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

On Fri, 11 Dec 2015 23:21:13 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Dec 11, 2015 at 02:57:25PM -0800, Andrew Morton wrote:
> > This is a bit messy.  NEED_PRINTK_NMI is an added-on hack for one
> > particular arm variant.  From the changelog:
> > 
> >    "One exception is arm where the deferred printing is used for
> >     printing backtraces even without NMI.  For this purpose, we define
> >     NEED_PRINTK_NMI Kconfig flag.  The alternative printk_func is
> >     explicitly set when IPI_CPU_BACKTRACE is handled."
> > 
> > 
> > - why does arm needs deferred printing for backtraces?
> > 
> > - why is this specific to CONFIG_CPU_V7M?
> > 
> > - can this Kconfig logic be cleaned up a bit?
> 
> I think this comes purely from this attempt to apply another round of
> cleanups to the nmi backtrace work I did.
> 
> As I explained when I did that work, the vast majority of ARM platforms
> are unable to trigger anything like a NMI - the FIQ is something that's
> generally a property of the secure monitor, and is not accessible to
> Linux.  However, there are platforms where it is accessible.

OK, thanks.  So "not needed at present, might be needed in the future,
useful for out-of-tree debug code"?

> I'm personally happy with the existing code, and I've been wondering why
> there's this effort to apply further cleanups - to me, the changelogs
> don't seem to make that much sense, unless we want to start using
> printk() extensively in NMI functions - using the generic nmi backtrace
> code surely gets us something that works across all architectures...

Yes, I was scratching my head over that.  The patchset takes an nmi-safe
all-cpu-backtrace and generalises that into an nmi-safe printk.  That
*sounds* like a good thing to do but yes, some additional justification
would be helpful.  What real-world value does this patchset really
bring to real-world users?
