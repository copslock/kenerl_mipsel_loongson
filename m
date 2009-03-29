Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 21:48:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:35467 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021871AbZC2UsK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Mar 2009 21:48:10 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 681A53EC9; Sun, 29 Mar 2009 13:48:06 -0700 (PDT)
Message-ID: <49CFDE82.4030606@ru.mvista.com>
Date:	Mon, 30 Mar 2009 00:48:02 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>	<49CF5CE6.1070003@ru.mvista.com> <20090329143802.0a09baca@scarran.roarinelk.net> <49CF71BE.2070109@ru.mvista.com>
In-Reply-To: <49CF71BE.2070109@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>> Patch overview:
>>>>
>>>> #1: eliminate alchemy/common/platform.c.  Add platform device
>>>>     registration to all boards instead.
>>>>         
>>>   I'm strongly voting against this, as it causes totally unneeded 
>>> code duplication. Please don't apply.    
>>
>> I know it seems like a lot of unecessary duplication.  My reasons for
>> doing this are
>>
>> a) I want to get rid of the various cpu-type specific config symbols,
>>    (i.e. I want one kernel binary to run on 2 or more Alchemy boards
>>    with different cpu models.  There's no technical reason this
>>    shouldn't work.  The OHCI block for instance has different addresses
>>    on pre-Au1200 silicon; the easiest solution to that (for me) is
>>    to simply move device registration to the boards that need/want 
>> it.)   
>
>   Well, then create several files (like 
> arch/mips/alchemy/common/au1200.c) for SoC specific platfrom device 
> sets variations but don't move all platform devices into the board 
> files. This will be a cleaner solution.

   Another solution would be "tuning up" the platform device resources 
depending on the detected SoC type.

>>     have a chance to get your approval on this, so I can stop wasting
>>     my and everybody else's time as soon as possible).
>>   
>    (BTW, what do you think about this?  Please tell me now if I ever
>
>  Single kernel binary? If it's at all possible, I am all for it.

   That doesn't mean however that SoC type options need to go -- we 
could allow the user a flexibility (like is curretnly done on ARM 
DaVinci) of choosing an arbotrary set of supported SoCs, so that he 
could have the choice to exclude the code for the ones he doesn't need.

WBR, Sergei
