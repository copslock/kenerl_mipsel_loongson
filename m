Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 13:58:50 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:7570 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022113AbXHBM6s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 13:58:48 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0FF523EC9; Thu,  2 Aug 2007 05:58:46 -0700 (PDT)
Message-ID: <46B1D57D.7090209@ru.mvista.com>
Date:	Thu, 02 Aug 2007 17:00:45 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl> <46B0B6B4.5090103@ru.mvista.com> <46B0BE52.4000302@ru.mvista.com> <Pine.LNX.4.64N.0708021024200.22591@blysk.ds.pg.gda.pl> <46B1D3CE.6070507@ru.mvista.com>
In-Reply-To: <46B1D3CE.6070507@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi, I wrote:

>>>>   No, I don't.  But that was why the original code preferred the wired
>>>> entry approach over ioremap() -- not to map a whole range...

>>>   Not the only one: dynamic ioremap() seems to be impossible in 
>>> interrupt
>>> context.

>>  Well, ioremap() may sleep indeed.

>    So, the only viable option of using sofirq() is mapping all the 
> sparce 2KiB regions at the __init time -- that will waste every half of 
> page though...

    That for the root PCI bus and 16 megs at 0x680000000 for the subordinates.

WBR, Sergei
