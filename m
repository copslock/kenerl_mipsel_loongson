Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 13:54:25 +0100 (CET)
Received: from mail.efficios.com ([78.47.125.74]:45179 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008659AbbLQMyVRsm7T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Dec 2015 13:54:21 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AFAFD340319;
        Thu, 17 Dec 2015 12:54:17 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5JMlhMlFQiOx; Thu, 17 Dec 2015 12:54:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3B0A23403DD;
        Thu, 17 Dec 2015 12:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w7ukhVzCX30x; Thu, 17 Dec 2015 12:54:13 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
        by mail.efficios.com (Postfix) with ESMTP id 0D21D340319;
        Thu, 17 Dec 2015 12:54:13 +0000 (UTC)
Date:   Thu, 17 Dec 2015 12:54:12 +0000 (UTC)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jon Bernard <jbernard@debian.org>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
In-Reply-To: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should
 work-around futex signal-restart kernel bug
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_259005_501537116.1450356852692"
X-Originating-IP: [78.47.125.74]
X-Mailer: Zimbra 8.6.0_GA_1178 (ZimbraWebClient - FF42 (Linux)/8.6.0_GA_1178)
Thread-Topic: compat_futex should work-around futex signal-restart kernel bug
Thread-Index: yCkBslMyIgxq4n9NRGE8Kc2gSaRfqw==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50676
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

------=_Part_259005_501537116.1450356852692
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Dec 16, 2015, at 5:09 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
> Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
> FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
> signal handler. This spurious ENOSYS behavior causes hangs in liburcu
> 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
> same behavior. This might affect earlier kernels.
> 
> This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
> nevertheless, we should try to handle this kernel bug more gracefully
> than a user-space hang due to unexpected spurious ENOSYS return value.

It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
Linux kernel upstream fix commit is:
e967ef02 "MIPS: Fix restart of indirect syscalls"

I've created a small test program that could also be used on parisc
to check if it suffers from the same issue (see attached).

On bogus mips kernels, we see the following output:
[OK] Test program with pid: 5748 SIGUSR1 handler
[FAIL] futex returns -1, Function not implemented

Let me know if someone can try it out on a parisc kernel.

Thanks!

Mathieu

> 
> Therefore, fallback on the "async-safe" version of compat_futex in those
> situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
> the nice property of being OK to use concurrently with other FUTEX_WAKE
> and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
> 
> We suspect that parisc might be affected by a similar issue (Debian
> build bots reported a similar hang on both mips and parisc), but we do
> not have access to the hardware required to test this hypothesis.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Michael Jeanson <mjeanson@efficios.com>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> CC: linux-kernel@vger.kernel.org
> CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-parisc@vger.kernel.org
> ---
> compat_futex.c |  2 ++
> urcu/futex.h   | 12 +++++++++++-
> 2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/compat_futex.c b/compat_futex.c
> index b7f78f0..9e918fe 100644
> --- a/compat_futex.c
> +++ b/compat_futex.c
> @@ -111,6 +111,8 @@ end:
>  * _ASYNC SIGNAL-SAFE_.
>  * For now, timeout, uaddr2 and val3 are unused.
>  * Waiter will busy-loop trying to read the condition.
> + * It is OK to use compat_futex_async() on a futex address on which
> + * futex() WAKE operations are also performed.
>  */
> 
> int compat_futex_async(int32_t *uaddr, int op, int32_t val,
> diff --git a/urcu/futex.h b/urcu/futex.h
> index 4d16cfa..a17eda8 100644
> --- a/urcu/futex.h
> +++ b/urcu/futex.h
> @@ -73,7 +73,17 @@ static inline int futex_noasync(int32_t *uaddr, int op,
> int32_t val,
> 
> 	ret = futex(uaddr, op, val, timeout, uaddr2, val3);
> 	if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
> -		return compat_futex_noasync(uaddr, op, val, timeout,
> +		/*
> +		 * The fallback on ENOSYS is the async-safe version of
> +		 * the compat futex implementation, because the
> +		 * async-safe compat implementation allows being used
> +		 * concurrently with calls to futex(). Indeed, sys_futex
> +		 * FUTEX_WAIT, on some architectures (e.g. mips), within
> +		 * a given process, spuriously return ENOSYS due to
> +		 * signal restart bugs on some kernel versions (e.g.
> +		 * Linux kernel 3.18 and possibly earlier).
> +		 */
> +		return compat_futex_async(uaddr, op, val, timeout,
> 				uaddr2, val3);
> 	}
> 	return ret;
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

------=_Part_259005_501537116.1450356852692
Content-Type: text/x-c++src; name=test-sigrestart-futex.c
Content-Disposition: attachment; filename=test-sigrestart-futex.c
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN5cy90eXBl
cy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0
ZGxpYi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CgpzdGF0
aWMgaW50IHZhbHVlID0gLTE7CgojZGVmaW5lIEZVVEVYX1dBSVQJCTAKI2RlZmluZSBGVVRFWF9X
QUtFCQkxCgpzdGF0aWMgaW50IGZ1dGV4KGludDMyX3QgKnVhZGRyLCBpbnQgb3AsIGludDMyX3Qg
dmFsLAoJCWNvbnN0IHN0cnVjdCB0aW1lc3BlYyAqdGltZW91dCwgaW50MzJfdCAqdWFkZHIyLCBp
bnQzMl90IHZhbDMpCnsKCXJldHVybiBzeXNjYWxsKF9fTlJfZnV0ZXgsIHVhZGRyLCBvcCwgdmFs
LCB0aW1lb3V0LAoJCQl1YWRkcjIsIHZhbDMpOwp9CgpzdGF0aWMgdm9pZCBzaWdoYW5kbGVyKGlu
dCBzaWdubywgc2lnaW5mb190ICpzaWdpbmZvLCB2b2lkICpjb250ZXh0KQp7CglmcHJpbnRmKHN0
ZGVyciwgIltPS10gVGVzdCBwcm9ncmFtIHdpdGggcGlkOiAlZCBTSUdVU1IxIGhhbmRsZXJcbiIs
CgkJZ2V0cGlkKCkpOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCnsKCXN0cnVj
dCBzaWdhY3Rpb24gYWN0OwoJcGlkX3QgcGlkLCB3YWl0X3BpZDsKCWludCByZXQ7CgoJZnByaW50
ZihzdGRlcnIsICJUZXN0aW5nIGZ1dGV4IHNpZ3Jlc3RhcnQuIFN0b3Agd2l0aCBDVFJMLWMuXG4i
LAoJCWdldHBpZCgpKTsKCWFjdC5zYV9zaWdhY3Rpb24gPSBzaWdoYW5kbGVyOwoJYWN0LnNhX2Zs
YWdzID0gU0FfU0lHSU5GTyB8IFNBX1JFU1RBUlQ7CgkvL2FjdC5zYV9mbGFncyA9IFNBX1NJR0lO
Rk87CglzaWdlbXB0eXNldCgmYWN0LnNhX21hc2spOwoJcmV0ID0gc2lnYWN0aW9uKFNJR1VTUjEs
ICZhY3QsIE5VTEwpOwoJaWYgKHJldCkKCQlhYm9ydCgpOwoKCXBpZCA9IGZvcmsoKTsKCWlmIChw
aWQgPiAwKSB7CgkJLyogcGFyZW50ICovCgkJZm9yICg7OykgewoJCQlyZXQgPSBraWxsKHBpZCwg
U0lHVVNSMSk7CgkJCWlmIChyZXQpIHsKCQkJCXBlcnJvcigia2lsbCIpOwoJCQkJYWJvcnQoKTsK
CQkJfQoJCQlzbGVlcCgxKTsKCQl9Cgl9IGVsc2UgewoJCWlmIChwaWQgPCAwKSB7CgkJCWFib3J0
KCk7CgkJfQoJCS8qIGNoaWxkICovCgkJZm9yICg7OykgewoJCQlyZXQgPSBmdXRleCgmdmFsdWUs
IEZVVEVYX1dBSVQsIC0xLCBOVUxMLCBOVUxMLCAwKTsKCQkJaWYgKHJldCA8IDApIHsKCQkJCWZw
cmludGYoc3RkZXJyLCAiW0ZBSUxdIGZ1dGV4IHJldHVybnMgJWQsICVzXG4iLAoJCQkJCXJldCwg
c3RyZXJyb3IoZXJybm8pKTsKCQkJfSBlbHNlIHsKCQkJCWZwcmludGYoc3RkZXJyLCAiW0ZBSUxd
IGZ1dGV4IHJldHVybnMgJWQgKHVuZXhwZWN0ZWQpXG4iLAoJCQkJCXJldCk7CgkJCX0KCQl9Cgl9
CgoJcmV0dXJuIDA7Cn0K
------=_Part_259005_501537116.1450356852692--
