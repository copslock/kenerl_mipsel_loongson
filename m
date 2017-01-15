Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2017 15:30:18 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbdAOOaL6eqlz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Jan 2017 15:30:11 +0100
Received: from localhost (unknown [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC165258;
        Sun, 15 Jan 2017 14:30:04 +0000 (UTC)
Date:   Sun, 15 Jan 2017 15:30:19 +0100
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
Message-ID: <20170115143019.GA24619@kroah.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
 <20170111012032.GE31072@linux-mips.org>
 <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
 <20170113094939.GI10569@jhogan-linux.le.imgtec.org>
 <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
 <20170115134848.GA27658@kroah.com>
 <CAHmME9q04CwkmorTJaGTWKS9gvJpOpyp4FGuhySKHC7CySDWHw@mail.gmail.com>
 <CAHmME9oQ-HYQktU4JDZbnvj58WW8EE_40u8Nq-PxeJWHcvXmcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oQ-HYQktU4JDZbnvj58WW8EE_40u8Nq-PxeJWHcvXmcQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56315
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

On Sun, Jan 15, 2017 at 03:15:35PM +0100, Jason A. Donenfeld wrote:
> On Sun, Jan 15, 2017 at 3:11 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > According to Ralf, it's queued up for 4.11? Is that right?
> 
> It's in -next:
> 
> Part 1: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=fe8bd18ffea5327344d4ec2bf11f47951212abd0
> Part 2: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=d42d8d106b0275b027c1e8992c42aecf933436ea
> Part 3: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=510d86362a27577f5ee23f46cfb354ad49731e61
> Part 4: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=dda45f701c9d7ad4ac0bb446e3a96f6df9a468d9
> Part 5: https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=3cc3434fd6307d06b53b98ce83e76bf9807689b9

Sweet, that's it?  Nice stuff, and all small and well-contained.

If the MIPS maintainers have no issue with this, and it works out well
in 4.11 for people (let's get it shaken out there first), I would have
no objection to backporting this to the 4.4 and 4.9 stable trees if it
will help out with issues that people are having with those tree.

thanks,

greg k-h
