Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 18:23:20 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:36092 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225196AbUKWSXO>; Tue, 23 Nov 2004 18:23:14 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id E651F18303; Tue, 23 Nov 2004 10:23:11 -0800 (PST)
Message-ID: <41A3800F.2010005@mvista.com>
Date: Tue, 23 Nov 2004 10:23:11 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Manish Lachwani <mlachwani@prometheus.mvista.com>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Comments in the titan ethernet driver for IP header 
 alignment
References: <20041123171421.GA30451@prometheus.mvista.com> <200411231910.02427.thomas.koeller@baslerweb.com>
In-Reply-To: <200411231910.02427.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Thomas,

Thomas Koeller wrote:
> Hi Manish,
> 
> register 0x103c is not documented in any but the newest version of
> the processor's user manual, and the function documented there has
> _nothing_ to do with header alignment. 

I agree. The document says nothing about IP header alignment. And like I 
said before, this code has been written based on feedback from the chip 
designers. I have no idea why there is not document describing this, as 
yet.

> So either the docs are wrong,
> or the register implements both the documented and undocumented
> functions. In this case, however, the code would be wrong because it
> permanently modifies the register's contents, which could screw up
> packet priority processing.

The code implements sequence of operations that are needed for the chip 
to align IP headers. Thats all. Now, if you think that this can screw up 
packet priority processing in any way, then you should point PMC about 
this potential bug. AFAIK, there are other OS's that use this register 
to fix the IP header alignment issue on the Titan.

Thanks
Manish Lachwani


> 
> Thomas
> 
> On Tuesday 23 November 2004 18:14, Manish Lachwani wrote:
> 
>>Hi Ralf,
>>
>>Attached patch puts comments around the section that programs register
>>0x103C for IP header alignment. Please review ...
>>
>>Thanks
>>Manish Lachwani
> 
> 
