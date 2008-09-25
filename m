Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 20:33:52 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:55440 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S32722821AbYIYTdr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 20:33:47 +0100
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Kiwar-00012S-GL; Thu, 25 Sep 2008 19:33:43 +0000
Message-ID: <48DBE794.9010309@garzik.org>
Date:	Thu, 25 Sep 2008 15:33:40 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Jeff Garzik <jgarzik@redhat.com>,
	Weiwei Wang <weiwei.wang@windriver.com>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] convert sbmac tx to spin_lock_irqsave to prevent early
 IRQ enable
References: <6781da3918e3c34d23e5f7e9cf777ab463a17d5e.1221613284.git.weiwei.wang@windriver.com> <20080917114051.GA30734@shell.devel.redhat.com> <20080920201839.GA27700@linux-mips.org>
In-Reply-To: <20080920201839.GA27700@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Sep 17, 2008 at 07:40:51AM -0400, Jeff Garzik wrote:
> 
>> On Wed, Sep 17, 2008 at 10:25:37AM +0800, Weiwei Wang wrote:
>>> Netpoll will call the interrupt handler with interrupts
>>> disabled when using kgdboe, so spin_lock_irqsave() should
>>> be used instead of spin_lock_irq() to prevent interrupts
>>> from being incorrectly enabled.
>>>
>>> Signed-off-by: Weiwei Wang <weiwei.wang@windriver.com>
>>> ---
>>>  drivers/net/sb1250-mac.c |   12 +++++++-----
>>>  1 files changed, 7 insertions(+), 5 deletions(-)
>> Please send to jeff@garzik.org or jgarzik@pobox.com.
> 
> Jeff - I haven't looked at kgdboe but if he's right half of drivers/net
> will need to be fixed ...

Oh indeed.  I mainly do it on a case-by-case basis where people care.  I 
overall think its a bogus change that deserves pushback, but that 
involves non-networking layers.  In the end, case-by-case application 
seemed to win.

	Jeff
