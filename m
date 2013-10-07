Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 16:24:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34719 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868728Ab3JGOYcJaZcG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 16:24:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r97EOUmM007442;
        Mon, 7 Oct 2013 16:24:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r97EOTeD007441;
        Mon, 7 Oct 2013 16:24:29 +0200
Date:   Mon, 7 Oct 2013 16:24:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-mips@linux-mips.org, linux-media@vger.kernel.org
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
Message-ID: <20131007142429.GG3098@linux-mips.org>
References: <m3eh82a1yo.fsf@t19.piap.pl>
 <m361t9a31i.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m361t9a31i.fsf@t19.piap.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Oct 07, 2013 at 10:38:49AM +0200, Krzysztof Hałasa wrote:

> Please forgive me my MIPS TLB ignorance.

May the manual be with you :-)

> It seems there is a TLB entry pointing to the userspace buffer at the
> time the kernel pointer (kseg0) is used. Is is an allowed situation on
> MIPS 24K?
> 
> buffer: len 0x1000 (first page),
> 	userspace pointer 0x77327000,
> 	kernel pointer 0x867ac000 (physical address = 0x067ac000)
> 
> TLB Index: 15 pgmask=4kb va=77326000 asid=be
>        [pa=01149000 c=3 d=1 v=1 g=0] [pa=067ac000 c=3 d=1 v=1 g=0]
> 
> Should the TLB entry be deleted before using the kernel pointer (which
> points at the same page)?

That's fine.  You just need to ensure that there are no virtual aliases.
One way to do so is to increase the page size to 16kB.

Note that there is a variant of the 24K which has a VIPT cache but uses
hardware to resolve cache aliases.  That is, from a kernel cache management
perspective it behaves like a PIPT cache.

However as I understand what you're mapping to userspace is actually
device memory, right?  You probably want to map that uncached.  That's a
long standing issue in these two macros:

/*
 * Convert a physical pointer to a virtual kernel pointer for /dev/mem
 * access
 */
#define xlate_dev_mem_ptr(p)    __va(p)

/*
 * Convert a virtual cached pointer to an uncached pointer
 */
#define xlate_dev_kmem_ptr(p)   p

which are defined in arch/mips/include/asm/io.h.  These should return
a KSEG1 (uncached XKPHYS) address for anything but RAM.

Would that explain your observations?

  Ralf
