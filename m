Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 01:56:44 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:32527 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8224989AbVCKB43>; Fri, 11 Mar 2005 01:56:29 +0000
Received: from [10.1.100.4] ([64.164.196.27])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j2B1tuX5024249;
	Thu, 10 Mar 2005 20:55:56 -0500
Message-ID: <4230FAC9.6040304@embeddedalley.com>
Date:	Thu, 10 Mar 2005 17:56:25 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
MIME-Version: 1.0
To:	Linux Mailinglist <mailinglist.linux@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Linux 2.6 support for Brecis MSP2100 processor !
References: <77fd3fe0050308202654a4432a@mail.gmail.com>	 <20050309173044.GA18688@linux-mips.org> <77fd3fe00503101746fed176b@mail.gmail.com>
In-Reply-To: <77fd3fe00503101746fed176b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Linux Mailinglist wrote:
> Hi Ralf !
> 
> Thanks, but the problem with this SOC is that it does not have MMU. I
> would like to know wheather we have the port for Mips 4Km processor
> without MMU ?

Take a look at uclinux.org. That's the MMU-less project. I don't 
know what the MIPS statis is though.

Pete

> 
> Thanks in advance. 
> Srinivasan
> 
> 
> On Wed, 9 Mar 2005 17:30:44 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> 
>>On Tue, Mar 08, 2005 at 08:26:40PM -0800, Linux Mailinglist wrote:
>>
>>
>>>Is anybody have a port of Linux 2.6 kernel on Brecis MSP2100 processor ?
>>
>>That's not a processor but a whole SOC and the processor is a 4Km which
>>is supported.
>>
>> Ralf
>>
> 
> 
> 
