Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 19:42:01 +0100 (CET)
Received: from merlin.infradead.org ([205.233.59.134]:44560 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825631AbaBDSl6N2mHU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Feb 2014 19:41:58 +0100
Received: from dhcp-077-248-225-117.chello.nl ([77.248.225.117] helo=laptop)
        by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1WAkwS-0004Yy-I0; Tue, 04 Feb 2014 18:41:52 +0000
Received: by laptop (Postfix, from userid 1000)
        id A7CA110872145; Tue,  4 Feb 2014 19:41:50 +0100 (CET)
Date:   Tue, 4 Feb 2014 19:41:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mips octeon memory model questions
Message-ID: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39209
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

Hi all,

I have a number of questions in regards to commit 6b07d38aaa520ce.

Given that the octeon doesn't reorder reads; the following:

"      sync
       ll ...
       .
       .
       .
       sc ...
       .
       .
       sync

  The second SYNC was redundant, but harmless.  "

Still doesn't make sense, because if we need the first sync to stop
writes from being re-ordered with the ll-sc, we also need the second
sync to avoid the same.

Suppose:
   STORE a
   sync
   LL-SC b
   (not a sync)
   STORE c

What avoids this becoming visible as:

  a
  c
  b

?

Then there is:

"       syncw;syncw
        ll
        .
        .
        .
        sc
        .
        .

    Has identical semantics to the first sequence, but is much faster.
    The SYNCW orders the writes, and the SC will not complete successfully
    until the write is committed to the coherent memory system.  So at the
    end all preceeding writes have been committed.  Since Octeon does not
    do speculative reads, this functions as a full barrier."

Read Documentation/memory-barrier.txt:TRANSITIVITY, the above doesn't
sound like syncw is actually multi-copy atomic, and therefore doesn't
provide transitivity, and therefore is not a valid sequence for
operations that are supposed to imply a full memory-barrier.

Please as to explain.
