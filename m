Received:  by oss.sgi.com id <S42401AbQIOWbl>;
	Fri, 15 Sep 2000 15:31:41 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:3827 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42366AbQIOWbY>;
	Fri, 15 Sep 2000 15:31:24 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id PAA24914;
	Fri, 15 Sep 2000 15:31:24 -0700
Message-ID: <39C2A33C.EF90FFDB@mvista.com>
Date:   Fri, 15 Sep 2000 15:31:24 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
CC:     dan@netx4.com
Subject: Re: trap handler for unaligned memory read/write
References: <39C29018.9389FBCE@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


As usual, I am replying to my own question.  Maybe I was asking to soon
... :-)

I found some drivers offer an copy-only-tiny-buffer which will copy
small packets (for what purpose?).  Apparently after the copying the
misalignment disappears.  So MIPS, you just set a high copy_break_size
so that a copying always happens.

In fact this is what is done for other non-x86 architectures in tulip
drivers.

Jun

Jun Sun wrote:
> 
> I was trying to run some PCI ether drivers and always got bus error, at
> least when I use ipconfig bootp code.
> 
> However, the problem seems to be generic.
> 
> Ethernet device writes a whole packet in the memory.  Driver and network
> stack code often directly dereference a pointer in to the packet.
> However, the ether header is 14 byte long.  If you align packet from the
> beginning, then IP header will be off-aligned.
> 
> Any suggestions?
> 
> If this is a valid problem, I think the long term solution should be in
> network code, which should not assume they can dereference on an
> unaligned address.
> 
> For short-term solutions, we can have trap handler that supports the
> unaligned read/write.  Does anybody know if there is such a trap handler
> for MIPS?
> 
> Thanks.
> 
> Jun
