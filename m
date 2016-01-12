Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 12:41:24 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:43902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011189AbcALLlWfXlLz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2016 12:41:22 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546804A7;
        Tue, 12 Jan 2016 03:40:40 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CC163F246;
        Tue, 12 Jan 2016 03:41:10 -0800 (PST)
Date:   Tue, 12 Jan 2016 11:41:11 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112114111.GB15737@arm.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160112104012.GW6373@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Tue, Jan 12, 2016 at 11:40:12AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 12, 2016 at 11:25:55AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 12, 2016 at 10:27:11AM +0100, Peter Zijlstra wrote:
> > > 2) the changelog _completely_ fails to explain the sync 0x11 and sync
> > > 0x12 semantics nor does it provide a publicly accessible link to
> > > documentation that does.
> > 
> > Ralf pointed me at: https://imgtec.com/mips/architectures/mips64/
> > 
> > > 3) it really should have explained what you did with
> > > smp_llsc_mb/smp_mb__before_llsc() in _detail_.
> > 
> > And reading the MIPS64 v6.04 instruction set manual, I think 0x11/0x12
> > are _NOT_ transitive and therefore cannot be used to implement the
> > smp_mb__{before,after} stuff.
> > 
> > That is, in MIPS speak, those SYNC types are Ordering Barriers, not
> > Completion Barriers. They need not be globally performed.
> 
> Which if true; and I know Will has some questions here; would also mean
> that you 'cannot' use the ACQUIRE/RELEASE barriers for your locks as was
> recently suggested by David Daney.

The issue I have with the SYNC description in the text above is that it
describes the single CPU (program order) and the dual-CPU (confusingly
named global order) cases, but then doesn't generalise any further. That
means we can't sensibly reason about transitivity properties when a third
agent is involved. For example, the WRC+sync+addr test:


P0:
Wx = 1

P1:
Rx == 1
SYNC
Wy = 1

P2:
Ry == 1
<address dep>
Rx = 0


I can't find anything to forbid that, given the text. The main problem
is having the SYNC on P1 affect the write by P0.

> That is, currently all architectures -- with exception of PPC -- have
> RCsc locks, but using these non-transitive things will get you RCpc
> locks.
> 
> So yes, MIPS can go RCpc for its locks and share the burden of pain with
> PPC, but that needs to be a very concious decision.

I think it's much worse than RCpc, given my interpretation of the wording.

Will
