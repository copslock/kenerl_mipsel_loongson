Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2015 11:37:33 +0100 (CET)
Received: from mout.gmx.net ([212.227.17.21]:59719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008203AbbLSKhakb1QH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2015 11:37:30 +0100
Received: from [192.168.20.60] ([92.203.49.69]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LtVLE-1aI7CS2QAW-010xcb; Sat, 19 Dec 2015 11:37:08
 +0100
Subject: Re: Aw: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should
 work-around futex signal-restart kernel bug
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>
 <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
 <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60>
 <1817225945.264082.1450468696180.JavaMail.zimbra@efficios.com>
 <56746FC6.10904@gmx.de>
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
X-Enigmail-Draft-Status: N1110
Message-ID: <56753350.2060906@gmx.de>
Date:   Sat, 19 Dec 2015 11:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <56746FC6.10904@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:uxzVTCk6u1umsLnvdXfIDmJFGM+UOgO7XnRHdEKl4Dby88+yTHq
 pI9bxeIthGVcCI1a5bYQT6Y3ib/bfgJPf/OdQja7msGIUkSU0BpCE8ceiRU/ZO9scwTp6ep
 sVoajB2SWUh7TlfoyOhj1jsju8HCQICIFVaQVOFIFuxgS6SnLFaipz4SJP+kCNGWPJ0bRb1
 14BNnaDEJ+FWeyHSnGJtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:57Z/ls11cUY=:dCR0UNUCg62CTM5ND5f0CM
 TAQyOXSR0bOyQAhro9EECli5q/iogTHuLwikXVpteEFjEIG04YlA1hlJU6iteYEsOB2zgBNFT
 ud8RNr+zPAKLWomIOD1jN9AAtw8xchREhiy68gkb+D7TPQjXeLm/XI19F7RIkkTe0K/w8Z3cL
 AcOGX2VwqWSWDoQPVUefE1nl/14BZLdtRiPKlHKSmk6+M+rfjsXxRWZCKOFDfjIUoovyqt4nI
 G2wy4CItDrMzJSWq6JJjSujfW+nEHCgLPrZE1dNQMNIZAVnX6oGkL9MuOUEY9kfuvBYbkNx4C
 2yI2zCwEBCFdMi7uQXeb0Gjg9dW02rNnmu8BSnFUnHrPIKEYgDicm65anZFhzmgVLvU4+lSG1
 B/eRyXgtuN4Xq/F9G2Bqwb/OcEz9jRtRVS/ft9X6uYwExoRWWSuW8WnBA9a9WkzpW7R/J46bE
 QsCF3ytpScOoFcUudnCwmj8fxO2hAE7TNw0VgrG2CiG35+LpnfmGNrqNrtTDC0LuBwbgOVlmM
 j+s+KURRYYSHus704ku5bWUNG8Huw5S+PABdHznGL6PpEOGDl4Hbw9vGnCJ9GDsCghlmeCZ0Q
 cmkXxEan8WRiULOafVAC4bUC7/688QYVE/+yQWnqSevwMJA/1s24EBVHHj/82VJteWukm3GQy
 xYenIZXhYRQ+CDkjTb1raMwCB+iG3tp94+UxG9F18wUgUSkFnpQ3CIIkUM7EvqQ706LjZFKCz
 uEq+BJVTQM0wdghEQ6x4WyehECHaVP0gGz917WovjEEY+dOcVQboWNvnlfzBxehuwHhOenHYf
 TBK60ya
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50697
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

On 18.12.2015 21:42, Helge Deller wrote:
> On 18.12.2015 20:58, Mathieu Desnoyers wrote:
>>>>> When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
>>>>> Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
>>>>> FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
>>>>> signal handler. This spurious ENOSYS behavior causes hangs in liburcu
>>>>> 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
>>>>> same behavior. This might affect earlier kernels.
>>>>>
>>>>> This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
>>>>> nevertheless, we should try to handle this kernel bug more gracefully
>>>>> than a user-space hang due to unexpected spurious ENOSYS return value.
>>>>
>>>> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
>>>> Linux kernel upstream fix commit is:
>>>> e967ef02 "MIPS: Fix restart of indirect syscalls"

>> Looks like parisc has an issue very similar to the one that
>> has been fixed on MIPS by e967ef02 "MIPS: Fix restart of indirect syscalls".

Yes, parisc is affected the same way.
I've posted a patch to the parisc mailing list which fixes this issue for
parisc and which I plan to push into stable kernels:
http://thread.gmane.org/gmane.linux.ports.parisc/26243

Regarding your patch for liburcu:

>>>>> Therefore, fallback on the "async-safe" version of compat_futex in those
>>>>> situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
>>>>> the nice property of being OK to use concurrently with other FUTEX_WAKE
>>>>> and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.

I've tested your patch. It does not produce any regressions on parisc, but I can't
say for sure if it really works. ENOSYS is returned randomly, so maybe I didn't
faced a situation where your patch actually was used.

Helge
