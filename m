Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 19:52:51 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:54947 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225848AbUDWSwv>; Fri, 23 Apr 2004 19:52:51 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BH5mJ-0006Ul-00; Fri, 23 Apr 2004 13:52:00 -0500
Message-ID: <408965D2.7010703@realitydiluted.com>
Date: Fri, 23 Apr 2004 14:52:02 -0400
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: santosh khare <santosh_khare2002@yahoo.com>
CC: linux-mips@linux-mips.org
Subject: Re: relocation overflow of type 4 __copy_user
References: <20040423184441.36215.qmail@web10707.mail.yahoo.com>
In-Reply-To: <20040423184441.36215.qmail@web10707.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

santosh khare wrote:
>
> When I am trying to insmod iptables.o I am getting this error multiple 
> times.
>  
> relocation overflow of type 4 __copy_user
> relocation overflow of type 4 __copy_user
> relocation overflow of type 4 __copy_user
> .........
>  
> I was getting similar errors for printk etc but they disappeared after I 
> changed the CFLAGS  for arch/mips/Makefile and included -mno-abicalls.
>
This flag is already included by default in both 2.4 and 2.6 kernels. How
did you compile your module?

-Steve
