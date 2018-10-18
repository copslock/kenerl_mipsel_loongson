Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2018 06:32:08 +0200 (CEST)
Received: from zeniv.linux.org.uk ([195.92.253.2]:60016 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990437AbeJREcFjBG6k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Oct 2018 06:32:05 +0200
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCzya-0007M8-QA; Thu, 18 Oct 2018 04:32:00 +0000
Date:   Thu, 18 Oct 2018 05:32:00 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Hongzhi, Song" <hongzhi.song@windriver.com>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Question about mmap syscall and POSIX standard on mips arch
Message-ID: <20181018043200.GE32577@ZenIV.linux.org.uk>
References: <e897b11f-1577-9298-7c82-7bbdea56e7e5@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e897b11f-1577-9298-7c82-7bbdea56e7e5@windriver.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ZenIV.linux.org.uk
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

[mips folks Cc'd]

On Thu, Oct 18, 2018 at 11:26:02AM +0800, Hongzhi, Song wrote:
> Hi all,
> 
> Ltp has a POSIX teatcase about mmap, 24-2.c.
> 
> https://github.com/linux-test-project/ltp/blob/e816127e5d8efbff5ae53e9c2292fae22f36838b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c#L94

[basically, MAP_FIXED mmap with addr + len > TASK_SIZE fails with
-EINVAL on mips and -ENOMEM elsewhere]
 
> Under POSIX standard, the expected errno should be ENOMEM
> 
> when the specific [addr+len] exceeds the bound of memory.

The mmap() function may fail if:

[EINVAL]
The addr argument (if MAP_FIXED was specified) or off is not a multiple
of the page size as returned by sysconf(), or is considered invalid by
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
the implementation.
^^^^^^^^^^^^^^^^^^^

So that behaviour gets past POSIX.  That part is mostly about the
things like cache aliasing constraints, etc., but it leaves enough
space to weasel out.  Said that, this

[ENOMEM]
MAP_FIXED was specified, and the range [addr,addr+len) exceeds that allowed
for the address space of a process; or, if MAP_FIXED was not specified and
there is insufficient room in the address space to effect the mapping.

is a lot more specific, so switching to -ENOMEM there might be a good idea,
especially since on other architectures we do get -ENOMEM in that case,
AFAICS.
