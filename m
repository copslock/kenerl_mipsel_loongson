Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 17:46:29 +0000 (GMT)
Received: from smtp006.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.83]:41149
	"HELO smtp006.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8227050AbVCVRqN>; Tue, 22 Mar 2005 17:46:13 +0000
Received: from unknown (HELO ?127.0.0.1?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp006.bizmail.sc5.yahoo.com with SMTP; 22 Mar 2005 17:46:08 -0000
Message-ID: <424059E2.201@embeddedalley.com>
Date:	Tue, 22 Mar 2005 09:46:10 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Off by two error in au1000/common/setup.c?
References: <200503221531.46186.eckhardt@satorlaser.com>
In-Reply-To: <200503221531.46186.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:

>Hi!
>
>Could someone take a look at these lines from fixup_bigphys_addr():
>
> // in au1000.h
> #define Au1500_PCI_MEM_START      0x440000000ULL
> #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
>
> // in setup.c
> start = (u32)Au1500_PCI_MEM_START;
> end = (u32)Au1500_PCI_MEM_END;
> /* check for pci memory window */
> if ((phys_addr >= start) && ((phys_addr + size) < end)) {
>  return (phys_addr - start) + Au1500_PCI_MEM_START;
> }
>
>For the (unlikely?) case that I want to use a size of 0x0 1000 0000, 
>'phys_addr+size == end+1'. IOW I need 'phys_addr+size-1' to get the last 
>address and use '<= end' to compare with the last valid address in the range.
>
>Right?
>  
>
But the a size of 0x0 1000 0001 would pass the test since phys_addr + 
1000 0001 - 1 <= end.

How about if I just make MEM_END 0x450000000 and the check " <= end" ?

Pete
