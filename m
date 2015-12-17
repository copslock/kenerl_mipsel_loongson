Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 17:23:15 +0100 (CET)
Received: from mout.gmx.net ([212.227.17.20]:63615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013719AbbLQQXL7BAmr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Dec 2015 17:23:11 +0100
Received: from [155.56.68.219] by 3capp-gmx-bs60.server.lan (via HTTP); Thu,
 17 Dec 2015 17:22:50 +0100
MIME-Version: 1.0
Message-ID: <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60>
From:   "Helge Deller" <deller@gmx.de>
To:     "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Jon Bernard" <jbernard@debian.org>,
        "Michael Jeanson" <mjeanson@efficios.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        "Ed Swierk" <eswierk@skyportsystems.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Aw: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should
 work-around futex signal-restart kernel bug
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Dec 2015 17:22:50 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>,
 <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:S4GvqvUzGKUVaj6GoSrZC1ke0+mBTKijM7/5wWiXv2E
 SSUVRF3K6wQFaxdbNLHZnFZ1m29kpubSD5hcsz2rcervAwcuxT
 AxciIwsC2Erc4DV2wFPyKuHk4WBx0o3pSJ2CnY7v5Wi9DKK6Au
 fn0jw1FPxKj9PmY093DtJ375rDfHpNDCWzjgEjncMFKIv0hUOY
 EiksuPJk5Oh4TBFVcUaxAwFE2QlFh1djaPw0lAusB+LS2+j0JD
 QXBiM4yctg1YegOATi3fvXwh3I9Fx7zzkqQet6zWEigm+AznNX kA/fm8=
X-UI-Out-Filterresults: notjunk:1;V01:K0:PZnGyK9QlsI=:oaiCQQ1lTj/aYqDsdWah+D
 aEEq5RmQGnN39tYeUQdFD/YeXbiAJCx3DXgKFxjnR3Ebw0pXZ36IniYNZgWRPQQJJ7Cg/gbPL
 hsHk6fGW8euv9k+OfJ/JI4X/Haf4TN3MNsHQPbpfAAIl+EWZTjWz1lGn7W3VOSqpk7FMG/zWh
 p4d2+b0ePhOIn/FwoMnFySqf158ZvDcL9JgtXL4IXhEp4iMmGs8Frz+bnhC7XUSSzINmVUoCR
 s4XqymQl4/T5J3Yc704Po73pGtnz06FbyKQpAv9qGcXuu3mIzK26Fe4vlRAIhGHSvnefhJ3cr
 mek+WpAw7tn9brt4iB1VgN62+ZKEtrDZ0j60XUrKDaObC6wqcVYLnmjIIkWuol6Q67I+Ok1gE
 ZT0b1A4hmpgh0gS7zqeTsPSjTgzbC5Fnc7ayFMdSDYJwNtTnH8I4Lq3qhlgto/WQcBEoA0OtT
 81cneGnt4A==
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deller@gmx.de
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

Hello Mathieu,

> > When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
> > Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
> > FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
> > signal handler. This spurious ENOSYS behavior causes hangs in liburcu
> > 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
> > same behavior. This might affect earlier kernels.
> > 
> > This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
> > nevertheless, we should try to handle this kernel bug more gracefully
> > than a user-space hang due to unexpected spurious ENOSYS return value.
> 
> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
> Linux kernel upstream fix commit is:
> e967ef02 "MIPS: Fix restart of indirect syscalls"

But that patch fixes mips only.
 
> I've created a small test program that could also be used on parisc
> to check if it suffers from the same issue (see attached).
> 
> On bogus mips kernels, we see the following output:
> [OK] Test program with pid: 5748 SIGUSR1 handler
> [FAIL] futex returns -1, Function not implemented

I tested it on a recent 4.2 kernel on parisc.
It fails as you describe:

Testing futex sigrestart. Stop with CTRL-c.
[OK] Test program with pid: 1361 SIGUSR1 handler
[OK] Test program with pid: 1361 SIGUSR1 handler
[FAIL] futex returns -1, Function not implemented
[OK] Test program with pid: 1361 SIGUSR1 handler
[FAIL] futex returns -1, Function not implemented

strace gives:
[pid  1329] futex(0x1210c, FUTEX_WAIT, -1, NULL <unfinished ...>
[pid  1328] nanosleep({1, 0},  <unfinished ...>
[pid  1329] <... futex resumed> )       = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
[pid  1329] write(2, "[FAIL] futex returns -1, Functio"..., 50[FAIL] futex returns -1, Function not implemented)


> > Therefore, fallback on the "async-safe" version of compat_futex in those
> > situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
> > the nice property of being OK to use concurrently with other FUTEX_WAKE
> > and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
> > 
> > We suspect that parisc might be affected by a similar issue (Debian
> > build bots reported a similar hang on both mips and parisc), but we do
> > not have access to the hardware required to test this hypothesis.

If you want access to a machine, let me know.
I'll try the patch below as well..

> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > CC: Michael Jeanson <mjeanson@efficios.com>
> > CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > CC: Ralf Baechle <ralf@linux-mips.org>
> > CC: linux-mips@linux-mips.org
> > CC: linux-kernel@vger.kernel.org
> > CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
> > CC: Helge Deller <deller@gmx.de>
> > CC: linux-parisc@vger.kernel.org
> > ---
> > compat_futex.c |  2 ++
> > urcu/futex.h   | 12 +++++++++++-
> > 2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/compat_futex.c b/compat_futex.c
> > index b7f78f0..9e918fe 100644
> > --- a/compat_futex.c
> > +++ b/compat_futex.c
> > @@ -111,6 +111,8 @@ end:
> >  * _ASYNC SIGNAL-SAFE_.
> >  * For now, timeout, uaddr2 and val3 are unused.
> >  * Waiter will busy-loop trying to read the condition.
> > + * It is OK to use compat_futex_async() on a futex address on which
> > + * futex() WAKE operations are also performed.
> >  */
> > 
> > int compat_futex_async(int32_t *uaddr, int op, int32_t val,
> > diff --git a/urcu/futex.h b/urcu/futex.h
> > index 4d16cfa..a17eda8 100644
> > --- a/urcu/futex.h
> > +++ b/urcu/futex.h
> > @@ -73,7 +73,17 @@ static inline int futex_noasync(int32_t *uaddr, int op,
> > int32_t val,
> > 
> > 	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
> > 	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
> > -		return compat_futex_noasync(uaddr, op, val, timeout,
> > +		/*
> > +		 * The fallback on ENOSYS is the async-safe version of
> > +		 * the compat futex implementation, because the
> > +		 * async-safe compat implementation allows being used
> > +		 * concurrently with calls to futex(). Indeed, sys_futex
> > +		 * FUTEX_WAIT, on some architectures (e.g. mips), within
> > +		 * a given process, spuriously return ENOSYS due to
> > +		 * signal restart bugs on some kernel versions (e.g.
> > +		 * Linux kernel 3.18 and possibly earlier).
> > +		 */
> > +		return compat_futex_async(uaddr, op, val, timeout,
> > 				uaddr2, val3);
> > 	}
> > 	return ret;
