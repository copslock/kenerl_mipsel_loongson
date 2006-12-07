Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 13:50:25 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:14469 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038561AbWLGNuU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 13:50:20 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CAFAE3EC9; Thu,  7 Dec 2006 05:50:09 -0800 (PST)
Message-ID: <45781C70.30405@ru.mvista.com>
Date:	Thu, 07 Dec 2006 16:51:44 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
References: <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org> <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com> <20061207.121702.108739943.nemoto@toshiba-tops.co.jp> <20061207115035.GA15386@linux-mips.org>
In-Reply-To: <20061207115035.GA15386@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:
> On Thu, Dec 07, 2006 at 12:17:02PM +0900, Atsushi Nemoto wrote:

>>You mean "adding" ?  I think now we can select
>>GENERIC_HARDIRQS_NO__DO_IRQ for all MACH_VR41XX boards.

>>Also I think most codes in vr41xx/nec-cmbvr4133/irq.c can be removed
>>if we made I8259A_IRQ_BASE customizable, but that would be another
>>story...

> This number is fixed to zero because that's what all the old ISA drivers
> expect, the ISA boards have printed on etc...

    It's not really related as 8259 is programmed to generate vectors 0x20 to 
0x2F for x86 but the the IRQs start from zero anyway...

>   Ralf

WBR, Sergei
