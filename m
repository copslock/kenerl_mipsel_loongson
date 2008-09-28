Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 13:50:59 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:43825 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20041068AbYI1MuP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 13:50:15 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id AE2B13ECB; Sun, 28 Sep 2008 05:50:10 -0700 (PDT)
Message-ID: <48DF7DBC.1080804@ru.mvista.com>
Date:	Sun, 28 Sep 2008 16:51:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	bzolnier@gmail.com, linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE	driver
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <20080928114711.GB9207@linux-mips.org>
In-Reply-To: <20080928114711.GB9207@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>>+{

>>[...]

>>>+	pdev = platform_device_register_simple(DEV_NAME, -1,
>>>+		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));

>>  If you have the resources as static array anyway, why not have the  
>>device in the static variable too and use platform_device_register()?

> It saves a few lines of code.

    And wastes few words of static data since 
platform_device_register_simple() will kmalloc() the resources and do a copy 
from these resources after which they are not needed -- so, it's worth making 
swarm_ide_resource[] __initdata at least.
    If you were using platform_device_register() with static platform device, 
no memory allocation would have happened, and no data would have been wasted.

WBR, Sergei
