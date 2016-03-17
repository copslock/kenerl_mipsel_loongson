Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 20:35:38 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014218AbcCQTfgHQEmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 20:35:36 +0100
Received: from akpm3.mtv.corp.google.com (unknown [104.132.1.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72AECD0F;
        Thu, 17 Mar 2016 19:35:28 +0000 (UTC)
Date:   Thu, 17 Mar 2016 12:35:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, kbuild test robot <lkp@intel.com>,
        kbuild-all@01.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        linux-am33-list@redhat.com
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in
 NMI
Message-Id: <20160317123527.6346bce3284509849d061eaa@linux-foundation.org>
In-Reply-To: <20151204165744.GD20935@pathway.suse.cz>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
        <201511271919.aEZuZKNe%fengguang.wu@intel.com>
        <20151127153804.GC2648@pathway.suse.cz>
        <alpine.LNX.2.00.1512020022460.32500@pobox.suse.cz>
        <20151204165744.GD20935@pathway.suse.cz>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52649
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

On Fri, 4 Dec 2015 17:57:44 +0100 Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2015-12-02 00:24:49, Jiri Kosina wrote:
> > On Fri, 27 Nov 2015, Petr Mladek wrote:
> > 
> > > MN10300 has its own implementation for entering and exiting NMI 
> > > handlers. It does not call nmi_enter() and nmi_exit(). Please, find 
> > > below an updated patch that adds printk_nmi_enter() and 
> > > printk_nmi_exit() to the custom entry points. Then we could add HAVE_NMI 
> > > to arch/mn10300/Kconfig and avoid the above warning.
> > 
> > Hmm, so what exactly would go wrong if MN10300 (whatever that architecture 
> > is) would call nmi_enter() and nmi_exit() at the places where it's 
> > starting and finishing NMI handler?
> > 
> > >From a cursory look, it seems like most (if not all) of the things called 
> > from nmi_{enter,exit}() would be nops there anyway.
> 
> Good point. Max mentioned in the other main that the NMI handler
> should follow the NMI ruler. I do not why it could not work.
> In fact, it might improve things, e.g. nmi_enter() blocks
> recursive NMIs.
> 
> I think that it will move it into a separate patch, thought.
> 

I've sort of lost the plot on this patchset.

I know Daniel had concerns (resolved?).  Sergey lost the ability to
perform backtraces and has a proposed fix ("printk/nmi: restore
printk_func in nmi_panic") but that wasn't fully resolved and I didn't
merge anything.  I'm not sure what Jan's thinking is on it all.

So... I'll retain 

printk-nmi-generic-solution-for-safe-printk-in-nmi.patch
printk-nmi-use-irq-work-only-when-ready.patch
printk-nmi-warn-when-some-message-has-been-lost-in-nmi-context.patch
printk-nmi-increase-the-size-of-nmi-buffer-and-make-it-configurable.patch

in -mm for now.  Perhaps I should drop them all and we start again
after -rc1?
