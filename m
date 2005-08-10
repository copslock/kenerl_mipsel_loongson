Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 16:10:21 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:15734 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225244AbVHJPKE>; Wed, 10 Aug 2005 16:10:04 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 10 Aug 2005 11:03:59 -0400
Message-ID: <42FA19BF.7040208@timesys.com>
Date:	Wed, 10 Aug 2005 11:14:07 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: 24K malta
References: <42FA03D4.5060400@timesys.com> <20050810140243.GD2840@linux-mips.org> <42FA0B9E.4030900@timesys.com> <42FA1311.4060903@timesys.com> <20050810144947.GE2840@linux-mips.org> <42FA1698.2060104@timesys.com> <20050810150934.GF2840@linux-mips.org>
In-Reply-To: <20050810150934.GF2840@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Aug 2005 15:03:59.0218 (UTC) FILETIME=[BC851D20:01C59DBC]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Wed, Aug 10, 2005 at 11:00:40AM -0400, Greg Weeks wrote:
>
>  
>
>>Now I get this:
>>
>> AS      arch/mips/kernel/r4k_switch.o
>> CC      arch/mips/kernel/vpe.o
>>{standard input}: Assembler messages:
>>{standard input}:1329: Error: unrecognized opcode `mftc0 $7,$2,4'
>>{standard input}:1333: Error: unrecognized opcode `mftc0 $6,$2,1'
>>    
>>
>
>You have CONFIG_MT enabled but your binutils don't support these new
>instructions yet.  Since you're using 4K and 24K CPUs only ATM I think
>you should simply disable CONFIG_MT for now.
>
>  
>
Just turning off the vpe loading support got me past this one. I don't 
think I have CONFIG_MT set.

[gweeks@tanith linux-8-10-05]$ grep CONFIG_MT .config
# CONFIG_MTD is not set
[gweeks@tanith linux-8-10-05]$ cd arch/mips/configs/
[gweeks@tanith configs]$ grep CONFIG_MT malta_defconfig
# CONFIG_MTD is not set
[gweeks@tanith configs]$

Greg Weeks
