Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2005 07:44:04 +0000 (GMT)
Received: from smtp003.bizmail.yahoo.com ([IPv6:::ffff:216.136.130.195]:55201
	"HELO smtp003.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8225428AbVCWHnt>; Wed, 23 Mar 2005 07:43:49 +0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp003.bizmail.yahoo.com with SMTP; 23 Mar 2005 07:43:45 -0000
Message-ID: <42411E34.2080606@embeddedalley.com>
Date:	Tue, 22 Mar 2005 23:43:48 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Off by two error in au1000/common/setup.c?
References: <200503221531.46186.eckhardt@satorlaser.com> <424059E2.201@embeddedalley.com> <200503230836.29948.eckhardt@satorlaser.com>
In-Reply-To: <200503230836.29948.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Pete Popov wrote:
> 
>>>// in au1000.h
>>>#define Au1500_PCI_MEM_START      0x440000000ULL
>>>#define Au1500_PCI_MEM_END        0x44FFFFFFFULL
>>>
>>>// in setup.c
>>>start = (u32)Au1500_PCI_MEM_START;
>>>end = (u32)Au1500_PCI_MEM_END;
>>>/* check for pci memory window */
>>>if ((phys_addr >= start) && ((phys_addr + size) < end)) {
>>> return (phys_addr - start) + Au1500_PCI_MEM_START;
>>>}
>>>
>>>For the (unlikely?) case that I want to use a size of 0x0 1000 0000,
>>>'phys_addr+size == end+1'. IOW I need 'phys_addr+size-1' to get the last
>>>address and use '<= end' to compare with the last valid address in the
>>>range.
>>>
>>>Right?
>>
>>But the a size of 0x0 1000 0001 would pass the test since phys_addr +
>>1000 0001 - 1 <= end.
> 
> 
> Really?
> 0x4 4000 0000 + 0x0 1000 0001 - 1 = 0x4 5000 0000 > 0x4 ffff ffff
> ;)

Yeh, I was already thinking about end==0x4 5000 0000 ...

>>How about if I just make MEM_END 0x450000000 and the check " <= end" ?
> 
> 
> I'm not sure, it's a question of consistency: that solution would be the 
> one-past-the-end address, which I'm fine with (being used to C++'s STL-style 
> iterators..). The only problem I see arises if that one-past-the-end actually 
> wraps around.
> Other than that, what is used generally, first and last valid address or first 
> valid address and first not valid address? Or first valid address and size?

I'll check it out tomorrow.

Pete
