Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 18:40:15 +0000 (GMT)
Received: from 67-129-173-13.dia.static.qwest.net ([67.129.173.13]:54909 "EHLO
	alfalfa.fortresstech.com") by ftp.linux-mips.org with ESMTP
	id S8133418AbWCQSj7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 18:39:59 +0000
Received: from [172.26.52.4] ([172.26.52.4]) by alfalfa.fortresstech.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 17 Mar 2006 13:49:22 -0500
Message-ID: <441B04AC.3090406@fortresstech.com>
Date:	Fri, 17 Mar 2006 13:49:16 -0500
From:	Steve Lazaridis <slaz@fortresstech.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: au1550 oprofile
References: <441A1D53.6080305@fortresstech.com> <20060317145657.GD3771@linux-mips.org>
In-Reply-To: <20060317145657.GD3771@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2006 18:49:22.0128 (UTC) FILETIME=[8144AD00:01C649F3]
Return-Path: <SLaz@fortresstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slaz@fortresstech.com
Precedence: bulk
X-list: linux-mips

Thats true,
But my problem is that timer mode isn't even working

Ralf Baechle wrote:
> On Thu, Mar 16, 2006 at 09:22:11PM -0500, Steve Lazaridis wrote:
> 
>> Has anyone successfully ran oprofile on an au1550?
>> If so, was it in BigEndian mode?
>>
>> Are there any known issues with oprofile on au1xxx platforms?
> 
> Alchemy processors don't implement performance counters, so there are
> by definition no issues ;-)  That unfortunately means you're stuck
> with timer mode.
> 
>   Ralf
