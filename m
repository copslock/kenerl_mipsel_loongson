Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 13:52:11 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:30048 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038486AbWLFNwH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 13:52:07 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3E28F3EC9; Wed,  6 Dec 2006 05:52:02 -0800 (PST)
Message-ID: <4576CB64.2060705@ru.mvista.com>
Date:	Wed, 06 Dec 2006 16:53:40 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ingo Molnar <mingo@redhat.com>, anemo@mba.sphere.ne.jp,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
References: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp> <20061206015818.GB27985@linux-mips.org> <20061206.115602.63741871.nemoto@toshiba-tops.co.jp> <20061206.133836.89067271.nemoto@toshiba-tops.co.jp> <4576C2E9.4060900@ru.mvista.com> <Pine.LNX.4.64N.0612061337220.29000@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0612061337220.29000@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maciej W. Rozycki wrote:

>>>+static struct irq_chip i8259A_chip = {
>>>+	.name		= "XT-PIC",
>>>+	.mask		= disable_8259A_irq,
>>>+	.unmask		= enable_8259A_irq,
>>>+	.mask_ack	= mask_and_ack_8259A,
>>> };

>>   I wonder whose idea was to call this device XT-PIC. XT never had dual 8259A
>>PICs and so was capable of handling only 8 IRQs. Dual 8259A was first used in
>>the AT class machines...

>  Ask Ingo, perhaps... ;-)

    Ask and be ignored. :-)

>  I think he was perfectly right, though -- this 
> is a pair of PC/XT-class PICs.

    Coupled as only in PC/AT-class machines. So, this XT qualification is 
actually meaningless. It's 8259A, that's all.

>  And with the "IO-APIC-edge" and 
> "IO-APIC-level" alternatives back when the concept of IRQ controllers was 
> introduced, "XT-PIC" rather than "8259A" sounded quite right.

    I don't follow you here.

>   Maciej

WBR, Sergei
