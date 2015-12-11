Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2015 00:26:16 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:40422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008262AbbLKX0OeMgAW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Dec 2015 00:26:14 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8F07ADE6;
        Fri, 11 Dec 2015 23:26:12 +0000 (UTC)
Date:   Sat, 12 Dec 2015 00:26:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
X-X-Sender: jkosina@pobox.suse.cz
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
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
In-Reply-To: <20151211232113.GZ8644@n2100.arm.linux.org.uk>
Message-ID: <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com> <1449667265-17525-5-git-send-email-pmladek@suse.com> <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com> <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org> <20151211232113.GZ8644@n2100.arm.linux.org.uk>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jikos@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jikos@kernel.org
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

On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:

> I'm personally happy with the existing code, and I've been wondering why
> there's this effort to apply further cleanups - to me, the changelogs
> don't seem to make that much sense, unless we want to start using
> printk() extensively in NMI functions - using the generic nmi backtrace
> code surely gets us something that works across all architectures...

It is already being used extensively, and not only for all-CPU backtraces. 
For starters, please consider

- WARN_ON(in_nmi())
- BUG_ON(in_nmi())
- anything being printed out from MCE handlers

-- 
Jiri Kosina
SUSE Labs
