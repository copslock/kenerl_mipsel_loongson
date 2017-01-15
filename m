Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2017 14:48:49 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbdAONsmfAv8F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Jan 2017 14:48:42 +0100
Received: from localhost (unknown [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06536723;
        Sun, 15 Jan 2017 13:48:35 +0000 (UTC)
Date:   Sun, 15 Jan 2017 14:48:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
Message-ID: <20170115134848.GA27658@kroah.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
 <20170111012032.GE31072@linux-mips.org>
 <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
 <20170113094939.GI10569@jhogan-linux.le.imgtec.org>
 <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Sun, Jan 15, 2017 at 02:39:49PM +0100, Jason A. Donenfeld wrote:
> Hi James,
> 
> On Fri, Jan 13, 2017 at 10:49 AM, James Hogan <james.hogan@imgtec.com> wrote:
> > Its quite a significant change/feature, especially in terms of potential
> > for further breakage. I don't think its really stable material to be
> > honest.  It sounds bad if the kernel stack requirement can be made
> > arbitrarily large by stacking too many drivers.
> 
> Indeed I believe this is the case. If, say, a kthread is already using
> a bit of stack, and then a softirq chain of stacked virtual network
> drivers is called, the stack can be busted.
> 
> > Is there a simpler fix/workaround for the issue that would satisfy
> > stable kernel users until they can upgrade to a kernel with irqstacks?
> 
> The simplest solution is probably just not stacking tons of network
> drivers. For my own out-of-tree curve25519-donna code that's in
> OpenWRT and uses a fair amount of stack, I just kmalloc on MIPS but
> not on x86, so in terms of my own stuff there's already a workaround
> in place. But this still doesn't solve things for users who have some
> interesting networking requirements and stack a few drivers.
> 
> Unfortunately, most folks are only testing stuff on ARM and x86, which
> already have the separate IRQ stacks, so they aren't hitting crashes.
> 
> So, in the end, I'm not quite sure. On the one hand, this fixes an
> actual problem and it'd be nice to see stable kernels have the fix. On
> the other hand, this is a rather big change. I don't know how to
> assess it, but I've copied Greg on this email, who certainly has
> better judgement about this than me.

How many patches is the irqstacks "feature" for MIPS?  What kernel was
it released in?  Have any git commit ids I can look at?

thanks,

greg k-h
