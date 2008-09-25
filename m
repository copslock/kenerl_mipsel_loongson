Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 18:25:36 +0100 (BST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:43196 "EHLO
	smtp.tuxdriver.com") by ftp.linux-mips.org with ESMTP
	id S32732472AbYIYRZ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Sep 2008 18:25:29 +0100
Received: from wireless-nat-pool-rdu.redhat.com ([66.187.233.201] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <"linville@TUXDRIVER.COM"@tuxdriver.com>)
	id 1KiuaR-0002rE-Tv; Thu, 25 Sep 2008 13:25:23 -0400
Date:	Thu, 25 Sep 2008 13:24:30 -0400
From:	"John W. Linville" <linville@tuxdriver.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Message-ID: <20080925172429.GB3277@tuxdriver.com>
References: <48DABBBE.7060201@ru.mvista.com> <1222301918-3888-1-git-send-email-linville@linville-t61.local> <48DB6258.8010506@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48DB6258.8010506@ru.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <"linville@TUXDRIVER.COM"@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 25, 2008 at 02:05:12PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> John W. Linville wrote:
>
>> From: Aurelien Jarno <aurelien@aurel32.net>
>>
>> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
>> pcibios_plat_dev_init() for the BCM47xx platform.
>>
>> It fixes the regression introduced by commit
>> aab547ce0d1493d400b6468c521a0137cd8c1edf ("ssb: Add Gigabit Ethernet
>> driver").
>>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> Reviewed-by: Michael Buesch <mb@bu3sch.de>
>> Signed-off-by: John W. Linville <linville@tuxdriver.com>
>>   
>
>   Thanks for addessing my nitpicking (which you could have ignored :-).
>   I'm only seeing this patch posted on April 21st before yesterday (and  
> receiving no comments) -- probably Aurilen hasn't been persevering  
> enough for Ralf to merge it. I've been a victim of Ralf's  
> "forgetfullness" as well, so I can sympathise. :-)

Sergei, I'm sorry if I was rude to you.

Ralf, given the OpenWRT and SSB connection, I could probably merge
this series through my tree if you don't want to take it in yours
for some reason.

John
-- 
John W. Linville		Linux should be at the core
linville@tuxdriver.com			of your literate lifestyle.
