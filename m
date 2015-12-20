Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Dec 2015 16:37:28 +0100 (CET)
Received: from mout.gmx.net ([212.227.17.22]:60684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008281AbbLTPh0bCXML (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Dec 2015 16:37:26 +0100
Received: from [192.168.20.60] ([92.203.49.69]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LxPgU-1aGYuY27ze-016x8m; Sun, 20 Dec 2015 16:37:04
 +0100
Subject: Re: Aw: Re: [RFC PATCH urcu on mips, parisc] Fix: compat_futex should
 work-around futex signal-restart kernel bug
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <1450303792-27470-1-git-send-email-mathieu.desnoyers@efficios.com>
 <663068619.259007.1450356852694.JavaMail.zimbra@efficios.com>
 <trinity-0a355ae2-e5eb-40e5-8561-41a2e8e251e2-1450369370294@3capp-gmx-bs60>
 <1817225945.264082.1450468696180.JavaMail.zimbra@efficios.com>
 <56746FC6.10904@gmx.de> <56753350.2060906@gmx.de>
 <1106544409.268921.1450620701325.JavaMail.zimbra@efficios.com>
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
Message-ID: <5676CB1C.8090500@gmx.de>
Date:   Sun, 20 Dec 2015 16:37:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1106544409.268921.1450620701325.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:utrDDoUTYpR2o6kjOQ+irjUE3XPbYAaeRNW5/ZHaupKmDsbFI8L
 Lp7errEy+3iEa6UOoDatH9taboM8pZB2xamUrevaLCpsp2n4NDw/K5tEIE8jxjL2PaHr6lj
 ZiCwY3RUWR1tyUZaN3EGarjwhyriZ3H0t7nHiLKwS4tlpiY5GT+YmsYrUV+uhJPUnbrVc95
 t/Agy/SYKPO9rW6GYc+AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:owSaVxxhyCs=:vsUDhPdUUcgAx80EGnzmin
 WRiG8bo0V5Mrhy3+16T8LbECu5fnQWk9GoMAqaaKaU//giRVaIpVfijHFDe1+73zZnjsPjuLZ
 fNbhulDFnfaSyjfr1QVbWVbgP+4NZB41tVhVh2OehIzYdJH8lbTbrJUXTfMmT5aQbLQ54wvA6
 8o1hCJnXL+zP0kr9TJ+YdzwpHBeFVIz393L63Xg+yXHhjvn3/poBc0fQn+NGyJhcak2hvhZUF
 JFX8LaClNkcoTEfHnWuDsNaKPLG5O1rwEld82h0cQZosHGlF6rIJcjvGa4VQ/BVwv00aUCNPt
 XdVVUI3AzLnT3K+C+p39ZhvKhn7ib8/9vTGiOoqkQlJZa7LO2XLuSbG0rYaVejIDkcPtnVr2u
 fGdqXOlgYcK5QdhsuePsU69rTgMVkDqCyO/CPLA4HAWyHqVI77/B2uIZ8F0snoCyyJo2rFC+X
 2mob7OFbY06Dn29m7i4v1pfvwfe4zhFg3TPSefHqO8Hqzad8vgbva/bZEQaz/u7KFQUYnRnai
 RwP/WDpAC7WgJbhJtP/L4CSh6yPCZn6B1o8SMlaxYaXjmYkAPgHn0t17Tdsk2E/hUz4ODU4tO
 XET+6Q4RzfvDjHM29YBE2+FSf8Ejh4RpDIU0BykwwYo6aXHHLVUvRb68dg70Y48Pj4QPcACjD
 1Ewgo859fomJJGvEO5HlQzmKHIuUIK00J7rSkpPt7qi3ukvCWQvHdXMKXDJacaAB5AfdTXyPb
 ea7qwFCzfZJWizSCt2HhXeBYbXa0pUiORCXgQpIu5O8Gh9Y0a1eXoqxJYY1JIARB5CodYnrbU
 Gfyuyj4
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50706
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

On 20.12.2015 15:11, Mathieu Desnoyers wrote:
> ----- On Dec 19, 2015, at 5:37 AM, Helge Deller deller@gmx.de wrote:
> 
>> Hi Mathieu,
>>
>> On 18.12.2015 21:42, Helge Deller wrote:
>>> On 18.12.2015 20:58, Mathieu Desnoyers wrote:
>>>>>>> When testing liburcu on a 3.18 Linux kernel, 2-core MIPS (cpu model :
>>>>>>> Ingenic JZRISC V4.15  FPU V0.0), we notice that a blocked sys_futex
>>>>>>> FUTEX_WAIT returns -1, errno=ENOSYS when interrupted by a SA_RESTART
>>>>>>> signal handler. This spurious ENOSYS behavior causes hangs in liburcu
>>>>>>> 0.9.x. Running a MIPS 3.18 kernel under a QEMU emulator exhibits the
>>>>>>> same behavior. This might affect earlier kernels.
>>>>>>>
>>>>>>> This issue appears to be fixed in 3.18.y stable kernels and 3.19, but
>>>>>>> nevertheless, we should try to handle this kernel bug more gracefully
>>>>>>> than a user-space hang due to unexpected spurious ENOSYS return value.
>>>>>>
>>>>>> It's actually fixed in 3.19, but not in 3.18.y stable kernels. The
>>>>>> Linux kernel upstream fix commit is:
>>>>>> e967ef02 "MIPS: Fix restart of indirect syscalls"
>>
>>>> Looks like parisc has an issue very similar to the one that
>>>> has been fixed on MIPS by e967ef02 "MIPS: Fix restart of indirect syscalls".
>>
>> Yes, parisc is affected the same way.
>> I've posted a patch to the parisc mailing list which fixes this issue for
>> parisc and which I plan to push into stable kernels:
>> http://thread.gmane.org/gmane.linux.ports.parisc/26243
>>
>> Regarding your patch for liburcu:
>>
>>>>>>> Therefore, fallback on the "async-safe" version of compat_futex in those
>>>>>>> situations where FUTEX_WAIT returns ENOSYS. This async-safe fallback has
>>>>>>> the nice property of being OK to use concurrently with other FUTEX_WAKE
>>>>>>> and FUTEX_WAIT futex() calls, because it's simply a busy-wait scheme.
>>
>> I've tested your patch. It does not produce any regressions on parisc, but I
>> can't
>> say for sure if it really works. ENOSYS is returned randomly, so maybe I didn't
>> faced a situation where your patch actually was used.
> 
> If you ran make check and make regtest, and nothing
> fails/hangs, you should be OK.

Yes, I did run both.

> liburcu runs very heavy
> stress-tests which makes it likely to hit race conditions
> repeatedly.

Helge
