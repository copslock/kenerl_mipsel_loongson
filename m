Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 16:40:44 +0000 (GMT)
Received: from postman.fh-hagenberg.at ([193.170.124.96]:6409 "EHLO
	mail.fh-hagenberg.at") by ftp.linux-mips.org with ESMTP
	id S20025883AbXLEQke (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 16:40:34 +0000
Received: from [192.168.1.164] ([84.150.240.17]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 5 Dec 2007 17:40:52 +0100
Message-ID: <4756D42E.9040609@fh-hagenberg.at>
Date:	Wed, 05 Dec 2007 17:39:10 +0100
From:	Manuel Lauss <manuel.lauss@fh-hagenberg.at>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Alchemy: fix interrupt routing
References: <200712051908.18780.sshtylyov@ru.mvista.com>
In-Reply-To: <200712051908.18780.sshtylyov@ru.mvista.com>
X-Face:	?%%W`v1k(]AEyz!>:Wx5B3%Q{:HAn7x3R7EpLwqQWHc2>e&B2[\87@^|&dnyPvU,Gvzzxg.-(oGbT?5:{e!;wuTp2T,mKccN-6N(MdgITqZUM?``s0vhYdFzpIvC:rShQMj;!?uPt/A@;p.SR[q@.&La)e,a|z@U.[ZAtdBK8pVN|?V,F7yXUoaXsna[0nauK{'i|.eTRjYb@E9%}g+HB"\1XeU6K*o+KObFtnB[\_N&w5O#i#*q/]%D6ib)7Ld<1[xQQr0Ya"g!+vxBIh(W@G>qiblEcRLXR9(
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2007 16:40:52.0635 (UTC) FILETIME=[997866B0:01C8375D]
Return-Path: <hse00027@fh-hagenberg.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@fh-hagenberg.at
Precedence: bulk
X-list: linux-mips

Sergei,

Sergei Shtylyov schrieb:
> Hello.
> 
>    The two following patches together fix the interrupt routing currently broken
> and causing boot failure with such messages:
> 
> unexpected IRQ # 8
> irq 8, desc: 80406dd0, depth: 1, count: 0, unhandled: 0
> ->handle_irq():  80157d70, handle_bad_irq+0x0/0x38c
> ->chip(): 804016d0, 0x804016d0
> ->action(): 00000000
>   IRQ_DISABLED set
> 
>    The patches are against the Linus' tree...
> 
> WBR, Sergei

Thanks a billion!
Finally I can boot linux-2.6.24-rc on my Au1200 again!

-- 
Manuel Lauss
HSSE / FH Hagenberg
