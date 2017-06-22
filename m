Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2017 21:32:44 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:47297 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991672AbdFVTchYI5Vk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jun 2017 21:32:37 +0200
Received: from [192.168.10.172] (p57978943.dip0.t-ipconnect.de [87.151.137.67])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 4210B1001DD;
        Thu, 22 Jun 2017 21:32:34 +0200 (CEST)
Subject: Re: clock_gettime() may return timestamps out of order
To:     Rene Nielsen <rene.nielsen@microsemi.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1bd4bad1-5574-7b76-0cd7-d0334c08667f@hauke-m.de>
Date:   Thu, 22 Jun 2017 21:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 06/21/2017 10:14 AM, Rene Nielsen wrote:
> Hi folks,
> 
> Let me go straight into the problem:
> We have a multi-threaded application that runs on a MIPS 24KEc using glibc v.
> 2.24 under kernel v. 4.9.29 both compiled with gcc v. 6.3.0.
> Our 24KEc has a 4-way 32 KBytes dcache (and similar icache), so it's prone to cache
> aliasing (don't know if this matters...).
> 
> We want to be able to do stack backtraces from a signal handler in case our
> application makes a glibc call that results in an assert(). The stack
> backtracing is made within the signal handler with calls to _Unwind_Backtrace().
> With the default set of glibc compiler flags, we can't trace through signal
> handlers. Not so long ago, we used uclibc rather than glibc, and experienced the
> same problem, but we got it to work by enabling the
> '-fasynchronous-unwind-tables' gcc flag during compilation of uclibc.
> Using the same flag during compilation of glibc causes unexpected runtime
> problems:
> 
> Many of the threads in our application call clock_gettime(CLOCK_MONOTONIC) many
> times per second, so we greatly appreciate the existence and utilization of the
> VDSO.
> 
> Occassionally, however, clock_gettime(CLOCK_MONOTONIC) returns timestamps out of
> order on the same thread. It's not that the returned timestamps seem wrong (they
> are mostly off by some hundred microseconds), but they simply appear out of
> order.
> 
> Since glibc utilizes VDSO (and uclibc doesn't), my guess is that there's
> something wrong in the interface between the two, but I can't figure out what.
> Other glibc calls seem OK (I don't know whether there's a problem with the other
> VDSO function, gettimeofday(), though). If not compiled with the infamous flag,
> we don't see this problem.
> 
> I have tried with a single-threaded test-app, but haven't been able to
> reproduce.
> 
> Any help is highly appreciated. Don't hesitate to asking questions, if needed.
> 
> Thank you very much in advance,
> Best regards,
> René Nielsen


Hi Rene

I had a problem with the clock_gettime() call over VDSO on a MIPS BE
34Kc CPU, see this:
https://www.linux-mips.org/archives/linux-mips/2016-01/msg00727.html
It was sometimes off by 1 second.

It is gone in the current version of LEDE (former OpenWrt), but when I
used git bisect to find the place where it was fixed, I found a place
which has nothing to do with MIPS internal or libc stuff.

Makeing some pages uncached or flushing them help, but caused
performance problems, I have never found the root cause of the problem.

Hauke
