Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 22:58:12 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:19937 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28578195AbYHGV6F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 22:58:05 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id E6B9A320024;
	Thu,  7 Aug 2008 21:58:09 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu,  7 Aug 2008 21:58:09 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 Aug 2008 14:57:53 -0700
Message-ID: <489B6FDF.9070900@avtrex.com>
Date:	Thu, 07 Aug 2008 14:57:51 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org,
	Thiemo Seufer <ths@networkno.de>
Subject: Re: looking for help interpreting softlockup/stack trace
References: <48989AFE.5000500@nortel.com> <20080805191618.GB8629@linux-mips.org> <4899F41C.5070401@avtrex.com> <20080807134323.GA15703@linux-mips.org>
In-Reply-To: <20080807134323.GA15703@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Aug 2008 21:57:53.0128 (UTC) FILETIME=[A42FCE80:01C8F8D8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Aug 06, 2008 at 11:57:32AM -0700, David Daney wrote:
> 
>>>> In the trace below, is "epc" the program counter at the time of the   
>>>> timer interrupt?  How does "ra" fit into this, given that the 
>>>> function  whose address it contains isn't seen in the stack trace 
>>>> until quite a  ways down?
>>> $LBB378 is an internal symbol.  The value of RA may not be very informative
>>> if it was overwritten by a random subroutine call.
>>>
>> I have thought about eliminating these internal labels when the module's symbols are read.  Would this make any sense?
> 
> I think so.  Maybe that could even be done when the module is linked.  I
> don't think there are ever any relocations against these local symbols.
> Thiemo?
> 

I take it back.  Most of the $LC... symbols (typically string constants) are needed for relocations.  Currently I cannot find in my builds any $LB... symbols.  I wonder if gcc-4.3 eliminates these.

I think the reason they show up in stack traces is that they are data pointers that have been stored on the stack that are misinterpreted as function return addresses.


I wonder what would happen if we compiled all the code with -funwind-tables and had a small DWARF2 unwinder ala GCC's C++ exception handling mechanism.  That would allow exact stack traces with no runtime overhead.  

David Daney
