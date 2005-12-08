Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2005 17:26:46 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:32584 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133480AbVLHR0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Dec 2005 17:26:24 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB8HQHt28073;
	Thu, 8 Dec 2005 21:26:17 +0400
Message-ID: <43986CB8.9000000@ru.mvista.com>
Date:	Thu, 08 Dec 2005 20:26:16 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org, ppopov@embeddedalley.com
CC:	linux-mips@linux-mips.org
Subject: [Fwd: Re: [PATCH] Philips PNX8550 command line patch]
Content-Type: multipart/mixed;
 boundary="------------050707090104000905020304"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050707090104000905020304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, but it seems that this mail was lost :(
resending...

--------------050707090104000905020304
Content-Type: message/rfc822;
 name="Re: [PATCH] Philips PNX8550 command line patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [PATCH] Philips PNX8550 command line patch"

Message-ID: <43986714.2020806@ru.mvista.com>
Date: Thu, 08 Dec 2005 20:02:12 +0300
From: "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Popov <ppopov@embeddedalley.com>
CC: Ralf Baechle <ralf@linux-mips.org>, 
 "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Philips PNX8550 command line patch
References: <20051206192105.32325.qmail@web403.biz.mail.mud.yahoo.com>
In-Reply-To: <20051206192105.32325.qmail@web403.biz.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Pete, Ralf,

Peter Popov wrote:

>--- Ralf Baechle <ralf@linux-mips.org> wrote:
>
>  
>
>>On Tue, Dec 06, 2005 at 09:02:14PM +0300, Vladimir
>>A. Barinov wrote:
>>
>>    
>>
>>>This patch makes passing command line from
>>>      
>>>
>>bootloader for Philips 
>>    
>>
>>>PNX8550 platform.
>>>Does it makes sense to commit this patch?
>>>      
>>>
>>Looks ok at a quick glance.  I'll wait a bit so Pete
>>has a chance to comment.
>>    
>>
>
>Looks fine to me.
>  
>
Sorry for my misunderstood but I suppose that this patch should be 
ignored since it
used JBS board dependent code and I have STB810 that based on the code 
of JBS.
But JBS board could have firmware that differs from that STB810 uses. So 
the command line
could be parsed incorrectly for JBS, it's needed to check by somebody 
who has JBS board.

I prepared STB810 board dependent patch that include this fix for 
command-line parsing for STB810 board only.
So Ralf please ignore this patch though it was approved by you and Pete.

Vladimir



--------------050707090104000905020304--
