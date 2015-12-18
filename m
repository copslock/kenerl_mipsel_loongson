Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2015 00:03:29 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014143AbbLRXD2ZecSo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Dec 2015 00:03:28 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 492ACEBA;
        Fri, 18 Dec 2015 23:03:21 +0000 (UTC)
Date:   Fri, 18 Dec 2015 15:03:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20151218150320.5d377789ee6253379b82412d@linux-foundation.org>
In-Reply-To: <20151218121141.GR6373@twins.programming.kicks-ass.net>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
        <1449667265-17525-5-git-send-email-pmladek@suse.com>
        <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
        <20151211124159.GB3729@pathway.suse.cz>
        <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
        <20151211232113.GZ8644@n2100.arm.linux.org.uk>
        <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
        <5673DD60.7080302@linaro.org>
        <20151218112902.GO6344@twins.programming.kicks-ass.net>
        <20151218121141.GR6373@twins.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50696
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

On Fri, 18 Dec 2015 13:11:41 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Dec 18, 2015 at 12:29:02PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 18, 2015 at 10:18:08AM +0000, Daniel Thompson wrote:
> > > I'm not entirely sure that this is an improvement.
> > 
> > What I do these days is delete everything in vprintk_emit() and simply
> > call early_printk().
> 
> On that, whoever made the device model use vprintk_emit() broke the
> debugger (KGDB/KDB) printk intercept, and the whole vprintk_func
> redirection scheme.

crap, we have a whole set of interfaces which are broken this way. 
printk_emit(), vprintk(), vprintk_emit().


commit 7ff9554bb578ba02166071d2d487b7fc7d860d62
Author:     Kay Sievers <kay@vrfy.org>
AuthorDate: Thu May 3 02:29:13 2012 +0200
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Mon May 7 16:53:02 2012 -0700

    printk: convert byte-buffer to variable-length record buffer
