Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2006 14:35:06 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:11586 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S8133932AbWGXNdJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2006 14:33:09 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1D3FA3ECD; Mon, 24 Jul 2006 06:32:44 -0700 (PDT)
Message-ID: <44C4CBB4.3030501@ru.mvista.com>
Date:	Mon, 24 Jul 2006 17:31:32 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Daniel Mack <daniel@caiaq.de>
Cc:	giometti@linux.it, i2c@lm-sensors.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] AU1100 I2C support
References: <20060719180204.GK25330@enneenne.com> <20060722091342.GA22158@ipxXXXXX> <20060722123243.GA4543@gundam.enneenne.com> <133FC0BA-B375-46D4-916E-773996425F57@caiaq.de>
In-Reply-To: <133FC0BA-B375-46D4-916E-773996425F57@caiaq.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Daniel Mack wrote:

>> On Sat, Jul 22, 2006 at 11:13:42AM +0200, Daniel Mack wrote:

>>> Is there any reason why it is limited to this very processor and
>>> should not work with all au1xxx types?

>> To be honest I don't know exacly... I don't know so well other
>> processors in this family. However I think at least au1000 and au1200
>> should be compatible.

> I think so, too. Since you only call the generic au_* functions for
> the GPIO access, all members of this processor family should be
> supported. I propose to change the patch accordingly.

    Actually, Au1550/1200 have dedicated SMBus contoller and an existing I2C 
driver for it, so there''s probably no need for another bit-banging driver for 
them.

> Daniel

WBR, Sergei
