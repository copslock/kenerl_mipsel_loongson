Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 16:28:32 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:43677 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992058AbcHaO2009Wo9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 16:28:26 +0200
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=twins.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
        id 1bf6V3-0004xn-SK; Wed, 31 Aug 2016 14:28:22 +0000
Received: by twins.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1229E12573B0D; Wed, 31 Aug 2016 16:28:21 +0200 (CEST)
Date:   Wed, 31 Aug 2016 16:28:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 06/10] MIPS: pm-cps: Use MIPS standard lightweight
 ordering barrier
Message-ID: <20160831142821.GF10138@twins.programming.kicks-ass.net>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
 <1472640279-26593-7-git-send-email-matt.redfearn@imgtec.com>
 <20160831114847.GB10153@twins.programming.kicks-ass.net>
 <4c91d6c3-8141-594a-562c-96ea56776d2e@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c91d6c3-8141-594a-562c-96ea56776d2e@imgtec.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54897
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

On Wed, Aug 31, 2016 at 02:36:26PM +0100, Matt Redfearn wrote:
> 
> The code previously had 0x10 as a magic number, this patch just replaces
> that with a #defined name. The value is documented in the MIPS64 instruction
> set manual, https://imgtec.com/?do-download=4302, table 6.5.
> 
> This sync type has been standard since MIPSr2. That document also states
> that "If an implementation does not use one of these non-zero values to
> define a different synchronization behavior, then that non-zero value of
> stype must act the same as stype zero completion barrier." As such,
> stype_ordering can always be set to this sync type rather than setting it
> only for certain CPUs.

Right. We all had a bunch of fun trying to decode that manual a while
back, and IIRC were left with a bunch of questions on what it all meant
in 3+ CPU scenarios.

In anycase, not sure why I was Cc'ed to this patch, but in general I
have low confidence in barrier patches that lack lots of detail. And the
code in question has woefully inadequate comments:

                /* Ordering barrier */
                uasm_i_sync(&p, stype_ordering);

Order what against what and why? Is my first question. A comment really
should explain.

In any case, you've removed the only (runtime) assignment to the
variable, it can become 'const'.
