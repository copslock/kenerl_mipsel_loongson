Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:27:49 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:46560 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038324AbWLAP1p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:27:45 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 7D5B33ECA; Fri,  1 Dec 2006 07:27:40 -0800 (PST)
Message-ID: <45704A4D.9050303@ru.mvista.com>
Date:	Fri, 01 Dec 2006 18:29:17 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: Is _do_IRQ() not needed anymore ?
References: <cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com>	<20061201.191049.63741937.nemoto@toshiba-tops.co.jp>	<45704569.8000807@ru.mvista.com> <20061202.002214.51866784.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061202.002214.51866784.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>You can use both irq_cpu and i8259 same time. :)

>>    What's wrong with 8259 I wonder? It's happily converted to genirq by other 
>>arches...

> Indeed.  I missed other arch's i8259.c had changed.  Maybe we should
> update i8259.c entirely.

    The question is what flow to use: level/edge ones used in x86 code and 
actually intended for simplistic controllers, not the likes of 8259 OR the 
"fasteoi" one used in PowerPC code and (as it turned out in my earlier 
discussion in linuxppc-dev) intended for the controllers that are smart enough 
to mask off the lower-priority IRQs when getting the top level one 
acknowledged and unmask them upon EOI command...

> ---
> Atsushi Nemoto

WBR, Sergei
