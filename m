Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 21:22:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35996 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27032157AbcEWTWYXIoa9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 May 2016 21:22:24 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4NJML7W004378;
        Mon, 23 May 2016 21:22:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4NJMK1N004377;
        Mon, 23 May 2016 21:22:20 +0200
Date:   Mon, 23 May 2016 21:22:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160523192219.GB24125@linux-mips.org>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org>
 <5743529A.4070506@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5743529A.4070506@gentoo.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, May 23, 2016 at 02:57:30PM -0400, Joshua Kinard wrote:

> NAK, this issue looks completely different to IP30/IP27.  In this case, it
> looks like the hardware is detecting the case where multiple TLB entries match
> and it's killing the machine to avoid hardware damage.  I don't want to know
> how the SGI systems handle this scenario (does the R10000 do a TLB shutdown??).

The R10000 detects if duplicate entries when writing to the TLB and
invalidates the previous entry.  That is, there will never be duplicate
entries in the TLB and of course no TLB shutdown.

That's the theory.  I'm wondering how well that is going to work if
the entries are having a different page size.

And Aaro doesn't always get machine checks so it's not like always a
duplicate entry is written.

> On IP30, using THP usually results in instruction bus errors (IBE), after a set
> time, depending on the machine's configuration (<2GB RAM, virtually instant on
> userland init; >2GB RAM, might survive for a few minutes, even getting all the
> way to runlevel 3 randomly).
> 
> IP27 was somewhat similar to IP30, in that THP usually results in IBEs after a
> few seconds of hitting userland bringup (bash is pretty quick at triggering an
> IBE), but I haven't tried experimenting with varying the amount of RAM in that
> machine, due to the fragility of pulling the nodeboards out constantly.  I also
> haven't tried THP since refactoring/rewriting the IP27 code back in Feb to see
> if I magically fixed it...

  Ralf
