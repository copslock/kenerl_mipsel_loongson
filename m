Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2008 18:23:28 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:62473 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21652507AbYJPRXZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2008 18:23:25 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D60253ECA; Thu, 16 Oct 2008 10:23:21 -0700 (PDT)
Message-ID: <48F7787B.2060807@ru.mvista.com>
Date:	Thu, 16 Oct 2008 21:23:07 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>	<48F7391D.8050109@ru.mvista.com> <20081017.013101.128619577.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081017.013101.128619577.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>This is the driver for the Toshiba TX4939 SoC ATA controller.

>>   Mostly ACK but there's still a few minor nits...

> Welcome back!

    Indeed, it turned out to be hard to drown in the Dead see. :-)

>  I will address all of your points except for followings.

>>>+			xcount = bcount & 0xffff;
>>>+			if (xcount == 0x0000) {
>>>  

>>   Hm, I'm not sure this is necessary here... although I didn't see an 
>>explicit mention that zero count means 64 KB in the datasheet -- which 
>>it must mean if the BMIDE spec. was followed).
>>In ide-dma.c this check was added because of CS5530's brain damage...

> Hmm, if I could test this case easily I will drop this.  Otherwise I
> will keep it as is for future investigation.

    OK.

>>>+	if ((dma_stat & 7) == 0 &&
>>>+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
>>>+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
>>
>>   Parens around & and | are hardly needed...

> You mean more parens are needed?

    I mean less. :-)

> ---
> Atsushi Nemoto

MBR, Sergei
