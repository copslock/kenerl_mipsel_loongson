Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2015 00:22:53 +0100 (CET)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36501 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008262AbbLKXWvy23Ma (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Dec 2015 00:22:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lUjy6KFQf1ALWfIdy8uf0y9mWh5RoYtjMWSmsRtccKs=;
        b=jKphZkil+uZA4MA9eGoxo4AwlQ/UIMnx60dOHWvjr2g5ElhfmCwUgJhia/rLc+fSZ1YEFdbY7q6B/PjlSVtYgutIfRxdCiIcMWNvV1nqO06/ZWD40MnX2X/BuipiAnOJXcaPXcnvrPemo83Krce4CM5Qh99OvjRFprMsmknjhnQ=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:60076)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1a7X02-0001c5-SV; Fri, 11 Dec 2015 23:22:07 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1a7Wzx-0006we-JE; Fri, 11 Dec 2015 23:21:13 +0000
Date:   Fri, 11 Dec 2015 23:21:13 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <20151211232113.GZ8644@n2100.arm.linux.org.uk>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Fri, Dec 11, 2015 at 02:57:25PM -0800, Andrew Morton wrote:
> This is a bit messy.  NEED_PRINTK_NMI is an added-on hack for one
> particular arm variant.  From the changelog:
> 
>    "One exception is arm where the deferred printing is used for
>     printing backtraces even without NMI.  For this purpose, we define
>     NEED_PRINTK_NMI Kconfig flag.  The alternative printk_func is
>     explicitly set when IPI_CPU_BACKTRACE is handled."
> 
> 
> - why does arm needs deferred printing for backtraces?
> 
> - why is this specific to CONFIG_CPU_V7M?
> 
> - can this Kconfig logic be cleaned up a bit?

I think this comes purely from this attempt to apply another round of
cleanups to the nmi backtrace work I did.

As I explained when I did that work, the vast majority of ARM platforms
are unable to trigger anything like a NMI - the FIQ is something that's
generally a property of the secure monitor, and is not accessible to
Linux.  However, there are platforms where it is accessible.

The work to add the FIQ-based variant never happened (I've no idea what
happened to that part, Daniel seems to have lost interest in working on
it.)  So, what we have is the IRQ-based variant merged in mainline, which
would be the fallback for the "FIQ not available" cases, and I carry a
local hack in my tree which provides the FIQ-based version - but if it
were to trigger, it takes out all interrupts (hence why I've not merged
my hack.)

I think the reason that the FIQ-based variant has never really happened
is that hooking into the interrupt controller code to clear down the FIQ
creates such a horrid layering violation, and also a locking mess that
I suspect it's just been given up with.

However, I've found my "hack" useful - it's turned a number of totally
undebuggable hangs (where one CPU silently hangs leaving the others
running with no way to find out where the hung CPU is) into something
that can be debugged.

Now, when we end up triggering the IRQ-based variant, we could already
be in a situation where IRQs are off for the local CPU, so the IRQ is
never delivered.  Others decided that it wasn't acceptable to wait 10sec
for the local CPU to time out, and (iirc) we'd also loose the local CPUs
backtrace in certain situations.

I'm personally happy with the existing code, and I've been wondering why
there's this effort to apply further cleanups - to me, the changelogs
don't seem to make that much sense, unless we want to start using
printk() extensively in NMI functions - using the generic nmi backtrace
code surely gets us something that works across all architectures...

I've been assuming that I've missed something, which is why I've not
said anything on that point until now.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
