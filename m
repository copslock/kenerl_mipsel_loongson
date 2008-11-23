Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2008 17:11:04 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:48270 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23850571AbYKWRK6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Nov 2008 17:10:58 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1E0DE3EC9; Sun, 23 Nov 2008 09:10:51 -0800 (PST)
Message-ID: <49298E92.9070605@ru.mvista.com>
Date:	Sun, 23 Nov 2008 20:10:42 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Chad Reese <kreese@caviumnetworks.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com> <49280FC5.3040608@ru.mvista.com> <49282187.8090602@ru.mvista.com> <492851BA.3060306@caviumnetworks.com> <4929730B.2070904@ru.mvista.com> <492975B9.2000807@ru.mvista.com>
In-Reply-To: <492975B9.2000807@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>> +     * stoppng and restarting the DMA, we'll let the hardware do 
>>> it. If the
>>
>>   stopping
>>
>>> +     * DMA is really stopped early due to an error condition, a later
>
>   I'm not sure which error condition is meant here: ERR=1 in the 
> status register, some internal DMA error, both?
>
>>> +     * timeout will force us to stop.
>>
>>   Sigh... So any command error will result in a timeout. I wonder 
>> what hardware genius decided that CF doesn't need an IRQ...

   Ah, I forgot thet libata should be supporting polling mode, so should 
handle ERR=1 case. In this case the comment about the timeout 
contradicts your words about an interrupt being generated on DMA error.

>   So, Octeon DMA can actually generate an error interrupt?

MBR, Sergei
