Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:07:11 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:28640 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037897AbWLAPHH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:07:07 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0510C3ECA; Fri,  1 Dec 2006 07:06:48 -0800 (PST)
Message-ID: <45704569.8000807@ru.mvista.com>
Date:	Fri, 01 Dec 2006 18:08:25 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: Is _do_IRQ() not needed anymore ?
References: <cda58cb80612010140y5a95faceybffedbd4dd9900db@mail.gmail.com>	<20061201.185740.03976990.nemoto@toshiba-tops.co.jp>	<cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com> <20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>If _all_ irq chip were converted to use flow handler,
>>>GENERIC_HARDIRQS_NO__DO_IRQ will be good.  But we have i8259...

>>That's why in my example I made GENERIC_HARDIRQS_NO__DO_IRQ config
>>default to 'n' and selected by a irq chip that doens't use __do_IRQ()
>>anymore, well I think...

> You can use both irq_cpu and i8259 same time. :)

    What's wrong with 8259 I wonder? It's happily converted to genirq by other 
arches...

> ---
> Atsushi Nemoto

WBR, Sergei
