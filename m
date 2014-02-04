Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 20:05:46 +0100 (CET)
Received: from merlin.infradead.org ([205.233.59.134]:45305 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6836937AbaBDTFnt7U2T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Feb 2014 20:05:43 +0100
Received: from dhcp-077-248-225-117.chello.nl ([77.248.225.117] helo=laptop)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1WAlJR-0005YQ-RE; Tue, 04 Feb 2014 19:05:37 +0000
Received: by laptop (Postfix, from userid 1000)
        id 08C7010872661; Tue,  4 Feb 2014 20:05:36 +0100 (CET)
Date:   Tue, 4 Feb 2014 20:05:35 +0100
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
Message-ID: <20140204190535.GC5002@laptop.programming.kicks-ass.net>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
 <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39211
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

On Tue, Feb 04, 2014 at 10:58:40AM -0800, Linus Torvalds wrote:
> On Tue, Feb 4, 2014 at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Still doesn't make sense, because if we need the first sync to stop
> > writes from being re-ordered with the ll-sc, we also need the second
> > sync to avoid the same.
> 
> Presumably octeon doesn't do speculative writes, only *buffered* writes.

Speculative writes are bad.. :-)

> So writes move down, not up.

Right, but the ll-sc store might move down over a later store. Say
because the ll-sc needs to first get exclusive ownership of the
cacheline where the later store would be to an already owned line.
