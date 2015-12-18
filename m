Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 21:43:09 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.15]:54631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006917AbbLRUnG3hNDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Dec 2015 21:43:06 +0100
Received: from [192.168.20.60] ([92.203.16.219]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LnxxQ-1ahAkz3D20-00g06M; Fri, 18 Dec 2015 21:42:50
 +0100
Subject: Re: Aw: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should
 work-around futex signal-restart kernel bug
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>
 <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
 <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60>
 <1817225945.264082.1450468696180.JavaMail.zimbra@efficios.com>
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
From:   Helge Deller <deller@gmx.de>
Message-ID: <56746FC6.10904@gmx.de>
Date:   Fri, 18 Dec 2015 21:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1817225945.264082.1450468696180.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:KyzwvvCdhhXvBKWDfcgtgAWtbTwMasGE2VZjBRCo9muAQj1o4xv
 4Lul3FNBCd9XSZciQmCc11k+6eBtPA2U593Y0mMKZRqA5/0bRmOoCr5DynzoBiAH/w3AzZJ
 htk8pv8znB5ND/flJ18tBbRajMjCG7cYKTx/+62wFNWeSmcR78x25LedjmUceND8Aul3g+W
 oNtEG2qhZxEOYlZQpV+uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lIUbwxA+wPQ=:ehwSbRT6uEqqmX98sfvPw6
 q5fKIUFNLy0IqAXyt73nU9Wte1vVYRG4FkYF8n80wiLkdJiSCEEYv9y6aLaeHv1pegM8haek0
 p0YJstz1r/47C8j8B3MSTpS4IHFYlmbYWLbksO1b5bbRx9CDskTtIQ//vo/0u0zhX0bHu0S5V
 hfhhXRlK4YRQItrTu5o2akF1Qj5DNvaRitV3yShZTNPX9T5mjCmECMjbGONKB7gUE6au0jYsG
 Mu8OWi+CAj+0+FWjZmVKVggaWuCDphucYxffnu3Z9lZe2BmlAO+2414hkVqvZaGOd7bpzi3mG
 XK53aSOIKimwS3kev1XZZ9Vo0AUwBeCd22xlvXv7U71KBN5IGUaCzr6vtV5NnFzlk+2atzp3t
 zdaOTPsU8ca0bM7bch3rSwsVmIBZYkfVT7wAmf4MEgADiftBwUFTCJX5ej5zyduNxw/3RYQCJ
 Zrdv/efIReycfKOX9HUnmFlYXsz+GHRoVpUNXrSvN0coDUEMOmFukGB86nzOcoAbNczt5CBIc
 iMfKqW7VSLwZhPpgYF3HDbN5LAuRjs8CW6znwHGlsLxR9rtWecnj2/aHlae7gQiO12sdTLULJ
 GejL5cgzttF8p34iaCHFOl7cUFBU4nc3xvLXyYKk2o3c8fIy/wJliScBI8wdovJvmZecHmbAi
 vjIh9viImGV+3xjeB3aRMHHc980OennuyWLRb0+r1TZcKI8A5npCVEj8KWGEe0VUnpvDpnw2D
 by/4Y7gde2+k/RHodGoDrFwykWz2zZompMI+y47qOQfGc0AQgnZPnmoVioF9gx4Qk9jqLBEoB
 3V+A1WN
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50695
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

Hi Mathieu,

On 18.12.2015 20:58, Mathieu Desnoyers wrote:
> ----- On Dec 17, 2015, at 11:22 AM, Helge Deller deller@gmx.de wrote:
> 
>> Hello Mathieu,
>>
>>>> When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
>>>> Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
>>>> FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
>>>> signal handler. This spurious ENOSYS behavior causes hangs in liburcu
>>>> 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
>>>> same behavior. This might affect earlier kernels.
>>>>
>>>> This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
>>>> nevertheless, we should try to handle this kernel bug more gracefully
>>>> than a user-space hang due to unexpected spurious ENOSYS return value.
>>>
>>> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
>>> Linux kernel upstream fix commit is:
>>> e967ef02 "MIPS: Fix restart of indirect syscalls"
>>
>> But that patch fixes mips only.
> 
> Indeed, I do not expect this commit to have any effect on parisc.
> 
>>
>>> I've created a small test program that could also be used on parisc
>>> to check if it suffers from the same issue (see attached).
>>>
>>> On bogus mips kernels, we see the following output:
>>> [OK] Test program with pid: 5748 SIGUSR1 handler
>>> [FAIL] futex returns -1, Function not implemented
>>
>> I tested it on a recent 4.2 kernel on parisc.
>> It fails as you describe:
>>
>> Testing futex sigrestart. Stop with CTRL-c.
>> [OK] Test program with pid: 1361 SIGUSR1 handler
>> [OK] Test program with pid: 1361 SIGUSR1 handler
>> [FAIL] futex returns -1, Function not implemented
>> [OK] Test program with pid: 1361 SIGUSR1 handler
>> [FAIL] futex returns -1, Function not implemented
>>
>> strace gives:
>> [pid  1329] futex(0x1210c, FUTEX_WAIT, -1, NULL <unfinished ...>
>> [pid  1328] nanosleep({1, 0},  <unfinished ...>
>> [pid  1329] <... futex resumed> )       = ? ERESTARTSYS (To be restarted if
>> SA_RESTART is set)
>> [pid  1329] write(2, "[FAIL] futex returns -1, Functio"..., 50[FAIL] futex
>> returns -1, Function not implemented)
> 
> Looks like parisc has an issue very similar to the one that
> has been fixed on MIPS by e967ef02 "MIPS: Fix restart of indirect syscalls".

Yes.

>>>> Therefore, fallback on the "async-safe" version of compat_futex in those
>>>> situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
>>>> the nice property of being OK to use concurrently with other FUTEX_WAKE
>>>> and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
>>>>
>>>> We suspect that parisc might be affected by a similar issue (Debian
>>>> build bots reported a similar hang on both mips and parisc), but we do
>>>> not have access to the hardware required to test this hypothesis.
>>
>> If you want access to a machine, let me know.
>> I'll try the patch below as well..
> 
> This would be very useful indeed, just to make sure our approach to
> futex fallback in liburcu works fine on parisc.

Yes, but will take me some time...

> I'm no parisc assembly expert though, but I suspect the issue
> would be quite similar to the one already fixed on MIPS. The
> existing fix for MIPS would be a good starting point to see if
> something similar is missing on parisc.

Yes, I've already started to look into the parisc assembly parts.
The problems seems to be both the same, the syscall number is not
reserved during a syscall restart.
We have problems with pthread cancellation in glibc too, maybe
it's related to this bug.

> When time allows, we should consider cleaning up my test case for
> restart of indirect system calls and add it to kselftest. 

I was thinking of adding it to the Linux Test Project (LTP) :-)

> It's
> the second architecture that has the same defect, which means this
> behavior is seldom tested.

Helge
