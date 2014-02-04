Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 20:39:54 +0100 (CET)
Received: from merlin.infradead.org ([205.233.59.134]:46598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827441AbaBDTjw3F1mF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Feb 2014 20:39:52 +0100
Received: from dhcp-077-248-225-117.chello.nl ([77.248.225.117] helo=laptop)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1WAlqR-000765-0S; Tue, 04 Feb 2014 19:39:43 +0000
Received: by laptop (Postfix, from userid 1000)
        id 359F910872146; Tue,  4 Feb 2014 20:39:41 +0100 (CET)
Date:   Tue, 4 Feb 2014 20:39:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: mips octeon memory model questions
Message-ID: <20140204193941.GD5002@laptop.programming.kicks-ass.net>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
 <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
 <20140204190535.GC5002@laptop.programming.kicks-ass.net>
 <CA+55aFwiuE+WbNLdeV8sGqZccoXkjg_VFOJ+xKMZUgbFP_sKZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwiuE+WbNLdeV8sGqZccoXkjg_VFOJ+xKMZUgbFP_sKZw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39213
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

On Tue, Feb 04, 2014 at 11:16:58AM -0800, Linus Torvalds wrote:
> On Tue, Feb 4, 2014 at 11:05 AM, Peter Zijlstra
> >
> >> So writes move down, not up.
> >
> > Right, but the ll-sc store might move down over a later store.
> 
> Unlikely. The thing is, in order for the sc to succeed, it has to
> already have hit the cache coherency domain (or at least reserved it -
> ie maybe the value is not actually *in* the cache, but the sc needs to
> have gotten exclusive access to the cacheline).
> 
> So just how do you expect a later store (that is *after* the
> conditional branch that tests the result of the sc) to move up before
> it?

Ah, I completely overlooked the control dependency to the subsequent
store.

Yes, given that this makes sense.
