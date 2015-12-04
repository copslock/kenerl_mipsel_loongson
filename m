Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 17:57:51 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:36092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013222AbbLDQ5tJJ8L6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 17:57:49 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D303AAC1;
        Fri,  4 Dec 2015 16:57:46 +0000 (UTC)
Date:   Fri, 4 Dec 2015 17:57:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20151204165744.GD20935@pathway.suse.cz>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <201511271919.aEZuZKNe%fengguang.wu@intel.com>
 <20151127153804.GC2648@pathway.suse.cz>
 <alpine.LNX.2.00.1512020022460.32500@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1512020022460.32500@pobox.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50342
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

On Wed 2015-12-02 00:24:49, Jiri Kosina wrote:
> On Fri, 27 Nov 2015, Petr Mladek wrote:
> 
> > MN10300 has its own implementation for entering and exiting NMI 
> > handlers. It does not call nmi_enter() and nmi_exit(). Please, find 
> > below an updated patch that adds printk_nmi_enter() and 
> > printk_nmi_exit() to the custom entry points. Then we could add HAVE_NMI 
> > to arch/mn10300/Kconfig and avoid the above warning.
> 
> Hmm, so what exactly would go wrong if MN10300 (whatever that architecture 
> is) would call nmi_enter() and nmi_exit() at the places where it's 
> starting and finishing NMI handler?
> 
> >From a cursory look, it seems like most (if not all) of the things called 
> from nmi_{enter,exit}() would be nops there anyway.

Good point. Max mentioned in the other main that the NMI handler
should follow the NMI ruler. I do not why it could not work.
In fact, it might improve things, e.g. nmi_enter() blocks
recursive NMIs.

I think that it will move it into a separate patch, thought.

Best Regards,
Petr
