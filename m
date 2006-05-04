Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 18:28:09 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:55972 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133518AbWEDR1z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 18:27:55 +0100
Received: (qmail 29110 invoked from network); 4 May 2006 21:32:56 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 May 2006 21:32:56 -0000
Message-ID: <445A3959.3050906@ru.mvista.com>
Date:	Thu, 04 May 2006 21:26:49 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Porting Au1x000 USB host controller on u-boot
References: <20060504095341.GB19913@gundam.enneenne.com> <445A347A.5050507@ru.mvista.com> <445A36E3.4010809@ru.mvista.com> <20060504172131.GF7357@gundam.enneenne.com>
In-Reply-To: <20060504172131.GF7357@gundam.enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

>>   AND make sure every buffer/TD/ED is written back / invalidated from 
>>   cache before the OHCI accesses them since the cache coherency on Au1xx0 is 
>>b0rken!

    Or, better yet, access TD/ED (and, if possible, the buffers) via uncached 
KSEG1 only.

> Mmm... good suggestion! :) How can I invalidated the cache? Can you
> please show me some example code?

    Dig in arch/mips/mm/c-r4k.c...

> Thanks _a lot_!
> 
> Rodolfo

WBR, Sergei
