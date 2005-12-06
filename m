Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 18:03:45 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:18231 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133676AbVLFSDT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 18:03:19 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB6I30t18507;
	Tue, 6 Dec 2005 22:03:01 +0400
Message-ID: <4395D254.9060203@ru.mvista.com>
Date:	Tue, 06 Dec 2005 21:03:00 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: Re: [PATCH] Philips PNX8550 ip3106 driver deadlock fix
References: <4395D05C.9060408@ru.mvista.com> <20051206180035.GG2698@linux-mips.org>
In-Reply-To: <20051206180035.GG2698@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Tue, Dec 06, 2005 at 08:54:36PM +0300, Vladimir A. Barinov wrote:
>
>  
>
>>This is a patch that fixes spin_lock deadlock in serial ip3106 driver.
>>The spin_lock_irq(&port->lock,flags) is already called in generic driver 
>>serial_core.c before
>>port->ops->start_tx().
>>So the second call of spin_lock_irq(&port->lock, flags) leads to 
>>deadlock. This could be verified in PREEMPT_DESCTOP case when
>>these options are enabled:
>>CONFIG_DEBUG_PREEMPT=y
>>CONFIG_DEBUG_SPINLOCK=y
>>    
>>
>
>Serial drivers are maintained by rmk+serial@arm.linux.org.uk, please send
>to him.
>  
>
Ok, thank you.

>  Ralf
>
>
>  
>
