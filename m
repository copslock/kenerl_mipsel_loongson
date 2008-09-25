Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 13:33:13 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:17318 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S30636215AbYIYMdI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 13:33:08 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1Kiq1m-0006z2-1e; Thu, 25 Sep 2008 14:33:02 +0200
Message-ID: <48DB84F8.7050806@aurel32.net>
Date:	Thu, 25 Sep 2008 14:32:56 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	"John W. Linville" <linville@tuxdriver.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
References: <48DABBBE.7060201@ru.mvista.com> <1222301918-3888-1-git-send-email-linville@linville-t61.local> <48DB6258.8010506@ru.mvista.com>
In-Reply-To: <48DB6258.8010506@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov a écrit :
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
>    Thanks for addessing my nitpicking (which you could have ignored :-).
>    I'm only seeing this patch posted on April 21st before yesterday (and 
> receiving no comments) -- probably Aurilen hasn't been persevering 
> enough for Ralf to merge it. I've been a victim of Ralf's 
> "forgetfullness" as well, so I can sympathise. :-)

You probably forget messages like:
http://www.linux-mips.org/archives/linux-mips/2008-05/msg00300.html
http://www.linux-mips.org/archives/linux-mips/2008-06/msg00128.html

and the numerous IRC pings.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
