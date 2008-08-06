Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 19:57:51 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:42724 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575597AbYHFS5r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Aug 2008 19:57:47 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id C707F320413;
	Wed,  6 Aug 2008 18:57:47 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed,  6 Aug 2008 18:57:47 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 Aug 2008 11:57:33 -0700
Message-ID: <4899F41C.5070401@avtrex.com>
Date:	Wed, 06 Aug 2008 11:57:32 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
References: <48989AFE.5000500@nortel.com> <20080805191618.GB8629@linux-mips.org>
In-Reply-To: <20080805191618.GB8629@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2008 18:57:33.0607 (UTC) FILETIME=[48D62B70:01C8F7F6]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Aug 05, 2008 at 12:25:02PM -0600, Chris Friesen wrote:
> 
>> I've run into an interesting issue with an Octeon-based board, where it  
>> just seems to hang.  I suspect we're hitting some kind of locking bug,  
>> and I'm trying to track it down.  If it matters, the kernel is quite old  
>> (heavily patched 2.6.14) and I've got no chance of upgrading it.  (The  
>> usual embedded scenario.)
>>
>> I've added some scheduler instrumentation, as well as adding a stack  
>> dump to the output of the softlockup code.
>>
>> In the trace below, is "epc" the program counter at the time of the  
>> timer interrupt?  How does "ra" fit into this, given that the function  
>> whose address it contains isn't seen in the stack trace until quite a  
>> ways down?
> 
> $LBB378 is an internal symbol.  The value of RA may not be very informative
> if it was overwritten by a random subroutine call.
> 

I have thought about eliminating these internal labels when the module's symbols are read.  Would this make any sense?

David Daney
