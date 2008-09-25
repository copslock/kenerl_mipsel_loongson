Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 11:05:26 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:51781 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S30613954AbYIYKFV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 11:05:21 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3FE3C3ED0; Thu, 25 Sep 2008 03:05:16 -0700 (PDT)
Message-ID: <48DB6258.8010506@ru.mvista.com>
Date:	Thu, 25 Sep 2008 14:05:12 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	"John W. Linville" <linville@tuxdriver.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
References: <48DABBBE.7060201@ru.mvista.com> <1222301918-3888-1-git-send-email-linville@linville-t61.local>
In-Reply-To: <1222301918-3888-1-git-send-email-linville@linville-t61.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

John W. Linville wrote:

> From: Aurelien Jarno <aurelien@aurel32.net>
>
> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
> pcibios_plat_dev_init() for the BCM47xx platform.
>
> It fixes the regression introduced by commit
> aab547ce0d1493d400b6468c521a0137cd8c1edf ("ssb: Add Gigabit Ethernet
> driver").
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Michael Buesch <mb@bu3sch.de>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
>   

   Thanks for addessing my nitpicking (which you could have ignored :-).
   I'm only seeing this patch posted on April 21st before yesterday (and 
receiving no comments) -- probably Aurilen hasn't been persevering 
enough for Ralf to merge it. I've been a victim of Ralf's 
"forgetfullness" as well, so I can sympathise. :-)

WBR, Sergei
