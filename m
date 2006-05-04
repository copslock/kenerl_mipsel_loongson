Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 18:11:22 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:18334 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133518AbWEDRLI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 18:11:08 +0100
Received: (qmail 28949 invoked from network); 4 May 2006 21:16:09 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 May 2006 21:16:09 -0000
Message-ID: <445A356A.9010701@ru.mvista.com>
Date:	Thu, 04 May 2006 21:10:02 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Porting Au1x000 USB host controller on u-boot
References: <20060504095341.GB19913@gundam.enneenne.com> <445A347A.5050507@ru.mvista.com>
In-Reply-To: <445A347A.5050507@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello,

Sergei Shtylyov wrote:

>> I'm trying to implement support for USB host into u-boot. I
>> initialized the USB controller just as linux does, the EDs and the TDs
>> look like good in memory but the controller seems not well reading
>> them and on the bus I see random USB messages...

>> I think that there could be some problem on memory coherency... some
>> suggestion?

>    Be sure to set Config0.OD (bit 19), it's proven to fix the 
> USB-related lockups on Au1500 at least. See arch/mips/common/cputable.c 

    arch/mips/au1000/common/cputable.c, I mean... :-)

WBR, Sergei
