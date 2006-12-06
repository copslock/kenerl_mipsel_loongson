Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 15:49:02 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:25698 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038310AbWLFPrW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 15:47:22 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8F8A83EC9; Wed,  6 Dec 2006 07:47:18 -0800 (PST)
Message-ID: <4576E666.1010502@ru.mvista.com>
Date:	Wed, 06 Dec 2006 18:48:54 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ingo Molnar <mingo@redhat.com>, anemo@mba.sphere.ne.jp,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
References: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp> <20061206015818.GB27985@linux-mips.org> <20061206.115602.63741871.nemoto@toshiba-tops.co.jp> <20061206.133836.89067271.nemoto@toshiba-tops.co.jp> <4576C2E9.4060900@ru.mvista.com> <Pine.LNX.4.64N.0612061337220.29000@blysk.ds.pg.gda.pl> <4576CB64.2060705@ru.mvista.com> <Pine.LNX.4.64N.0612061438440.29000@blysk.ds.pg.gda.pl> <4576DDEC.1050105@ru.mvista.com> <Pine.LNX.4.64N.0612061525580.29000@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0612061525580.29000@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maciej W. Rozycki wrote:

>>   As for the I/O APIC, I think i82903AA was "the reference design" for it...

>  Nope, it was the i82489DX -- the original "discrete" coupled Local & I/O 
> APIC using a five-wire inter-APIC bus and a protocol different from later 
> implementations.

    Hm, that's news to me. I always thought that chip was external *local* 
APIC only... Well, there's no docs on it anyway.

> Then there were ones included in the i82379AB (SIO.A) 
> and i82374EB/SB (ESC) chipset components.  They used a three-wire bus and 
> a new protocol.  And only then came the i82093AA.

    Aha, you're probably correct here. I forgot about those early chipssets.

>   Maciej

WBR, Sergei
