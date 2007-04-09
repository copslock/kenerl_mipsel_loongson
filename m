Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 15:43:43 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:42167 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20022954AbXDIOnl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Apr 2007 15:43:41 +0100
Received: (qmail 22185 invoked from network); 9 Apr 2007 14:43:38 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 9 Apr 2007 14:43:38 -0000
Message-ID: <461A5157.3000908@ru.mvista.com>
Date:	Mon, 09 Apr 2007 18:44:39 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
References: <20070408113457.GB7553@alpha.franken.de> <4619245F.4030704@ru.mvista.com> <20070408230710.GA9092@alpha.franken.de> <Pine.LNX.4.64.0704091028010.1807@anakin>
In-Reply-To: <Pine.LNX.4.64.0704091028010.1807@anakin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Geert Uytterhoeven wrote:

>>>   This is certainly *not* a PCI or [E]ISA resource. It's decoded by the 
>>>*host* bridge.

>>so ? It's an IO address no device should use, because it won't work.
>>Therefore mark it busy. That's all the code does.

> Yep, it's transparently decoded ISA (which is behind PCI) to control the PCI
> bus. Just traditional PC legacy hacks :-)

    Rubbish. I was complaining about the PCI config/data ports at 0xCF8/0xCFC 
which are by no means part of either [E]ISA or PCI. They're decoded by the 
host to PCI bridge.

WBR, Sergei
