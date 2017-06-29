Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 12:28:52 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:36]:55032
        "EHLO resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993905AbdF2K2kdPL8P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 12:28:40 +0200
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-04v.sys.comcast.net with SMTP
        id QWgWdlT9dLhyoQWggdQ2jt; Thu, 29 Jun 2017 10:28:38 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-ch2-20v.sys.comcast.net with SMTP
        id QWgedHUUCULyFQWgfdvPK1; Thu, 29 Jun 2017 10:28:38 +0000
Subject: Re: [PATCH 00/11] MIPS: cmpxchg(), xchg() fixes & queued locks
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <0952f37f-f0ca-93d6-fb58-9cd18efa52c0@gentoo.org>
Date:   Thu, 29 Jun 2017 06:28:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170610002644.8434-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJevC2HZmmMEK5kaoT/sAGW85aQg+E+Dfu21ckvQGUNk3XtQAE7jAXu6HWz005mHW0oM7LiLhrgmClnkXywjpWJLDFyRAaDYNliAXeLxS5UawORt97PA
 1Ggv1EpX9WH3RVx8XoN0wwoIJaanFZCGq1gZajrgXhr+mA2qxPKefAE0kmNFPYFeUln8G6xLzu2YqDxvx2c7eHXHHET+YSv5tYgkmq5bHVvhjqdLMJ9sjbsq
 KTdFW0Xd5TXKoRz2aTzD1Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/09/2017 20:26, Paul Burton wrote:
> This series makes a bunch of cleanups & improvements to the cmpxchg() &
> xchg() macros & functions, allowing them to be used on values smaller
> than 4 bytes, then switches MIPS over to use generic queued spinlocks &
> queued read/write locks.
> 
> Applies atop v4.12-rc4.
> 
> Paul Burton (11):
>   MIPS: cmpxchg: Unify R10000_LLSC_WAR & non-R10000_LLSC_WAR cases
>   MIPS: cmpxchg: Pull xchg() asm into a macro
>   MIPS: cmpxchg: Use __compiletime_error() for bad cmpxchg() pointers
>   MIPS: cmpxchg: Error out on unsupported xchg() calls
>   MIPS: cmpxchg: Drop __xchg_u{32,64} functions
>   MIPS: cmpxchg: Implement __cmpxchg() as a function
>   MIPS: cmpxchg: Implement 1 byte & 2 byte xchg()
>   MIPS: cmpxchg: Implement 1 byte & 2 byte cmpxchg()
>   MIPS: cmpxchg: Rearrange __xchg() arguments to match xchg()
>   MIPS: Use queued read/write locks (qrwlock)
>   MIPS: Use queued spinlocks (qspinlock)
> 
>  arch/mips/Kconfig                      |   2 +
>  arch/mips/include/asm/Kbuild           |   2 +
>  arch/mips/include/asm/cmpxchg.h        | 280 ++++++++++------------
>  arch/mips/include/asm/spinlock.h       | 426 +--------------------------------
>  arch/mips/include/asm/spinlock_types.h |  34 +--
>  arch/mips/kernel/Makefile              |   2 +-
>  arch/mips/kernel/cmpxchg.c             | 109 +++++++++
>  7 files changed, 239 insertions(+), 616 deletions(-)
>  create mode 100644 arch/mips/kernel/cmpxchg.c

FWIW, I've been running this patchset, along with the cpu_has_* patches, on my
SGI Octane for two weeks now, constantly compiling code, and haven't seen any
issues thus far.

Tested-by: Joshua Kinard <kumba@gentoo.org>
