Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Dec 2015 15:11:48 +0100 (CET)
Received: from mail.efficios.com ([78.47.125.74]:47680 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008174AbbLTOLqCy55A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Dec 2015 15:11:46 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 91CFC340307;
        Sun, 20 Dec 2015 14:11:42 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LSh7MmEWuO3U; Sun, 20 Dec 2015 14:11:41 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D355B3403D3;
        Sun, 20 Dec 2015 14:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g_x2Yh5st3Xz; Sun, 20 Dec 2015 14:11:41 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
        by mail.efficios.com (Postfix) with ESMTP id 9FE5F3403D2;
        Sun, 20 Dec 2015 14:11:41 +0000 (UTC)
Date:   Sun, 20 Dec 2015 14:11:41 +0000 (UTC)
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
Message-ID: <1106544409.268921.1450620701325.JavaMail.zimbra@efficios.com>
In-Reply-To: <56753350.2060906@gmx.de>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com> <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com> <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60> <1817225945.264082.1450468696180.JavaMail.zimbra@efficios.com> <56746FC6.10904@gmx.de> <56753350.2060906@gmx.de>
Subject: Re: Aw: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex
 should work-around futex signal-restart kernel bug
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.47.125.74]
X-Mailer: Zimbra 8.6.0_GA_1178 (ZimbraWebClient - FF42 (Linux)/8.6.0_GA_1178)
Thread-Topic: compat_futex should work-around futex signal-restart kernel bug
Thread-Index: yUnaPxzg3j5H69hDs6qKec20Dl+bNA==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50705
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

----- On Dec 19, 2015, at 5:37 AM, Helge Deller deller@gmx.de wrote:

> Hi Mathieu,
> 
> On 18.12.2015 21:42, Helge Deller wrote:
>> On 18.12.2015 20:58, Mathieu Desnoyers wrote:
>>>>>> When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
>>>>>> Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
>>>>>> FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
>>>>>> signal handler. This spurious ENOSYS behavior causes hangs in liburcu
>>>>>> 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
>>>>>> same behavior. This might affect earlier kernels.
>>>>>>
>>>>>> This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
>>>>>> nevertheless, we should try to handle this kernel bug more gracefully
>>>>>> than a user-space hang due to unexpected spurious ENOSYS return value.
>>>>>
>>>>> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
>>>>> Linux kernel upstream fix commit is:
>>>>> e967ef02 "MIPS: Fix restart of indirect syscalls"
> 
>>> Looks like parisc has an issue very similar to the one that
>>> has been fixed on MIPS by e967ef02 "MIPS: Fix restart of indirect syscalls".
> 
> Yes, parisc is affected the same way.
> I've posted a patch to the parisc mailing list which fixes this issue for
> parisc and which I plan to push into stable kernels:
> http://thread.gmane.org/gmane.linux.ports.parisc/26243
> 
> Regarding your patch for liburcu:
> 
>>>>>> Therefore, fallback on the "async-safe" version of compat_futex in those
>>>>>> situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
>>>>>> the nice property of being OK to use concurrently with other FUTEX_WAKE
>>>>>> and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
> 
> I've tested your patch. It does not produce any regressions on parisc, but I
> can't
> say for sure if it really works. ENOSYS is returned randomly, so maybe I didn't
> faced a situation where your patch actually was used.

If you ran make check and make regtest, and nothing
fails/hangs, you should be OK. liburcu runs very heavy
stress-tests which makes it likely to hit race conditions
repeatedly.

Thanks!

Mathieu

> 
> Helge

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
