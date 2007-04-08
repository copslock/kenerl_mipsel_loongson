Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 15:47:48 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:19087 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20022697AbXDHOrr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Apr 2007 15:47:47 +0100
Received: (qmail 28843 invoked from network); 8 Apr 2007 14:46:42 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2007 14:46:42 -0000
Message-ID: <4619008D.1030803@ru.mvista.com>
Date:	Sun, 08 Apr 2007 18:47:41 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de> <4618ED95.6040304@ru.mvista.com> <20070408135244.GA8016@alpha.franken.de>
In-Reply-To: <20070408135244.GA8016@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Bogendoerfer wrote:

>>   If you read the comment to insert_resource() you'll see that it works 
>>contrarywise, i. e. the inserted resource is made parent of the conflicting 
>>ones. I.e. it should't work as you're intending it to.

> why don't you think I haven't testet this ?

> 00000000-03bfffff : PCIT IO
>   00000000-0000001f : dma1
>   00000020-00000021 : pic1
>   00000040-0000005f : timer
>   00000060-0000006f : keyboard
>   00000080-0000008f : dma page reg
>   000000a0-000000a1 : pic2
>   000000c0-000000df : dma2
>   000002f8-000002ff : serial
>   000003c0-000003df : cirrusfb
>   000003f8-000003ff : serial
>   00000c80-00000c83 : EISA device @@@0000
>   00000cf8-00000cfb : PCI config addr
>   00000cfc-00000cff : PCI config data
>   00001000-000010ff : Madge Smart 16/4 EISA Ringnode
>   00001400-000014ff : Madge Smart 16/4 EISA Ringnode
>   00001800-000018ff : Madge Smart 16/4 EISA Ringnode
>   00001c00-00001cff : Madge Smart 16/4 EISA Ringnode

> that's exactly what I wrote.

    I'm just not seeing how using insert_resource() vs request_resource() for 
i8259 ports can be relevant here.

> Thomas.

WBR, Sergei
