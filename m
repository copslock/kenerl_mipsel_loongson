Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 22:26:02 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:18404
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225243AbTCCW0C>; Mon, 3 Mar 2003 22:26:02 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18pyNY-0000bz-00; Mon, 03 Mar 2003 16:25:48 -0600
Message-ID: <3E63D43A.2080705@realitydiluted.com>
Date: Mon, 03 Mar 2003 16:16:26 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: uhler@mips.com
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Improper handling of unaligned user address access?
References: <200303032138.h23LcCF25903@uhler-linux.mips.com>
In-Reply-To: <200303032138.h23LcCF25903@uhler-linux.mips.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Mike Uhler wrote:
>>
>>This looks like the unaligned access in a branch delay slot problem I
>>experienced a while ago, where the CPU doesn't set the BD flag if the branch is
>>not taken. Can you please try the patch I posted?
> 
> 
> In this particular case, it would appear that it's not the delay slot problem.
> According to the Cause value above, BD is set, and EPC has been rolled
> back to point at the branch.  That all looks consistent to me.
> 
> Note that the lwl will not take an unaligned exception, and the Cause code
> value indicates a TLB miss.  I don't have the full context of the problem,
> but is 0xA (i.e., virtual page zero) actually a valid address?  If not,
> that's the cause of the problem.
> 
You are correct. 0xA is NOT actually a valid address which is the
problem. I believe the kernel should handle things more gracefully
and return EFAULT instead of killing the process. This code of mine
worked fine in an older 2.4.7 kernel. Why was 'verify_area' taken
out of 'traps.c' by the way?

> By the way, having the oops message put out the BadVAddr and PRId CP0 registers
> would be very helpful.
> 
Here it is:

    <1>Unable to handle kernel paging request at virtual address 000000a,
      epc == 8025f00c, ra == 8011c3d4
    <1>BADVADDR = 00000000, CP0_PRID = 00002d22
    Oops in fault.c:do_page_fault, line 201:
    $0 : 00000000 00000012 0000001a 0000001a 8789ff18 0000000a 00000008
      7fff7d58
    $8 : 00000000 00000000 00000000 00000000 71236429 2aaa8000 7fff77f8
      2aaa83f8
    $16: 8789ff18 7fff7d58 00000000 00000001 004009b4 00000000 00000000
      00000000
    $24: 00000000 00401638                   8789e000 8789ff08 7fff7d20
      8011c3d4
    Hi : 00000007
    Lo : 00000000
    epc  : 8025f00c    Tainted: P
    Status: 3000fc03
    Cause : 90000008

The processor is a TX4927.

-Steve
