Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 21:38:38 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:26512 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225243AbTCCVih>;
	Mon, 3 Mar 2003 21:38:37 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h23LcAUe013071;
	Mon, 3 Mar 2003 13:38:16 -0800 (PST)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA00735;
	Mon, 3 Mar 2003 13:38:12 -0800 (PST)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h23LcCF25903;
	Mon, 3 Mar 2003 13:38:12 -0800
Message-Id: <200303032138.h23LcCF25903@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
cc: uhler@mips.com
Reply-To: uhler@mips.com
Subject: Re: Improper handling of unaligned user address access? 
In-reply-to: Your message of "Mon, 03 Mar 2003 22:22:31 +0100."
             <Pine.GSO.4.21.0303032219100.12650-100000@vervain.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Mar 2003 13:38:12 -0800
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips


<snip>

> > 
> >     8025f004 <cleanup_src_unaligned>:
> >     8025f004:       10c00017        beqz    a2,8025f064 <done>
> >     8025f008:       30d80003        andi    t8,a2,0x3
> >     8025f00c:       13060009        beq     t8,a2,8025f034 <copy_bytes>
> >     8025f010:       88a80000        lwl     t0,0(a1)
> > 
> > The instruction at 8025f00c is the offending instruction, however, the
>                      ^^^^^^^^
> Don't you mean 8025f010?
> 

<snip>

> >     epc == 8025f00c, ra == 8011c3c8
> >     epc  : 8025f00c    Not tainted
> >     Status: 3000fc03
> >     Cause : 90000008
> > 
> > I am using the last version of the 2.4.18 Linux/MIPS kernel. It looks
> > like there was a possible fix for this in 'arch/mips/kernel/unaligned.c'
> > by Ralf, but it did not seem to work. Any thoughts on this?
> 
> This looks like the unaligned access in a branch delay slot problem I
> experienced a while ago, where the CPU doesn't set the BD flag if the branch is
> not taken. Can you please try the patch I posted?

In this particular case, it would appear that it's not the delay slot problem.
According to the Cause value above, BD is set, and EPC has been rolled
back to point at the branch.  That all looks consistent to me.

Note that the lwl will not take an unaligned exception, and the Cause code
value indicates a TLB miss.  I don't have the full context of the problem,
but is 0xA (i.e., virtual page zero) actually a valid address?  If not,
that's the cause of the problem.

By the way, having the oops message put out the BadVAddr and PRId CP0 registers
would be very helpful.

/gmu
-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
