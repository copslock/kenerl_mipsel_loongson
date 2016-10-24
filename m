Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 16:54:10 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:59717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992202AbcJXOyB5JsiX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 16:54:01 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M4qcP-1cr60237aX-00z0GH; Mon, 24 Oct 2016 16:53:35
 +0200
Subject: Re: MIPS/kernel/r2-to-r6-emul: Use seq_puts() in mipsr2_stats_show()
To:     Theodore Ts'o <tytso@mit.edu>, linux-mips@linux-mips.org
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
 <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
 <20161024131311.ttwr2bblphg6vd2b@thunk.org>
 <e7ac4cba-bce1-edf5-a537-4c06a357bfb3@users.sourceforge.net>
 <20161024142037.rrslfxtimj44s5t6@thunk.org>
Cc:     Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8592fa0c-e80a-77e2-fc44-4017f0988c8c@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 16:53:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161024142037.rrslfxtimj44s5t6@thunk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LBrcz7TqRciu/vSr0+fQxG6FSD+VS1Lyz87N/yARV560Q0BzZXd
 wVOCfAwtK+Ue0l4Xk5a93yMJ5hk1ZMvVQiueptUtsFS15D8e6GDgrRSpfp7qqr0PjLSfAKo
 d6UiI5DFxLplDSPwJu4Gbu4xZeUzZ5D1ls0cGLhr6UDOFSSE70vCzm9MZoZQ5JJ5/DcoFA7
 4rXqtwdLsRLywczy1WvqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JSAhTClomQg=:kjKGJQM6XYyMCAql0NUBAI
 OmDpWaMr+/17bfHqFr0xjNWl6/LUp1vUTSb0kWSNw5Je74xctw94A9hGLDixdY/Nw3l9VG8eg
 sBCGOZxnvqL5EV0bcOQiBROI41gJDmV0CHpUXNMUSzxLIIpw1ptRhGtbh/iOsCUQvYi5Grstw
 2hKNzUS25q+YM39VlVsumrAYiZ3ggFQvPsvNpEmS16RXvSkHnf3W8PDJBS3K/5hXUF6JHCvpD
 WJQeAfbIIFzCZCevQUtXz9vChEVZZsTJ6V+zKoUFwVGnSe0MDh+B5YfZ3/nzbytmBD6WqVXYp
 dIvbLGIo07sM3GppctftEXpZwXaSTRur0K5duqq+zGgleGYGlZmlzbY+4T978MGcWZb7nvjxc
 kHsLXTgAYVSlaxH9wuOeIsdOe5bfadcZbgb9BmL1qMLTHJLcLsCwuJ3UfTPQ1JI1inyX0Mfqg
 tKV7mTfD2XEjLP664uP4Sy1MpJYbXUwW/VllaL7OdJfxssH+5XVOMcUr51H2ijvhkuvxMF6W+
 dBAIXI4wiTCNhYLRm2ZTdjtFpf/GpUh0X7PcSRK3Wlvc7zTA3TsXX/XSp4JZMqsz5+8/AiEIh
 tGqVeRZly72gIafieiSd6/azxtEyjZXDH3MX/jv1B6a1YqmV3NDM0o0neQqOhdQo4hxrqCcT1
 XhU8kgZmCzA+WJ1ijHpGXgAl0T4TBR3r/Rea0Pc/QkZdmW6V7XTGPd85BXJT5spD65VNfAE6z
 P0dPZTlgqcNr5dCsFT+3RM22Loo+djjpikx/9BB5XvfaUzNbiOK3xGnFFgx0m49sp9u43scsD
 C3aBIhn
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>> I am curious if a second approach will become acceptable in the near future.
> 
> I don't know what you were asking.

I am trying to clarify the suggested software evolution again.


> I was merely point out that the wording was factually incorrect
> in all of the patches,

Thanks for this information.


> and I didn't feel like replying five times to point out the same mistake.

This is fine.


>>> since reading from /proc isn't done in a tight loop, and even if it were,
>>> the use of vsprintf is the tiniest part of the overhead.
>>
>> Thanks for your software development opinion.
> 
> It's a lot more than just an opinion.  I challenge you to demonstrate
> how much savings it would take.  Try learning how to use another tool
> --- say, perf.  Measure how many clock cycles it takes to read from a
> proc file that uses seq_printf().  Then measure how many clock cycles
> it takes to read from a proc file that uses seq_puts().  Try doing the
> experiment 3-5 times each way, to see if the difference is within
> measurement error, and then figure out what percentage of the total
> CPU time you have saved.

Are there any more software developers interested in such system
performance analyses?


> If this sort of thing appeals to you, you might want to consider a
> more productive line of work.  For example, you could do scalability
> measurements.  Run various benchmarks with lockdep enabled, and
> measure the average and max hold time on various locks.  Now see if
> you can reduce the max hold time on those locks.  You may find that
> you can improve performance for real work loads by orders of magnitude
> more than you can by sending the sorts of patches you've sent up until now.

Thanks for your hints around other software development areas.


> You'd also development more marketable kernel skills, if that has been
> your goal by spamming the list with hundreds and thousands of mostly
> pointless patches.

You might categorise my update suggestions with a low value so far.


> Note that if a hiring manager were to talk to developers and get
> their opinion of the sorts of patches you have been sending, trust me,
> it would _not_ be positive.

There are also some constraints around change resistance involved,
aren't there?

* Do my suggestions show small improvements for Linux source files?

* If you find some of them so awful, why should I attempt to improve
  any commit messages in another patch series then?


> So trying to send more useful patches might be more helpful
> if your goal is to try to get gainful employment.

Financial incentives would be also nice as you seem to indicate here.

Regards,
Markus
