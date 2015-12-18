Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 20:58:26 +0100 (CET)
Received: from mail.efficios.com ([78.47.125.74]:33370 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007617AbbLRT6YEVQEh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Dec 2015 20:58:24 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 97053340501;
        Fri, 18 Dec 2015 19:58:20 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1FLlCqIJzbis; Fri, 18 Dec 2015 19:58:16 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 924E23403A9;
        Fri, 18 Dec 2015 19:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lRC4yLtqywQ1; Fri, 18 Dec 2015 19:58:16 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
        by mail.efficios.com (Postfix) with ESMTP id 6AD4E3401F1;
        Fri, 18 Dec 2015 19:58:16 +0000 (UTC)
Date:   Fri, 18 Dec 2015 19:58:16 +0000 (UTC)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Helge Deller <deller@gmx.de>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jon Bernard <jbernard@debian.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <1817225945.264082.1450468696180.JavaMail.zimbra@efficios.com>
In-Reply-To: <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com> <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com> <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60>
Subject: Re: Aw: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex
 should work-around futex signal-restart kernel bug
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.47.125.74]
X-Mailer: Zimbra 8.6.0_GA_1178 (ZimbraWebClient - FF42 (Linux)/8.6.0_GA_1178)
Thread-Topic: compat_futex should work-around futex signal-restart kernel bug
Thread-Index: XNmi9l7qbwIrR2lOqnrjiL9fDDZpLA==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@efficios.com
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

----- On Dec 17, 2015, at 11:22 AM, Helge Deller deller@gmx.de wrote:

> Hello Mathieu,
> 
>> > When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
>> > Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
>> > FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
>> > signal handler. This spurious ENOSYS behavior causes hangs in liburcu
>> > 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
>> > same behavior. This might affect earlier kernels.
>> > 
>> > This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
>> > nevertheless, we should try to handle this kernel bug more gracefully
>> > than a user-space hang due to unexpected spurious ENOSYS return value.
>> 
>> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
>> Linux kernel upstream fix commit is:
>> e967ef02 "MIPS: Fix restart of indirect syscalls"
> 
> But that patch fixes mips only.

Indeed, I do not expect this commit to have any effect on parisc.

> 
>> I've created a small test program that could also be used on parisc
>> to check if it suffers from the same issue (see attached).
>> 
>> On bogus mips kernels, we see the following output:
>> [OK] Test program with pid: 5748 SIGUSR1 handler
>> [FAIL] futex returns -1, Function not implemented
> 
> I tested it on a recent 4.2 kernel on parisc.
> It fails as you describe:
> 
> Testing futex sigrestart. Stop with CTRL-c.
> [OK] Test program with pid: 1361 SIGUSR1 handler
> [OK] Test program with pid: 1361 SIGUSR1 handler
> [FAIL] futex returns -1, Function not implemented
> [OK] Test program with pid: 1361 SIGUSR1 handler
> [FAIL] futex returns -1, Function not implemented
> 
> strace gives:
> [pid  1329] futex(0x1210c, FUTEX_WAIT, -1, NULL <unfinished ...>
> [pid  1328] nanosleep({1, 0},  <unfinished ...>
> [pid  1329] <... futex resumed> )       = ? ERESTARTSYS (To be restarted if
> SA_RESTART is set)
> [pid  1329] write(2, "[FAIL] futex returns -1, Functio"..., 50[FAIL] futex
> returns -1, Function not implemented)

Looks like parisc has an issue very similar to the one that
has been fixed on MIPS by e967ef02 "MIPS: Fix restart of indirect syscalls".

> 
> 
>> > Therefore, fallback on the "async-safe" version of compat_futex in those
>> > situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
>> > the nice property of being OK to use concurrently with other FUTEX_WAKE
>> > and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
>> > 
>> > We suspect that parisc might be affected by a similar issue (Debian
>> > build bots reported a similar hang on both mips and parisc), but we do
>> > not have access to the hardware required to test this hypothesis.
> 
> If you want access to a machine, let me know.
> I'll try the patch below as well..

This would be very useful indeed, just to make sure our approach to
futex fallback in liburcu works fine on parisc.

I'm no parisc assembly expert though, but I suspect the issue
would be quite similar to the one already fixed on MIPS. The
existing fix for MIPS would be a good starting point to see if
something similar is missing on parisc.

When time allows, we should consider cleaning up my test case for
restart of indirect system calls and add it to kselftest. It's
the second architecture that has the same defect, which means this
behavior is seldom tested.

Thanks,

Mathieu

> 
>> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > CC: Michael Jeanson <mjeanson@efficios.com>
>> > CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > CC: Ralf Baechle <ralf@linux-mips.org>
>> > CC: linux-mips@linux-mips.org
>> > CC: linux-kernel@vger.kernel.org
>> > CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
>> > CC: Helge Deller <deller@gmx.de>
>> > CC: linux-parisc@vger.kernel.org
>> > ---
>> > compat_futex.c |  2 ++
>> > urcu/futex.h   | 12 +++++++++++-
>> > 2 files changed, 13 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/compat_futex.c b/compat_futex.c
>> > index b7f78f0..9e918fe 100644
>> > --- a/compat_futex.c
>> > +++ b/compat_futex.c
>> > @@ -111,6 +111,8 @@ end:
>> >  * _ASYNC SIGNAL-SAFE_.
>> >  * For now, timeout, uaddr2 and val3 are unused.
>> >  * Waiter will busy-loop trying to read the condition.
>> > + * It is OK to use compat_futex_async() on a futex address on which
>> > + * futex() WAKE operations are also performed.
>> >  */
>> > 
>> > int compat_futex_async(int32_t *uaddr, int op, int32_t val,
>> > diff --git a/urcu/futex.h b/urcu/futex.h
>> > index 4d16cfa..a17eda8 100644
>> > --- a/urcu/futex.h
>> > +++ b/urcu/futex.h
>> > @@ -73,7 +73,17 @@ static inline int futex_noasync(int32_t *uaddr, int op,
>> > int32_t val,
>> > 
>> > 	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
>> > 	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
>> > -		return compat_futex_noasync(uaddr, op, val, timeout,
>> > +		/*
>> > +		 * The fallback on ENOSYS is the async-safe version of
>> > +		 * the compat futex implementation, because the
>> > +		 * async-safe compat implementation allows being used
>> > +		 * concurrently with calls to futex(). Indeed, sys_futex
>> > +		 * FUTEX_WAIT, on some architectures (e.g. mips), within
>> > +		 * a given process, spuriously return ENOSYS due to
>> > +		 * signal restart bugs on some kernel versions (e.g.
>> > +		 * Linux kernel 3.18 and possibly earlier).
>> > +		 */
>> > +		return compat_futex_async(uaddr, op, val, timeout,
>> > 				uaddr2, val3);
>> > 	}
> > > 	return ret;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
