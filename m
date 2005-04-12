Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 17:52:36 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:44753 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225197AbVDLQwW>; Tue, 12 Apr 2005 17:52:22 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 12 Apr 2005 12:47:55 -0400
Message-ID: <425BFCC2.9060901@timesys.com>
Date:	Tue, 12 Apr 2005 12:52:18 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com> <425AD440.5050600@timesys.com> <004a01c53ed4$dab12b00$10eca8c0@grendel> <Pine.LNX.4.61L.0504121610500.18606@blysk.ds.pg.gda.pl> <00c701c53f7e$09ec56c0$10eca8c0@grendel>
In-Reply-To: <00c701c53f7e$09ec56c0$10eca8c0@grendel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2005 16:47:55.0250 (UTC) FILETIME=[5FEA1520:01C53F7F]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:

>>On Mon, 11 Apr 2005, Kevin D. Kissell wrote:
>>
>>    
>>
>>>If the 4KC and 4KEC need it, so does the 4KSC (and 4KSD).
>>>      
>>>
>> But that's weird in the first place as 4Kc implements the original 
>>revision of MIPS32 so it does not implement "ehb".  Therefore it acts just 
>>as an ordinary "nop", but according to the 4K manual there is no need for 
>>one -- the hazard between a move to EntryLo0/EntryLo1 and tlbwi/tlbwr is 
>>explicitly listed as 0 instructions.
>>    
>>
>
>Oops.  Maybe I misread the patch.  I thought the added NOP was between
>the TLBWR and the ERET.
>  
>
No, it adds it before the TLBWR where there shouldn't be a hazard.

Greg Weeks
