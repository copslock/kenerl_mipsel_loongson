Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 14:12:10 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:11570 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20174238AbYI1NLd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 14:11:33 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 534B73ECE; Sun, 28 Sep 2008 06:11:29 -0700 (PDT)
Message-ID: <48DF82BB.8070604@ru.mvista.com>
Date:	Sun, 28 Sep 2008 17:12:27 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE	driver
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org>
In-Reply-To: <20080928113931.GA9207@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>>>-	swarm_ide_resource.start = offset;
>>>>-	swarm_ide_resource.end = offset + size - 1;
>>>>-	if (request_resource(&iomem_resource, &swarm_ide_resource)) {

>>>   Why drop request_resource() completely? Replace it by 
>>>request_mem_region().

>>Yes, this needs fixing (otherwise everything looks good).

> No, platform_device_add which is called by platform_device_register*
> will take care of adding the resources - but only if if's told about them
> which the old driver didn't.

    Ah, I've missed that the platform device was registered without resources 
(ugh) -- request_resource() call wasn't pointless then.  Note however that 
request_mem_region() does somewhat different thing: it pins the memory 
resource for the driver, setting IORESOURCE_BUSY flag on the resource (and it 
also walks the resource tree in depth, using __request_resource() on each 
level.  That's the thing that drivers do routinely on intialization.

>   Ralf

MBR, Sergei
