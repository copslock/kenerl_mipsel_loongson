Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 01:47:41 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:23022 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225228AbVBHBr0>; Tue, 8 Feb 2005 01:47:26 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id AB827189DA; Mon,  7 Feb 2005 17:47:24 -0800 (PST)
Message-ID: <42081A2C.5060503@mvista.com>
Date:	Mon, 07 Feb 2005 17:47:24 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	TheNop <TheNop@gmx.net>, linux-mips@linux-mips.org
Subject: Re: Kernel crash on yosemite
References: <4207F163.4010605@gmx.net> <20050208013000.GA6131@linux-mips.org>
In-Reply-To: <20050208013000.GA6131@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Mon, Feb 07, 2005 at 11:53:23PM +0100, TheNop wrote:
>
>  
>
>>This is my configuration:
>>~ yosemite board with RM9000 chip revision 1.1
>>~ BusyBox 1.0
>>~ Kernel 2.6.8.1
>>
>>When I try to copy a large file (~ 3,5 Mb) within the NFS file system 
>>the kernel crashs without any output on the console.
>>It could be a problem with the titan_ge driver, but I have no idee how 
>>to solve the problem.
>>
>>What can I do?
>>    
>>
>
>There have been various fixes to the network driver since then so I
>recommend you upgrade your kernel.  One problem you're going to encounter
>with recent kernels is that they only support the Titan 1.2 part which I
>think are the ones in volume production.
>
>  Ralf
>
>  
>
However, adding support for Titan 1.0 and 1.1 in the GE driver should be 
fairly straight forward.

Thanks
Manish Lachwani
