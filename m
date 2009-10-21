Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 18:11:53 +0200 (CEST)
Received: from ru.mvista.com ([213.79.90.228]:4715 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1491917AbZJUQLq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 18:11:46 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 27E518817; Wed, 21 Oct 2009 21:11:43 +0500 (SAMST)
Message-ID: <4ADF32D1.6030801@ru.mvista.com>
Date:	Wed, 21 Oct 2009 20:12:01 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"wilbur.chan" <wilbur512@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Got trap No.23 when booting mips32 ?
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
In-Reply-To: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

wilbur.chan wrote:

> Hi all,

> I've got some problem when booting mips32.

> I got a No.23 trap when calling start_kernel --->  local_irq_enable :

> irq 23, desc: 802a98a0, depth: 1, count: 0, unhandled: 0
> ->handle_irq():  80148c6c, handle_bad_irq+0x0/0x2b4
> ->chip(): 8029f738, 0x8029f738
> ->action(): 00000000
>   IRQ_DISABLED set
> unexpected IRQ # 23

> No.23 trap is a Watch trap, which means that, when

    IRQ # is not a trap #, so the rest of your speculations don't apply.
"unexpected IRQ" probably means that an IRQ occurs for which no handler has 
been installed...

WBR, Sergei
