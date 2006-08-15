Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2006 22:35:02 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:55906 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037637AbWHOVfA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2006 22:35:00 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C83A93ED4; Tue, 15 Aug 2006 14:34:44 -0700 (PDT)
Message-ID: <44E23E3D.3030403@ru.mvista.com>
Date:	Wed, 16 Aug 2006 01:35:57 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	=?ISO-8859-1?Q?Thomas_K=F6ller?= <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <44DCDCED.7000404@ru.mvista.com> <200608152315.55104.thomas.koeller@baslerweb.com>
In-Reply-To: <200608152315.55104.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Koeller wrote:
> On Friday 11 August 2006 21:39, Sergei Shtylyov wrote:
> 
>>    I highly doubt this is how it should be done. Look at the Alchemy code
>>as an example how the "partly-compatible" UART support should be written.
>>Alchemy also has 32-bit MMIO and some registers mapped differently.

>>WBR, Sergei

> Seems I cannot find the code you are referring to - could you point me at
> the particular file(s) to look at?

    8250.c and 8250-au1x00.c in drivers/serial/...

> Thanks,
> Thomas

WBR, Sergei
