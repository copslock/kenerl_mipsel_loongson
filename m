Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2008 20:18:43 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:29825 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20029388AbYEKTSl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 May 2008 20:18:41 +0100
Received: (qmail 21218 invoked from network); 11 May 2008 21:18:40 +0200
Received: from scarran.roarinelk.net (HELO ?192.168.0.242?) (192.168.0.242)
  by wormhole.roarinelk.net with SMTP; 11 May 2008 21:18:40 +0200
Message-ID: <4827468F.8030808@roarinelk.homelinux.net>
Date:	Sun, 11 May 2008 21:18:39 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
Organization: Private
User-Agent: Thunderbird 2.0.0.14 (X11/20080510)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] Alchemy: register mmc platform device for db1200/pb1200
 boards
References: <S20024685AbYEKJEz/20080511090455Z+641267@ftp.linux-mips.org> <4826CA3C.6090809@dev.rtsoft.ru>
In-Reply-To: <4826CA3C.6090809@dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:

> Besides, the driver as it is now, is not quite prepared to handle two 
> MMC controllers as two different platform devices.

Care to elaborate? If it's about the shared SD IRQ, well, that's why I 
asked for PB1200 testers.

	Manuel Lauss
