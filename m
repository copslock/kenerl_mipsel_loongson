Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 16:20:59 +0200 (CEST)
Received: from imap.thunk.org ([74.207.234.97]:44466 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992161AbcJXOUuLH9yf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 16:20:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=WjURebBV0nJ7oAjklRF4XLr3aecMCeKerfa0TEZQ5cE=;
        b=UNkElq2x/gCD7Nt8sWqwXOlrvAh1MtMxFfMu3x1aR0RxyEi/JIYso4a6nsWcX99De7gmaKKAM8D1RrMFPXnv9kG/amFxW2ex6z1t3667vNGJsKH5LSpM4SSMhBIjs1uIwewFKziLoP6IJ1TdHr2bQLFAYNm7gAIjgS6N2YzJJy8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1byg7C-0005E6-UO; Mon, 24 Oct 2016 14:20:38 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1E720C005C7; Mon, 24 Oct 2016 10:20:38 -0400 (EDT)
Date:   Mon, 24 Oct 2016 10:20:38 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     linux-mips@linux-mips.org,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf =?iso-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: MIPS/kernel/r2-to-r6-emul: Use seq_puts() in mipsr2_stats_show()
Message-ID: <20161024142037.rrslfxtimj44s5t6@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf =?iso-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
 <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
 <20161024131311.ttwr2bblphg6vd2b@thunk.org>
 <e7ac4cba-bce1-edf5-a537-4c06a357bfb3@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ac4cba-bce1-edf5-a537-4c06a357bfb3@users.sourceforge.net>
User-Agent: NeoMutt/20160916 (1.7.0)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@thunk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
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

On Mon, Oct 24, 2016 at 04:02:49PM +0200, SF Markus Elfring wrote:
> > You should fix this in all the patches.
> I am curious if a second approach will become acceptable in the near
> future.

I don't know what you were asking.  I was merely point out that the
> wording was factually incorrect in all of the patches, and I didn't
> feel like replying five times to point out the same mistake.

> > since reading from /proc isn't done in a tight loop, and even if it were,
> > the use of vsprintf is the tiniest part of the overhead.
> 
> Thanks for your software development opinion.

It's a lot more than just an opinion.  I challenge you to demonstrate
how much savings it would take.  Try learning how to use another tool
--- say, perf.  Measure how many clock cycles it takes to read from a
proc file that uses seq_printf().  Then measure how many clock cycles
it takes to read from a proc file that uses seq_puts().  Try doing the
experiment 3-5 times each way, to see if the difference is within
measurement error, and then figure out what percentage of the total
CPU time you have saved.

If this sort of thing appeals to you, you might want to consider a
more productive line of work.  For example, you could do scalability
measurements.  Run various benchmarks with lockdep enabled, and
measure the average and max hold time on various locks.  Now see if
you can reduce the max hold time on those locks.  You may find that
you can improve performance for real work loads by orders of magnitude
more than you can by sending the sorts of patches you've sent up until
now.

You'd also development more marketable kernel skills, if that has been
your goal by spamming the list with hundreds and thousands of mostly
pointless patches.  Note that if a hiring manager were to talk to
developers and get their opinion of the sorts of patches you have been
sending, trust me, it would _not_ be positive.  So trying to send more
useful patches might be more helpful if your goal is to try to get
gainful employment.

Cheers,

						- Ted
