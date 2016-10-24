Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 20:11:08 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:59718 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993009AbcJXSLBqXxAr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 20:11:01 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M8iei-1c4G1T1Ajc-00CDfG; Mon, 24 Oct 2016 20:10:31
 +0200
Subject: Re: Further software improvements around Linux sequence API?
To:     Theodore Ts'o <tytso@mit.edu>, linux-mips@linux-mips.org
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
 <4126c272-cdf6-677a-fe98-74e8034078d8@users.sourceforge.net>
 <20161024131311.ttwr2bblphg6vd2b@thunk.org>
 <e7ac4cba-bce1-edf5-a537-4c06a357bfb3@users.sourceforge.net>
 <20161024142037.rrslfxtimj44s5t6@thunk.org>
 <8592fa0c-e80a-77e2-fc44-4017f0988c8c@users.sourceforge.net>
 <20161024155112.ixdfi3ucs7sg2zgh@thunk.org>
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
Message-ID: <47c7084e-21d8-4564-c237-84324dae17ab@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 20:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161024155112.ixdfi3ucs7sg2zgh@thunk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qBVrsc073dDpAM5xRK1psxugtXa2rVUWz2S4/wsCA19TPQwY6cj
 cfKlXpEaP1YMDiuAW9eygV0vibKToF6prw4bj8P0T91UpHn4spqQAYSEIOLBC2Jp+V7/5wU
 J1iiXJcC+RLdl9UFdui8jmWbWN37ouDOj1TwW1QN53oz96dHc3jDNXJx1XUhAZKzXdj+/ME
 wOfpMy0mJT8HnrFvrz3Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6kocRelJz5g=:taJPO7dFkwrxoRSrGpB2aX
 0Bf9hnhxKMPgwgaKXW2Om36Mcb86ZeByI6JhQwD8Q/EPl/NMQwu38M4bMiE3Z9W22W+D/I1ir
 RjA4jsm7J3yHVgqPjOX9a5GudPzsUHzYKz+vLeaImTx8/FsD9zwKwzkWy6DEhdAp9GLWQhKFV
 WhDmCD5EXhCTaIuTu6rvGavB8n95wy+l41r3fFcaqIZkK+UyoCGq4s4K91xxgYf6q4C541On+
 Z0WhgzncQ8hoqy1RQBRHVTzG41OlYPS9z/Up6JEHdRm0SBNzFzipR+H1cwdkI4vd2ulAOZ/1O
 PeuC3XeXeTH5qhTBsSc3AiQ1g1CEesqHZB9rfJhFEdhd7jHuIPjNgpm0pJF66i/eaRyz8doCf
 N9Sycmg8Xg5PXSqYkJVc5qGzcUEg7ER1reosOwbf65aGagy3Yj5J/3NAzlNWEpm3S++pq8jrm
 sp09LP/HQdiOdn4LqgOrLJY4J2FCgZnxxytwTtGhpmyn9N7edSkpY8QTvUyi5D4w4MukJZ8K0
 XmoM4zGEioyXgbNJUBrLLyz/SZKR+ygTL/nAHBISm4pRiU3iLQm8aQAafMXHYwU4jQ5vEqrOA
 5Z1Kzt+qkX4boHv8pANIuCdUIkX9Ct35F7M7N4qpv9+fYNsZ7nc7RDS8XlLHKjYqaljpwUGYY
 NpqLbt+gG0AdGqWHEXnOHEnB4VpO5ghoO4VlRYz2dSZjLAc/nm08uEuLIpG3TjuJdRSi/rviX
 Yqy2l6AEKvstHMgJxbuEZXT/1zMNEZKcS6Tgf1VIqfgbHdFAPB4OhVsxb1ggaDzmYnC7NBILV
 k/cfJQU
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55562
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

> An experienced developer would be able to very easily spot that trying
> to optimize seq_printf() versus seq_puts() is barely going to be measurable.

Would you like to offer any incentives to use a more appropriate function
from this Linux programming interface for sequences?


> It's the sort of thing that a developer might fix while
> making other, more useful changes to a source file.

I get doubts when you expect that change possibilities with a higher
priority should and will almost always picked up before update candidates
with a lower impact.


> Well, please note that having a reputation of someone who insists on
> sending mostly junk patches (and like junk food, they may have some
> nutritive value; but that doesn't change the effect that the net
> benefit to person consuming them is marginal or negative), tends to
> give you a bad reputation, and may in fact be a hinderance towards
> your being able to attain "financial incentives".

I can not offer the “shiny gold nugget” or “pure diamond” so far directly
which is often preferred.


> If that is in fact your goal, I would gently suggest that you spend
> more time improving your skills, and learning more about higher-value
> ways you could contribute to the kernel, instead of spamming the
> kernel list with lots of low value patches.

* I could extend my source code search patterns in principle.
  How many developers and software reviewers struggle with results
  from existing code analysis tools?

* Will your interest occasionally grow for collateral software evolution?


> In the future if you are adding higher value improvements, and you want
> to do various cleanups, such as fixing up seq_printf -> seq_puts changes, sure.

Is this kind of feedback a contradiction at the moment when you seem to give
the impression that my software development reputation is so damaged in the
“junk food” sense that I could hardly achieve the software change mixture
which you would prefer?

Regards,
Markus
