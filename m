Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 14:16:38 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:58204 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021839AbXHANQf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 14:16:35 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 7C9923EC9; Wed,  1 Aug 2007 06:16:03 -0700 (PDT)
Message-ID: <46B0880B.2000009@ru.mvista.com>
Date:	Wed, 01 Aug 2007 17:18:03 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
In-Reply-To: <46B086EB.2030101@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>> So could somebody Alchemist try to rewrite this to use ioremap() 
>>>> instead?

>>>   Will ioremap() work for 4 GB range? I guess not.

>>  Of course it will.  It shall work with whatever physical address 
>> space is supported by your MMU.  As long as the MMU is handled 
>> correctly that is, but I guess I may have omitted this clarification 
>> as obvious.

>    Even on a CPU with 36-bit physical address? ;-)

    WTF... I know I've typed "32-bit CPU"! :-/

>>   Maciej

WBR, Sergei
