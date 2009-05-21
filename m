Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 11:39:36 +0100 (BST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:34703 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024245AbZEUKja (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 11:39:30 +0100
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 8916C94011C;
	Thu, 21 May 2009 12:39:23 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 42437940113;
	Thu, 21 May 2009 12:39:21 +0200 (CEST)
Message-ID: <4A152F58.5040905@free.fr>
Date:	Thu, 21 May 2009 12:39:20 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
References: <4A11DCBF.9000700@free.fr> <200905191522.40519.mb@bu3sch.de>
In-Reply-To: <200905191522.40519.mb@bu3sch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

Michael Buesch wrote:
> On Tuesday 19 May 2009 00:10:07 matthieu castet wrote:
>> Hi,
>>
>> this patch export ssb_watchdog_timer_set to allow to use it in a Linux 
>> watchdog driver.
>>
>>
>> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
> Well, you need to be careful. The watchdog is also used for system reboot.
> Make sure to disable the watchdog driver when the bcm47xx system code wants
> to use it.
> 
It shouldn't be a problem : the system code always disable irq before 
using watchdog to reboot/halt (unless I miss other watchdog usage).

Matthieu
