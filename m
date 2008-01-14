Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 15:21:13 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:58405 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20030207AbYANPVF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2008 15:21:05 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 28A593EC9; Mon, 14 Jan 2008 07:21:02 -0800 (PST)
Message-ID: <478B7E13.5080000@ru.mvista.com>
Date:	Mon, 14 Jan 2008 18:21:55 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 fixes
References: <20080112230051.AE10EC2F34@solo.franken.de> <20080114001014.GC20115@linux-mips.org> <478B7084.8030401@ru.mvista.com>
In-Reply-To: <478B7084.8030401@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

I wrote:

>>> - ISA DMA is broken on IP28
>>> - bus error handler improved to not issue bus errors for
>>>  speculative accesses to CPU and GIO addresses. We now
>>>  treat CSTAT_ADDR and GSTAT_TIME errors as non fatal, when
>>>  they are issues via MC error interrupt. For real (non
>>>  speculative) bus errors a DBE will be issued, which is
>>>  lethal as before. Handling the issue this way gets rid
>>>  of decoding instructions

>>> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

>> Folded into the "[MIPS] IP28 support" patch for 2.6.28.

>   Poor IP32 will have to wait couple of years? ;-)

    I meant IP28 of course. 1:1 in typos. :-)

>> Thanks,

>>   Ralf

WBR, Sergei
