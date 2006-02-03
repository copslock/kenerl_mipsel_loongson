Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 02:05:21 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:41686 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133441AbWBCCEV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 02:04:21 +0000
Received: (qmail 27416 invoked from network); 3 Feb 2006 02:09:33 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 3 Feb 2006 02:09:33 -0000
Message-ID: <43E2BC1F.7080505@ru.mvista.com>
Date:	Fri, 03 Feb 2006 05:12:47 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] TX49 MFC0 bug workaround
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>	<43E25381.4060309@ru.mvista.com> <20060203.101705.41198541.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060203.101705.41198541.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>>>>On Thu, 02 Feb 2006 21:46:25 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
>>>
>>>If mfc0 $12 follows store and the mfc0 is last instruction of a
>>>page and fetching the next instruction causes TLB miss, the result
>>>of the mfc0 might wrongly contain EXL bit.
> 
> 
> sshtylyov>     Hmm, a TLB miss in fetching from KSEG0?!
> 
> We can call these inline functions from modules running on KSEG2.

    Hm, I'm still learning Linux/MIPS, and have overlooked #ifdef MODULE. :-<

    If I don't mistake, the offending code is in local_irq_disable, 
local_irq_save, and local_irq_restore macros. The effect would be a crash on 
any exception taken once interrupts get disabled in a module (*and* that code 
happens to fall on a page boundary)... nasty. :-(

> ---
> Atsushi Nemoto

WBR, Sergei
