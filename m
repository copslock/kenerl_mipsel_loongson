Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 18:33:45 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:7223 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20027623AbXLFSdg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2007 18:33:36 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EE6243ECD; Thu,  6 Dec 2007 10:33:33 -0800 (PST)
Message-ID: <4758408F.6040603@ru.mvista.com>
Date:	Thu, 06 Dec 2007 21:33:51 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: fix PCI resource conflict
References: <200712062056.06326.sshtylyov@ru.mvista.com> <20071206182639.GB24263@linux-mips.org>
In-Reply-To: <20071206182639.GB24263@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>Date: Thu, 6 Dec 2007 20:56:06 +0300
>>To: ralf@linux-mips.org
>>Cc: linux-mips@linux-mips.org
>>Subject: [PATCH] Alchemy: fix PCI resource conflict
>>Content-Type: text/plain;
>>	charset="us-ascii"

>>... by getting the PCI resources back into the 32-bit range -- there's no need
>>therefore for CONFIG_RESOURCES_64BIT either. This makes Alchemy PCI work again
>>while currently the kernel skips the bus scan.

> So now you're using the numeric overflow to get things to "work"?

    Kinda. :-) Note that it was used in non-PCI case anyway.

>   Ralf

WBR, Sergei
