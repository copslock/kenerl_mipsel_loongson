Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:14:58 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:804 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022454AbXFDPO4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Jun 2007 16:14:56 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 08F803EC9; Mon,  4 Jun 2007 08:14:20 -0700 (PDT)
Message-ID: <46642CA9.20103@ru.mvista.com>
Date:	Mon, 04 Jun 2007 19:15:53 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
References: <20070605.000239.31638706.anemo@mba.ocn.ne.jp> <20070604151048.GA30128@linux-mips.org>
In-Reply-To: <20070604151048.GA30128@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>Unify lib-{32,64}/watch.S into lib/watch.S and remove lib-{32,64}
>>completely.

>>The old 64-bit __watch_set() expected an physical address and the old
>>32-bit __watch_set() expected a KSEG0 virtual address.  The new
>>unified __watch_set() is based on the 64-bit one.  Since there is no
>>real user of the __watch_set(), this incompatibility would not cause
>>any problem.

> I think we can simply drop the entire watchpoint support.  This was
> only ever working on R4000/R4400 and even there only somewhat useful
> for kernel debugging.  So if we ever use watchpoint support I think
> something needs to be developed from scratch.

    Watchpoints *could* be supported as part of KGDB, BTW.

>   Ralf

WBR, Sergei
