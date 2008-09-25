Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2008 00:50:14 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:15039
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S36902019AbYIYXuH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2008 00:50:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8PNnBFC011128;
	Fri, 26 Sep 2008 00:49:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8PNnAU3011126;
	Fri, 26 Sep 2008 00:49:10 +0100
Date:	Fri, 26 Sep 2008 00:49:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	Jeff Garzik <jgarzik@redhat.com>,
	Weiwei Wang <weiwei.wang@windriver.com>,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] convert sbmac tx to spin_lock_irqsave to prevent early
	IRQ enable
Message-ID: <20080925234910.GA11092@linux-mips.org>
References: <6781da3918e3c34d23e5f7e9cf777ab463a17d5e.1221613284.git.weiwei.wang@windriver.com> <20080917114051.GA30734@shell.devel.redhat.com> <20080920201839.GA27700@linux-mips.org> <48DBE794.9010309@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48DBE794.9010309@garzik.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 25, 2008 at 03:33:40PM -0400, Jeff Garzik wrote:

>>> On Wed, Sep 17, 2008 at 10:25:37AM +0800, Weiwei Wang wrote:
>>>> Netpoll will call the interrupt handler with interrupts
>>>> disabled when using kgdboe, so spin_lock_irqsave() should
>>>> be used instead of spin_lock_irq() to prevent interrupts
>>>> from being incorrectly enabled.
>>>>
>>>> Signed-off-by: Weiwei Wang <weiwei.wang@windriver.com>
>>>> ---
>>>>  drivers/net/sb1250-mac.c |   12 +++++++-----
>>>>  1 files changed, 7 insertions(+), 5 deletions(-)
>>> Please send to jeff@garzik.org or jgarzik@pobox.com.
>>
>> Jeff - I haven't looked at kgdboe but if he's right half of drivers/net
>> will need to be fixed ...
>
> Oh indeed.  I mainly do it on a case-by-case basis where people care.  I  
> overall think its a bogus change that deserves pushback, but that  
> involves non-networking layers.  In the end, case-by-case application  
> seemed to win.

Turns out kgdboe isn't upstream yet - but netconsole apparently hast the
same issue.

  Ralf
