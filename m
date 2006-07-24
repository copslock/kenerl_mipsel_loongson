Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2006 11:31:01 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:15884 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133454AbWGXKaw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Jul 2006 11:30:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 16D327F4028;
	Mon, 24 Jul 2006 12:30:44 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32146-07; Mon, 24 Jul 2006 12:30:43 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 8694B7F4024;
	Mon, 24 Jul 2006 12:30:43 +0200 (CEST)
In-Reply-To: <20060722123243.GA4543@gundam.enneenne.com>
References: <20060719180204.GK25330@enneenne.com> <20060722091342.GA22158@ipxXXXXX> <20060722123243.GA4543@gundam.enneenne.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <133FC0BA-B375-46D4-916E-773996425F57@caiaq.de>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] AU1100 I2C support
Date:	Mon, 24 Jul 2006 12:30:42 +0200
To:	Rodolfo Giometti <giometti@linux.it>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips


On Jul 22, 2006, at 2:32 PM, Rodolfo Giometti wrote:

> On Sat, Jul 22, 2006 at 11:13:42AM +0200, Daniel Mack wrote:
>>
>> Is there any reason why it is limited to this very processor and
>> should not work with all au1xxx types?
>
> To be honest I don't know exacly... I don't know so well other
> processors in this family. However I think at least au1000 and au1200
> should be compatible.

I think so, too. Since you only call the generic au_* functions for
the GPIO access, all members of this processor family should be
supported. I propose to change the patch accordingly.

Daniel
