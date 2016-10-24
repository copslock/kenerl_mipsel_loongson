Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 17:51:31 +0200 (CEST)
Received: from imap.thunk.org ([74.207.234.97]:44896 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992178AbcJXPvYfsTFA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 17:51:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=9OWu3/PGLwJo0gZtjJpIV6oIk8/yzuOnoQhivFo/mhU=;
        b=D/mu6pBTvqFb48Iu9jnwko6+VDKlHp0w83SnbWIQbn71oAVQCCMYRbOjhT5uDtekY7TWvCjnGvMVgdJ4YVaEZi+D2PH7II4+0y7rL9EJTvtMd8pYs8hsy5uUSEBj39/gegoC6LqvDQcHTJVyqAShcqIfHMnLoUJox7aUx1EMy0E=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1byhWs-0005sT-EP; Mon, 24 Oct 2016 15:51:14 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 09D99C00FDD; Mon, 24 Oct 2016 11:51:13 -0400 (EDT)
Date:   Mon, 24 Oct 2016 11:51:12 -0400
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
Message-ID: <20161024155112.ixdfi3ucs7sg2zgh@thunk.org>
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
 <20161024142037.rrslfxtimj44s5t6@thunk.org>
 <8592fa0c-e80a-77e2-fc44-4017f0988c8c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8592fa0c-e80a-77e2-fc44-4017f0988c8c@users.sourceforge.net>
User-Agent: NeoMutt/20160916 (1.7.0)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@thunk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55560
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

On Mon, Oct 24, 2016 at 04:53:32PM +0200, SF Markus Elfring wrote:
> >>> since reading from /proc isn't done in a tight loop, and even if it were,
> >>> the use of vsprintf is the tiniest part of the overhead.
> >>
> >> Thanks for your software development opinion.
> > 
> > It's a lot more than just an opinion.  I challenge you to demonstrate
> > how much savings it would take.  Try learning how to use another tool
> > --- say, perf.  Measure how many clock cycles it takes to read from a
> > proc file that uses seq_printf().  Then measure how many clock cycles
> > it takes to read from a proc file that uses seq_puts().  Try doing the
> > experiment 3-5 times each way, to see if the difference is within
> > measurement error, and then figure out what percentage of the total
> > CPU time you have saved.
> 
> Are there any more software developers interested in such system
> performance analyses?

Sure, of course.  This is why serious professionals take a huge amount
of time doing benchmarking, and making sure that the benchmarks are
reproducible, and accurately measure something that reflects real
world usage.  This can often take as much time or more time than the
actual optimization in some cases.

> There are also some constraints around change resistance involved,
> aren't there?

To quote from the great Don Knuth:

    Programmers waste enormous amounts of time thinking about, or
    worrying about, the speed of noncritical parts of their programs,
    and these attempts at efficiency actually have a strong negative
    impact when debugging and maintenance are considered. We should
    forget about small efficiencies, say about 97% of the time:
    premature optimization is the root of all evil. Yet we should not
    pass up our opportunities in that critical 3%.

An experienced developer would be able to very easily spot that trying
to optimize seq_printf() versus seq_puts() is barely going to be
measurable.  It's the sort of thing that a developer might fix while
making other, more useful changes to a source file.  But there are
costs associated with processing a patch, in terms of developer time
and attention, and those are externalities.  It's for the same reason
that whitespace only or comment-only patches are controversial.  There
is always the suspicion that there are people doing this because they
hope to win some patch counting game, and that they don't care about
the costs they might be introducing to the rest of the system.  And
when the patches cause bugs, then it goes from outright marginal value
to negative value.

> > So trying to send more useful patches might be more helpful
> > if your goal is to try to get gainful employment.
> 
> Financial incentives would be also nice as you seem to indicate here.

Well, please note that having a reputation of someone who insists on
sending mostly junk patches (and like junk food, they may have some
nutritive value; but that doesn't change the effect that the net
benefit to person consuming them is marginal or negative), tends to
give you a bad reputation, and may in fact be a hinderance towards
your being able to attain "financial incentives".

If that is in fact your goal, I would gently suggest that you spend
more time improving your skills, and learning more about higher-value
ways you could contribute to the kernel, instead of spamming the
kernel list with lots of low value patches.  In the future if you are
adding higher value improvements, and you want to do various cleanups,
such as fixing up seq_printf -> seq_puts changes, sure.  But to the
extent that dirties the history so it's harder to find who introduced
a problem using tools such as "git blame", low-value cleanup patches
do have some costs, so it's not enough to say, "but it improves the
CPU time used by 0.000001%!"

Cheers,

						- Ted
