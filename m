Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 14:11:19 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:41820 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021814AbXHANLR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 14:11:17 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 228BA3EC9; Wed,  1 Aug 2007 06:11:15 -0700 (PDT)
Message-ID: <46B086EB.2030101@ru.mvista.com>
Date:	Wed, 01 Aug 2007 17:13:15 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>>>So could somebody Alchemist try to rewrite this to use ioremap() instead?

>>   Will ioremap() work for 4 GB range? I guess not.

>  Of course it will.  It shall work with whatever physical address space is 
> supported by your MMU.  As long as the MMU is handled correctly that is, 
> but I guess I may have omitted this clarification as obvious.

    Even on a CPU with 36-bit physical address? ;-)

>   Maciej

WBR, Sergei
