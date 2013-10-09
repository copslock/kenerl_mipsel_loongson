Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 10:17:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42787 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3JIIRKnqPsM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 10:17:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r998H93h005388;
        Wed, 9 Oct 2013 10:17:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r998H7HY005387;
        Wed, 9 Oct 2013 10:17:07 +0200
Date:   Wed, 9 Oct 2013 10:17:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-mips@linux-mips.org, linux-media@vger.kernel.org
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
Message-ID: <20131009081707.GL1615@linux-mips.org>
References: <m3eh82a1yo.fsf@t19.piap.pl>
 <m361t9a31i.fsf@t19.piap.pl>
 <20131007142429.GG3098@linux-mips.org>
 <m3li24891u.fsf@t19.piap.pl>
 <20131008120727.GH1615@linux-mips.org>
 <m38uy37x5r.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m38uy37x5r.fsf@t19.piap.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38281
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

On Wed, Oct 09, 2013 at 08:53:20AM +0200, Krzysztof Hałasa wrote:

> > 16K is a silver bullet solution to all cache aliasing problems.  So if
> > your issue persists with 16K page size, it's not a cache aliasing issue.
> > Aside there are generally performance gains from the bigger page size.
> 
> I wonder why isn't the issue present in other cases. Perhaps remapping
> of a userspace address and accessing it with kseg0 isn't a frequent
> operation.
> 
> Shouldn't we change the default page size (on affected CPUs) to 16 KB
> then? Alternatively, we could flush/invalidate the cache when needed -
> is it a viable option?

The kernel is supposed to perform the necessary cache flushing, so any
remaining aliasing issue would be considered a bug.  But the code is
performance sensitive, some of the problem cases are twisted and complex
so bugs and unsolved corner cases show up every now and then.

The historic default is 4K page size - on some processors such as the
venerable R3000 it's also the only page size available.  Some application
code wants to know the page size and has wisely hardcoded 4K.  Also
a "fix" to binutils many years ago reduced the alignment of generated
binaries so they'd not run on a kernel with larger page size.  The
kernel configuration defaults are chosen to just work out of the box,
and 4K page size is the safest choice.

Anyway, binutils got "unfixed" again years ago so chances are 16K
will just work.

Does it work for you, even solve your problem?

  Ralf
