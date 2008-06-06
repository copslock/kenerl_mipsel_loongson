Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2008 12:45:59 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:30911 "HELO imap.sh.mvista.com")
	by ftp.linux-mips.org with SMTP id S28580514AbYFFLp5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jun 2008 12:45:57 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D7FBA3ECE; Fri,  6 Jun 2008 04:45:51 -0700 (PDT)
Message-ID: <4849236B.8060100@ru.mvista.com>
Date:	Fri, 06 Jun 2008 15:45:47 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 1.5.0.14 (Windows/20071210)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Pierre Ossman <drzeus@drzeus.cx>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] Alchemy: export get_au1x00_speed for modules
References: <20080519080339.GA21985@roarinelk.homelinux.net> <20080519080416.GB21985@roarinelk.homelinux.net> <483149E0.6010009@ru.mvista.com> <20080519094953.GA22445@roarinelk.homelinux.net> <20080605230311.7f98cd1a@mjolnir.drzeus.cx> <20080606071646.GA16498@roarinelk.homelinux.net>
In-Reply-To: <20080606071646.GA16498@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
>>>>> From 8492076e98c7fd47c9dee53984dbd9568ace357d Mon Sep 17 00:00:00 2001
>>>>> From: Manuel Lauss <mlau@msc-ge.com>
>>>>> Date: Wed, 7 May 2008 13:42:55 +0200
>>>>> Subject: [PATCH] Alchemy: export get_au1x00_speed for modules
>>>>>
>>>>> au1xmmc.c driver depends on it, so export it for modules.
>>>>>
>>>>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>>>>>
>>>>>           
>>>>   I thought that has been merged.
>>>>         
>>> Yes, Ralf merged it into linux-mips repo, but it is not yet in
>>> mainline and the rest of the patches are against linus' git.
>>>
>>>       
>> So who should push this to Linus? If this set is the only patches
>> depending on it, it would be easiest if I carry it in my tree.
>>     
>
> I'd prefer if you (Pierre) carried them all since they all depend on
> each other (kind of, anyway).  And it seems Ralf has gone silent anyway :)
>   

   Ralf has pushed this patch to Linus, and it has gone into the Linus' 
tree today.

> Thank you!
> 	Manuel Lauss
>   

WBR, Sergei
