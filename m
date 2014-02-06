Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2014 12:45:37 +0100 (CET)
Received: from merlin.infradead.org ([205.233.59.134]:36847 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822997AbaBFLpdBP0E2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Feb 2014 12:45:33 +0100
Received: from dhcp-077-248-225-117.chello.nl ([77.248.225.117] helo=twins)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1WBNOT-0004TV-BU; Thu, 06 Feb 2014 11:45:21 +0000
Received: by twins (Postfix, from userid 1000)
        id B64E98278359; Thu,  6 Feb 2014 12:45:17 +0100 (CET)
Date:   Thu, 6 Feb 2014 12:45:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mips octeon memory model questions
Message-ID: <20140206114517.GI4941@twins.programming.kicks-ass.net>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
 <52F144C3.1080705@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52F144C3.1080705@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39224
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

On Tue, Feb 04, 2014 at 11:51:31AM -0800, David Daney wrote:
> On OCTEON, SC implies a SYNC operation for the target memory location. So
> the "SC b" is ordered before any writes that come after the SC.

Ah, that makes it all come together. I was thrown by octeon initially
having WEAK_REORDERING_BEYOND_LLSC set and thus thinking there were no
implied barriers.

Thanks David.
