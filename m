Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 20:37:01 +0100 (CET)
Received: from e33.co.us.ibm.com ([32.97.110.151]:49217 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008543AbcBPTg7KkuEF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 20:36:59 +0100
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 16 Feb 2016 12:36:52 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 16 Feb 2016 12:36:40 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 946031FF001E
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 12:24:49 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1GJadTr32047122
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 19:36:39 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1GJab5T014131
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 14:36:38 -0500
Received: from paulmck-ThinkPad-W541 ([9.70.82.75])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u1GJaaUD014085;
        Tue, 16 Feb 2016 14:36:36 -0500
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 33A6116C2A87; Tue, 16 Feb 2016 11:36:44 -0800 (PST)
Date:   Tue, 16 Feb 2016 11:36:44 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>, Andy.Glew@imgtec.com,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Miller <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-metag@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        linux-xtensa@linux-xtensa.org,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>, graham.whaley@gmail.com,
        Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: Writes, smp_wmb(), and transitivity?
Message-ID: <20160216193644.GV6719@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16021619-0009-0000-0000-0000126EDF11
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Tue, Feb 16, 2016 at 10:59:08AM -0800, Linus Torvalds wrote:
> On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > Two threads:
> >
> >         int a, b;
> >
> >         void thread0(void)
> >         {
> >                 WRITE_ONCE(a, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(b, 2);
> >         }
> >
> >         void thread1(void)
> >         {
> >                 WRITE_ONCE(b, 1);
> >                 smp_wmb();
> >                 WRITE_ONCE(a, 2);
> >         }
> >
> >         /* After all threads have completed and the dust has settled... */
> >
> >         BUG_ON(a == 1 && b == 1);
> 
> So the more I look at that kind of litmus test, the less I think that
> we should care, because I can't come up with a scenario in where that
> kind of test makes sense. without even a possibility of any causal
> relationship between the two, I can't say why we'd ever care about the
> ordering of the (independent) writes to the individual variables.
> 
> If somebody can make up a causal chain, things differ. But as long as
> all the CPU's are just doing locally ordered writes, I don't think we
> need to care about a global store ordering.

Works for me!  (Yes, I can artificially generate a use case for this
thing, but all the ones I have come up with have some better and more
sane way to get the job done.  So I completely agree with your not caring
about it.)

So for transitivity, we focus on causal chains, where one task writes
to some variable that the next task reads.

In addition, if all threads use full memory barriers throughout, as in
smp_mb(), then full ordering is of course provided regardless of the
pattern of reads and writes.

							Thanx, Paul
