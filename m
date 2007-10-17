Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 14:28:53 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:56070 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20029148AbXJQN2p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2007 14:28:45 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Ii8ty-0001lx-00; Wed, 17 Oct 2007 14:25:34 +0100
Received: from [192.168.192.25] (helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Ii8tj-0006IT-00; Wed, 17 Oct 2007 14:25:19 +0100
Message-ID: <47160D31.5080201@mips.com>
Date:	Wed, 17 Oct 2007 14:25:05 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de>
In-Reply-To: <20071017123046.GY3379@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>   
>> Nigel Stephens wrote:
>>     
>>> Could you run that gcc command manually, adding the options "-v
>>> --save-temps", and post the resulting output messages, and the user.s file.
>>>
>>>       
>> Ok, I did it except I used init/do_mounts.c file since it has at least
>> one nop load delay slot (cf label $L50 in do_mount.s)
>>     
>
> I only see a nop after the final LW, this is alignment for the next label.
>
>   

Aha, that probably explains it. Franck is using the "SDE for Linux 
v6.05" toolchain, and in that version of GCC -march=mips32r2 implies a 
default of -mtune=24k. Tuning for 24K implies -falign-loops=8 
-falign-jumps=8 and -falign-functions=8. This is undoubtedly why code 
compiled with "-march=mips32r2 -msmartmips" contains more nops than 
"-march=4ksd".nIn theory the extra nops should also disappear if you 
compile with -Os instead of -O2.

Nigel
