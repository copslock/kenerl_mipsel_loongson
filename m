Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 May 2003 15:01:29 +0100 (BST)
Received: from bay8-f66.bay8.hotmail.com ([IPv6:::ffff:64.4.27.66]:63751 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225211AbTEDOB1>;
	Sun, 4 May 2003 15:01:27 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 4 May 2003 07:01:16 -0700
Received: from 211.150.239.139 by by8fd.bay8.hotmail.msn.com with HTTP;
	Sun, 04 May 2003 14:01:16 GMT
X-Originating-IP: [211.150.239.139]
X-Originating-Email: [michael_e_guo@hotmail.com]
From: "Guo Michael" <michael_e_guo@hotmail.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: linux_2_4 on RM7000
Date: Sun, 04 May 2003 22:01:16 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <BAY8-F66OgRGkQ6mByS0000fd73@hotmail.com>
X-OriginalArrivalTime: 04 May 2003 14:01:16.0851 (UTC) FILETIME=[A186B830:01C31245]
Return-Path: <michael_e_guo@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_e_guo@hotmail.com
Precedence: bulk
X-list: linux-mips

I've found the problem, I should define CONFIG_BOARD_SCACHE and 
CONFIG_RM7000_CPU_SCACHE first, right? But it still said scache_way_size is 
undefined in sc-rm7k.c and the printk on line 143 in rm7k_sc_probe need a 
little fix. After I fixed these it works.

Thanks.



>From: Ralf Baechle <ralf@linux-mips.org>
>To: Guo Michael <michael_e_guo@hotmail.com>
>CC: linux-mips@linux-mips.org
>Subject: Re: linux_2_4 on RM7000
>Date: Sun, 4 May 2003 15:16:22 +0200
>
>On Sun, May 04, 2003 at 11:15:40AM +0800, Guo Michael wrote:
>
> >      I've been using the kernel from linux-mips.org on my board with 
RM7000
> > CPU for several month with no problem. I checked out a new copy from
> > linux-mips.org recently and found the cache code had been rewritten all
> > over the place, and the new file sc-rm7k.c cannot even compile. After a
> > quick check on that file according to the error messages it seems that
> > nobody has even tried to compile this file.
> >
> > My question is: does the new cache code work with rm7k cpu now? or in 
the
> > future?  anybody tried that on rm7k with success?
>
>Somehow you're the only one to complain.  Details?
>
>   Ralf
>


_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn  
