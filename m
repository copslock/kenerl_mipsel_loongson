Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 19:57:25 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:24291
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225243AbTCCT5Y>; Mon, 3 Mar 2003 19:57:24 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 18pw3u-0000QT-00
	for <linux-mips@linux-mips.org>; Mon, 03 Mar 2003 13:57:22 -0600
Message-ID: <3E63B17C.8000403@realitydiluted.com>
Date: Mon, 03 Mar 2003 13:48:12 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Improper handling of unaligned user address access?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Greetings.

I am having some issues using 'copy_from_user' in a driver. The issue
is that instead of returning a EFAULT for a bad address, it throws a
kernel panic and then proceeds to segfault the application. I am doing
a test on the module where I pass in an invalid user source address:

    copy_from_user(&dst, src, sizeof(dst));

where 'src' is equal to '0xa'. Now for the interesting part. When it
goes to do the copy, in 'arch/mips/lib/memcpy.S' it correctly jumps
to 'src_unaligned_dst_aligned' and then to 'cleanup_src_unaligned'
and we have the following code:

    8025f004 <cleanup_src_unaligned>:
    8025f004:       10c00017        beqz    a2,8025f064 <done>
    8025f008:       30d80003        andi    t8,a2,0x3
    8025f00c:       13060009        beq     t8,a2,8025f034 <copy_bytes>
    8025f010:       88a80000        lwl     t0,0(a1)

The instruction at 8025f00c is the offending instruction, however, the
kernel oops that kills the process shows:

    Unable to handle kernel paging request at virtual address 0000000a,
    epc == 8025f00c, ra == 8011c3c8
    Oops in fault.c:do_page_fault, line 199:
    $0 : 00000000 00000012 0000001a 0000001a 87887f10 0000000a 00000008 
00000001
    $8 : 00000000 00000000 00000000 00001116 802ec2f0 fffffffe ffffffff 
00000010
    $16: 0000000a 7fff7d68 87887f10 00000000 004009b4 00000000 00000000 
00000000
    $24: 00000000 87887e18                   87886000 87887f00 7fff7d30 
8011c3c8
    Hi : 00000000
    Lo : 00000000
    epc  : 8025f00c    Not tainted
    Status: 3000fc03
    Cause : 90000008

I am using the last version of the 2.4.18 Linux/MIPS kernel. It looks
like there was a possible fix for this in 'arch/mips/kernel/unaligned.c'
by Ralf, but it did not seem to work. Any thoughts on this?

-Steve
