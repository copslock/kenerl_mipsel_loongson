Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 11:40:26 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:55510 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009479AbcALKkWMGYBK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jan 2016 11:40:22 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aIwN3-0002Ov-Ve; Tue, 12 Jan 2016 10:40:14 +0000
Received: by twins (Postfix, from userid 1000)
        id 0786C1257A0D8; Tue, 12 Jan 2016 11:40:12 +0100 (CET)
Date:   Tue, 12 Jan 2016 11:40:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        will.deacon@arm.com, james.hogan@imgtec.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112104012.GW6373@twins.programming.kicks-ass.net>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160112102555.GV6373@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Tue, Jan 12, 2016 at 11:25:55AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 12, 2016 at 10:27:11AM +0100, Peter Zijlstra wrote:
> > 2) the changelog _completely_ fails to explain the sync 0x11 and sync
> > 0x12 semantics nor does it provide a publicly accessible link to
> > documentation that does.
> 
> Ralf pointed me at: https://imgtec.com/mips/architectures/mips64/
> 
> > 3) it really should have explained what you did with
> > smp_llsc_mb/smp_mb__before_llsc() in _detail_.
> 
> And reading the MIPS64 v6.04 instruction set manual, I think 0x11/0x12
> are _NOT_ transitive and therefore cannot be used to implement the
> smp_mb__{before,after} stuff.
> 
> That is, in MIPS speak, those SYNC types are Ordering Barriers, not
> Completion Barriers. They need not be globally performed.

Which if true; and I know Will has some questions here; would also mean
that you 'cannot' use the ACQUIRE/RELEASE barriers for your locks as was
recently suggested by David Daney.

That is, currently all architectures -- with exception of PPC -- have
RCsc locks, but using these non-transitive things will get you RCpc
locks.

So yes, MIPS can go RCpc for its locks and share the burden of pain with
PPC, but that needs to be a very concious decision.
