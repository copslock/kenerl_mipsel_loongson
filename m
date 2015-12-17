Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 14:17:48 +0100 (CET)
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33752 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014105AbbLQNRmqqjRT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 14:17:42 +0100
Received: by mail-vk0-f52.google.com with SMTP id a188so46577708vkc.0
        for <linux-mips@linux-mips.org>; Thu, 17 Dec 2015 05:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyportsystems.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0CCCnvdik2Nhl5ldyQErFwut3TJ1e++hRwec5nBW02c=;
        b=BugW1XVkzLftDXiSOARSjFWU8HakfG3h5LHOgxau2LPqpn5YEQckSah9zNDjA9FLIj
         EWDm2sv3JMwxElClOg0t20jMIS440IRNL+K/ZlEQqEBzkNCOFXued1RfIeshLnfSlBrT
         Ib/S+lKWiSHZHcxl0mY+BjOblbeG6MSwMk3Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0CCCnvdik2Nhl5ldyQErFwut3TJ1e++hRwec5nBW02c=;
        b=XIJ+PKIMEvPc/0h6Wuq57MsUdbyDyan6FrQhMQzUwVzGCjZ42js0SY5yglTsywRQeU
         YKChvaIa/0ji+kcJZjMk+lO3IX5CIZJU2ttD626zrJIZbIjl3eIKVBb/XZj1NTZwlzSM
         tWCbaraj65HAUdamGsrpQ0ZiFvVr5Hm8JxlWngp5IKl8xXansOM5uYkO93TX7pjNQ0Xr
         exPNSBp67nno1ow1C+a1ERIDVB+2MNz+cqieTwW6QSFLuHlZQ+UP0FeXuog+yE9/Ai97
         tSFkK1fMjVk9FJ35VELq1AzAcsZ4pL7PUVA031F1GeGAdR/qT+nd0xEIB1qwNGqT2paJ
         cevg==
X-Gm-Message-State: ALoCoQn4bYXYkD7NIG3YIdvsPyBlrEBLwMsk1ImofnzYEdlSRRyAmVwFsLDi0jVii3Uj9cvmAKHXCFzkEa2/cW22aQ2+yUWgCrSia8FZ8H/SzAfYhC/uL9c=
X-Received: by 10.31.129.11 with SMTP id c11mr35797184vkd.52.1450358256875;
 Thu, 17 Dec 2015 05:17:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.237.7 with HTTP; Thu, 17 Dec 2015 05:16:57 -0800 (PST)
In-Reply-To: <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com> <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
From:   Ed Swierk <eswierk@skyportsystems.com>
Date:   Thu, 17 Dec 2015 05:16:57 -0800
Message-ID: <CAO_EM_n+_0=94CAjhE6XTCMVmjnqLOaDhTz-xaqZb77UL4o+hw@mail.gmail.com>
Subject: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should
 work-around futex signal-restart kernel bug
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jon Bernard <jbernard@debian.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eswierk@skyportsystems.com
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

I believe e967ef02 "MIPS: Fix restart of indirect syscalls" should be
backported to all stable kernels.

It would be a surprising coincidence if parisc suffers from the same problem.

--Ed


On Thu, Dec 17, 2015 at 4:54 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Dec 16, 2015, at 5:09 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>
>> When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
>> Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
>> FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
>> signal handler. This spurious ENOSYS behavior causes hangs in liburcu
>> 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
>> same behavior. This might affect earlier kernels.
>>
>> This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
>> nevertheless, we should try to handle this kernel bug more gracefully
>> than a user-space hang due to unexpected spurious ENOSYS return value.
>
> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
> Linux kernel upstream fix commit is:
> e967ef02 "MIPS: Fix restart of indirect syscalls"
>
> I've created a small test program that could also be used on parisc
> to check if it suffers from the same issue (see attached).
>
> On bogus mips kernels, we see the following output:
> [OK] Test program with pid: 5748 SIGUSR1 handler
> [FAIL] futex returns -1, Function not implemented
>
> Let me know if someone can try it out on a parisc kernel.
>
> Thanks!
>
> Mathieu
>
>>
>> Therefore, fallback on the "async-safe" version of compat_futex in those
>> situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
>> the nice property of being OK to use concurrently with other FUTEX_WAKE
>> and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
>>
>> We suspect that parisc might be affected by a similar issue (Debian
>> build bots reported a similar hang on both mips and parisc), but we do
>> not have access to the hardware required to test this hypothesis.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Michael Jeanson <mjeanson@efficios.com>
>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> CC: Ralf Baechle <ralf@linux-mips.org>
>> CC: linux-mips@linux-mips.org
>> CC: linux-kernel@vger.kernel.org
>> CC: "James E.J. Bottomley" <jejb@parisc-linux.org>
>> CC: Helge Deller <deller@gmx.de>
>> CC: linux-parisc@vger.kernel.org
>> ---
>> compat_futex.c |  2 ++
>> urcu/futex.h   | 12 +++++++++++-
>> 2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/compat_futex.c b/compat_futex.c
>> index b7f78f0..9e918fe 100644
>> --- a/compat_futex.c
>> +++ b/compat_futex.c
>> @@ -111,6 +111,8 @@ end:
>>  * _ASYNC SIGNAL-SAFE_.
>>  * For now, timeout, uaddr2 and val3 are unused.
>>  * Waiter will busy-loop trying to read the condition.
>> + * It is OK to use compat_futex_async() on a futex address on which
>> + * futex() WAKE operations are also performed.
>>  */
>>
>> int compat_futex_async(int32_t *uaddr, int op, int32_t val,
>> diff --git a/urcu/futex.h b/urcu/futex.h
>> index 4d16cfa..a17eda8 100644
>> --- a/urcu/futex.h
>> +++ b/urcu/futex.h
>> @@ -73,7 +73,17 @@ static inline int futex_noasync(int32_t *uaddr, int op,
>> int32_t val,
>>
>>       ret = futex(uaddr, op, val, timeout, uaddr2, val3);
>>       if (caa_unlikely(ret < 0 && errno == ENOSYS)) {
>> -             return compat_futex_noasync(uaddr, op, val, timeout,
>> +             /*
>> +              * The fallback on ENOSYS is the async-safe version of
>> +              * the compat futex implementation, because the
>> +              * async-safe compat implementation allows being used
>> +              * concurrently with calls to futex(). Indeed, sys_futex
>> +              * FUTEX_WAIT, on some architectures (e.g. mips), within
>> +              * a given process, spuriously return ENOSYS due to
>> +              * signal restart bugs on some kernel versions (e.g.
>> +              * Linux kernel 3.18 and possibly earlier).
>> +              */
>> +             return compat_futex_async(uaddr, op, val, timeout,
>>                               uaddr2, val3);
>>       }
>>       return ret;
>> --
>> 2.1.4
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
