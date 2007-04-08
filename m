Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 17:58:46 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:42393 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20022706AbXDHQ6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Apr 2007 17:58:44 +0100
Received: (qmail 29864 invoked from network); 8 Apr 2007 16:57:43 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 8 Apr 2007 16:57:43 -0000
Message-ID: <46191F42.6020409@ru.mvista.com>
Date:	Sun, 08 Apr 2007 20:58:42 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de> <4618ED95.6040304@ru.mvista.com> <20070408135244.GA8016@alpha.franken.de> <4619008D.1030803@ru.mvista.com> <20070408161027.GA8265@alpha.franken.de>
In-Reply-To: <20070408161027.GA8265@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Bogendoerfer wrote:

>>   I'm just not seeing how using insert_resource() vs request_resource() 
>>   for i8259 ports can be relevant here.

> request_resource will fail, because the range is already taken by
> sni_io_resource, while insert_region inserts the resource into 
> sni_io_resource.

    No, it shouldn't according to what I'm seeing in the code.  Perhaps I'm 
missing something and need to actually try executing alike code a see...

> The problem is that init_i8259 doesn't have the right
> resource for doing the request_resource, if ioport_resource starting from
> 0x0000 is already taken by a PCI host bridge.

    I'm not at all sure that giving out I/O addresses from 0 to PCI is a great 
idea -- is it indeed necessary?

> I could probably write a
> patch, which adds a parameter to init_i8259 for the resource, where the
> request_resource is correct. No idea, whether this is worth the efford.

> Opions ?

    Did you mean options, opinions, or something else? :-)

> Thomas.

WBR, Sergei
