Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2008 11:28:37 +0100 (BST)
Received: from smtp02.mtu.ru ([62.5.255.49]:30962 "EHLO smtp02.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20026699AbYEKK2e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 11 May 2008 11:28:34 +0100
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 51D474CD86;
	Sun, 11 May 2008 14:28:24 +0400 (MSD)
Received: from [127.0.0.1] (ppp83-237-119-243.pppoe.mtu-net.ru [83.237.119.243])
	(Authenticated sender: braindead@stream.ru)
	by smtp02.mtu.ru (Postfix) with ESMTP id 37B844CBAF;
	Sun, 11 May 2008 14:28:24 +0400 (MSD)
Message-ID: <4826CA3C.6090809@dev.rtsoft.ru>
Date:	Sun, 11 May 2008 14:28:12 +0400
From:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Alchemy: register mmc platform device for db1200/pb1200
 boards
References: <S20024685AbYEKJEz/20080511090455Z+641267@ftp.linux-mips.org>
In-Reply-To: <S20024685AbYEKJEz/20080511090455Z+641267@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <sshtylyov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hello.

linux-mips@linux-mips.org wrote:
> Author: Manuel Lauss <mlau@msc-ge.com> Wed May 7 14:59:45 2008 +0200
> Comitter: Ralf Baechle <ralf@linux-mips.org> Sun May 11 09:26:01 2008 +0100
> Commit: f75a5c99879aa28a8f29fa08ed11395614f8311e
> Gitweb: http://www.linux-mips.org/g/linux/f75a5c99
> Branch: master
>
> Register the mmc platform device for db1200/pb1200 boards, with
> board-specific card detect/readonly facilities wrapped in platform data.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>   
   Gah, I had comments to this patch and expected Manuel to address 
them. Besides, the driver as it is now, is not quite prepared to handle 
two MMC controllers as two different platform devices.

WBR, Sergei
