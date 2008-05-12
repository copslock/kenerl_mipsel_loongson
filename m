Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 09:39:27 +0100 (BST)
Received: from smtp04.mtu.ru ([62.5.255.51]:31231 "EHLO smtp04.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20030494AbYELIjY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 09:39:24 +0100
Received: from smtp04.mtu.ru (localhost [127.0.0.1])
	by smtp04.mtu.ru (Postfix) with ESMTP id B389D839011;
	Mon, 12 May 2008 12:39:17 +0400 (MSD)
Received: from [127.0.0.1] (ppp83-237-118-229.pppoe.mtu-net.ru [83.237.118.229])
	(Authenticated sender: braindead@stream.ru)
	by smtp04.mtu.ru (Postfix) with ESMTP id 8DF38838D8F;
	Mon, 12 May 2008 12:39:17 +0400 (MSD)
Message-ID: <48280221.9010206@ru.mvista.com>
Date:	Mon, 12 May 2008 12:38:57 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [MIPS] Alchemy: register mmc platform device for db1200/pb1200
 boards
References: <S20024685AbYEKJEz/20080511090455Z+641267@ftp.linux-mips.org> <4826CA3C.6090809@dev.rtsoft.ru> <4827468F.8030808@roarinelk.homelinux.net>
In-Reply-To: <4827468F.8030808@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-STREAM-Metrics: smtp04.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
>> Besides, the driver as it is now, is not quite prepared to handle two 
>> MMC controllers as two different platform devices.

> Care to elaborate? If it's about the shared SD IRQ, well, that's why I 
> asked for PB1200 testers.
    I meant the driver *before* your changes -- they're not yet merged 
if I don't mistake.

>     Manuel Lauss
WBR, Sergei
