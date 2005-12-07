Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 19:40:34 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:62016 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133554AbVLGTkO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Dec 2005 19:40:14 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB7Jdnt27284;
	Wed, 7 Dec 2005 23:39:50 +0400
Message-ID: <43973A84.3090306@ru.mvista.com>
Date:	Wed, 07 Dec 2005 22:39:48 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Peter Popov <ppopov@embeddedalley.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips PNX8550
References: <20051207191100.20648.qmail@web410.biz.mail.mud.yahoo.com>
In-Reply-To: <20051207191100.20648.qmail@web410.biz.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi Pete,

>  
>
>>I used a quite different board (STB810), but it's
>>based on the same board dependent code as JBS (i.e
>>arch/mips/philips/pnx8550/jbs). I haven't 
>>worked with
>>JBS board and I'm not sure if slot=10 is needed for
>>that, but it's really necessary for STB810.
>>    
>>
>
>The JBS has only 3 pci slots and I tested all three.
>So the fourth one you added won't do any damage but
>it's not quite right either. 
>
>  
>
>>I also has another question - Could you please
>>advice: shall I create a different
>>arch/mips/philips/pnx8550/stb810
>>and add MACH_PHILIPS_STB810 ID and defconfig
>>or I can use exiting JBS one?
>>    
>>
>
>Is anything else different that would justify the new
>directory? If not, perhaps we just need an STB board
>selection in arch/mips/Kconfig, a defconfig, and an
>ifdef around that pci slot you sent.
>  
>
The are only 3 small file in the  arch/mips/philips/pnx8550/jbs directory:
1)  board_setup.c is the same for STB810
2) init.c may be needs cosmetic changes to identify the board:
"Philips PNX8550/JBS" -> "Philips PNX8550/STB810"
MACH_PHILIPS_JBS -> MACH_PHILIPS_STB810

I'm not sure are they really needed?
3) irq.map needs change to add slot 10 and remove slot 17 for STB810 board.

That's all :)

>BTW, regarding your serial driver patch ... I have one
>outstanding change (small) I still have to make, as
>requested by rmk. Mind if I forward that email to you
>so you can take care of it :)?
>  
>
Yes, please.

Vladimir
