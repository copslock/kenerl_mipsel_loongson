Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 11:12:08 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:33308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010410AbcA0KMFx3s9B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 11:12:05 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87AE149;
        Wed, 27 Jan 2016 02:11:17 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF1FC3F246;
        Wed, 27 Jan 2016 02:11:53 -0800 (PST)
Date:   Wed, 27 Jan 2016 10:11:52 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] documentation: Add disclaimer
Message-ID: <20160127101151.GB2390@arm.com>
References: <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
 <20160126110053.GA21553@arm.com>
 <20160126201143.GV4503@linux.vnet.ibm.com>
 <20160127083546.GJ6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160127083546.GJ6357@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51464
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

On Wed, Jan 27, 2016 at 09:35:46AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 26, 2016 at 12:11:43PM -0800, Paul E. McKenney wrote:
> > So Peter, would you like to update your patch to include yourself
> > and Will as authors?
> 
> Sure, here goes.
> 
> ---
> Subject: documentation: Add disclaimer
> 
> It appears people are reading this document as a requirements list for
> building hardware. This is not the intent of this document. Nor is it
> particularly suited for this purpose.
> 
> The primary purpose of this document is our collective attempt to define
> a set of primitives that (hopefully) allow us to write correct code on
> the myriad of SMP platforms Linux supports.
> 
> Its a definite work in progress as our understanding of these platforms,
> and memory ordering in general, progresses.
> 
> Nor does being mentioned in this document mean we think its a
> particularly good idea; the data dependency barrier required by Alpha
> being a prime example. Yes we have it, no you're insane to require it
> when building new hardware.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/memory-barriers.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
