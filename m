Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 15:46:48 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:23393 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S30635263AbYIYOiu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 15:38:50 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 83B223ED1; Thu, 25 Sep 2008 07:38:43 -0700 (PDT)
Message-ID: <48DBA2AE.8020304@ru.mvista.com>
Date:	Thu, 25 Sep 2008 18:39:42 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	"John W. Linville" <linville@tuxdriver.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
References: <48DABBBE.7060201@ru.mvista.com> <1222301918-3888-1-git-send-email-linville@linville-t61.local> <48DB6258.8010506@ru.mvista.com> <48DB84F8.7050806@aurel32.net>
In-Reply-To: <48DB84F8.7050806@aurel32.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Aurelien Jarno wrote:

>>>This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
>>>pcibios_plat_dev_init() for the BCM47xx platform.

>>>It fixes the regression introduced by commit
>>>aab547ce0d1493d400b6468c521a0137cd8c1edf ("ssb: Add Gigabit Ethernet
>>>driver").

>>>Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>>Reviewed-by: Michael Buesch <mb@bu3sch.de>
>>>Signed-off-by: John W. Linville <linville@tuxdriver.com>

>>   Thanks for addessing my nitpicking (which you could have ignored :-).
>>   I'm only seeing this patch posted on April 21st before yesterday (and 
>>receiving no comments) -- probably Aurilen hasn't been persevering 
>>enough for Ralf to merge it. I've been a victim of Ralf's 
>>"forgetfullness" as well, so I can sympathise. :-)

> You probably forget messages like:
> http://www.linux-mips.org/archives/linux-mips/2008-05/msg00300.html
> http://www.linux-mips.org/archives/linux-mips/2008-06/msg00128.html

    Yes, I have overlooked these since they had different subject.

> and the numerous IRC pings.

    I've been thru that before. :-)

WBR, Sergei
