Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2007 23:40:13 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:17454 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20024047AbXLGXkF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2007 23:40:05 +0000
Content-class: urn:content-classes:message
Subject: RE: SiByte 1480 & Branch Likely instructions?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date:	Fri, 7 Dec 2007 15:39:57 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C5590D6B@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SiByte 1480 & Branch Likely instructions?
Thread-Index: Acg5G75nLX9OzGDLQf6iiyb7ttVemwADrN7Q
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Kaz wrote:
> Hi All,
> 
> Not really a kernel-related question. I've discovered that GCC 4.1.1
> (which I'm not using for kernel compiling, but user space) generates
> branch likely instructions by default, even though the documentation
> says that their use is off by default for MIPS32 and MIPS64, because

That's because the compiler is not configured correctly. The default CPU
string "from-abi" ends up being used, and so the target ISA is MIPS III.

> In parallel with writing some tests, I thought I would ask whether
> anyone happens know whether or not these instructions are known to
> actually work correctly on the SB1480 silicon (and perhaps any
> additional details, like what revisions, etc)?

A basic sanity test does find bnezl working.

#include <stdio.h>
#include <stdlib.h>

static int branch_likely_works(void)
{
    int one = 1;
    int result;

    __asm__ __volatile__
    ("        .set push\n"
     "        .set noreorder\n"
     "1:      move %0, $0\n"
     "        bnezl %0, 1b\n"
     "        lw %0, %1\n"
     "        .set pop\n"
     : "=r" (result)
     : "m" (one));

     return result == 0;
}

int main(void)
{
    if (branch_likely_works()) {
        puts("branch-likely instruction bnezl correctly annuls delay
slot");
        return 0;
    } 
    puts("branch-likely instruction bnezl fails to annul delay slot");
    return EXIT_FAILURE;
}
