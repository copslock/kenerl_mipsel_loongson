Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 12:21:50 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:50912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006859AbbLHLVtAFySp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Dec 2015 12:21:49 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CCE22ABE5;
        Tue,  8 Dec 2015 11:21:47 +0000 (UTC)
Date:   Tue, 8 Dec 2015 12:21:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in NMI
 context
Message-ID: <20151208112145.GK20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50419
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

> Take the scenario where CPU1 is in the middle of a printk(), and is
> holding its lock.
> 
> CPU0 comes along and decides to trigger a NMI backtrace.  This sends
> a NMI to CPU1, which takes it in the middle of the serial console
> output.
> 
> With the existing solution, the NMI output will be written to the
> temporary buffer, and CPU1 has finished handling the NMI it resumes
> the serial console output, eventually dropping the lock.  That then
> allows CPU0 to print the contents of all buffers, and we get NMI
> printk output.
> 
> With this solution, as I understand it, we'll instead end up with
> CPU1's printk trying to output direct to the console, and although
> we've busted a couple of locks, we won't have busted the serial
> console locks, so CPU1 will deadlock - and that will stop any output
> what so ever.
> 
> If this is correct, then the net result is that we go from NMI with
> serial console producing output to NMI with serial console being
> less reliable at producing output.

You are right. I thought about it a lot and I think that the best
solution is to avoid this patch at all. I guess that it will make
Peter Zijlstra happy as well.

Best Regards,
Petr
