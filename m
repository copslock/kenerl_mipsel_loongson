Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 23:34:11 +0100 (BST)
Received: from uswgne22.uswest.com ([IPv6:::ffff:204.26.87.76]:31619 "EHLO
	uswgne22.uswest.com") by linux-mips.org with ESMTP
	id <S8225362AbUEQWeK>; Mon, 17 May 2004 23:34:10 +0100
Received: from egate-ne7.uswc.uswest.com (egate-ne7.uswc.uswest.com [151.117.69.18])
	by uswgne22.uswest.com (8/8) with ESMTP id i4HMY43w008532
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 17:34:05 -0500 (CDT)
Received: from wopr.qwest.net (localhost [127.0.0.1])
	by egate-ne7.uswc.uswest.com (8.12.10/8.12.10) with ESMTP id i4HMY4Tx027721
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 17:34:04 -0500 (CDT)
Received: from cyberMalex.com (igate.qwest.net [10.8.16.41])
	by wopr.qwest.net (8.11.2/8.8.7) with ESMTP id i4HMY2H29732
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 18:34:03 -0400
Message-ID: <40A93DD8.6030205@cyberMalex.com>
Date: Mon, 17 May 2004 18:34:00 -0400
From: Alexander Markley <alex@cyberMalex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031009
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: SGI O2 MIPS R5000 bootp problems
References: <40A8E08B.7070203@cyberMalex.com> <20040517161515.GA5706@umax645sx> <20040517163639.GA32507@linux-mips.org>
In-Reply-To: <20040517163639.GA32507@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <alex@cyberMalex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@cyberMalex.com
Precedence: bulk
X-list: linux-mips

 > Looks like an attempt to load an IP22 kernel into an IP32.

Yeah, that's probably it... I've learned a lot since I started this 
thread, and I'm not having any real trouble netbooting now.

Thanks all.
ttyl
--Alex

Ralf Baechle wrote:
> On Mon, May 17, 2004 at 06:15:16PM +0200, Ladislav Michl wrote:
> 
> 
>>>7536
>>>Cannot load bootp():r5000_boot.img.
>>>Range check failure: text start 0x88802000, size 0x1d70.
>>
>>                                  ^^^^^^^^^^
>>What kernel version are you running? This bug was fixed quite long ago.
>>I'd recommend using recent cvs and patch by Ilya
>>http://www.total-knowledge.com/progs/mips/patches
> 
> 
> Looks like an attempt to load an IP22 kernel into an IP32.
> 
>   Ralf
