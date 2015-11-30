Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 15:25:51 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:36298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006999AbbK3OZsnsz2S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 15:25:48 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 596EBAB12;
        Mon, 30 Nov 2015 14:25:46 +0000 (UTC)
Date:   Mon, 30 Nov 2015 15:25:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
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
        Linux/MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in
 NMI
Message-ID: <20151130142545.GB8047@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50176
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

On Fri 2015-11-27 17:26:16, Max Filippov wrote:
Hi Max,

> > Another exception is Xtensa architecture that uses just a
> > fake NMI.
> 
> It's called fake because it's actually maskable, but sometimes
> it is safe to use it as NMI (when there are no other IRQs at the
> same priority level and that level equals EXCM level). That
> condition is checked in arch/xtensa/include/asm/processor.h
> So 'fake' here is to avoid confusion with real NMI that exists
> on xtensa (and is not currently used in linux), otherwise code
> that runs in fake NMI must follow the NMI rules.
> 
> To make xtensa compatible with your change we can add a
> choice whether fake NMI should be used to kconfig. It can
> then set HAVE_NMI accordingly. I'll post a patch for xtensa.

Thanks a lot for explanation. I'll wait for the destiny of
the patch adding CONFIG_XTENSA_FAKE_NMI. It is not easy
for me to review. Anyway, we could select HAVE_NMI for
Xtensa anytime later if this patchset goes in earlier.

Best Regards,
Petr
