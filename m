Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 15:57:42 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:8161 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038426AbWLAP5i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 15:57:38 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 04CA13ECA; Fri,  1 Dec 2006 07:57:33 -0800 (PST)
Message-ID: <4570514F.8030905@ru.mvista.com>
Date:	Fri, 01 Dec 2006 18:59:11 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
References: <457042FF.2060908@innova-card.com> <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>@@ -758,6 +768,7 @@ config TOSHIBA_RBTX4938
>> 	select SYS_SUPPORTS_LITTLE_ENDIAN
>> 	select SYS_SUPPORTS_BIG_ENDIAN
>> 	select TOSHIBA_BOARDS
>>+	select GENERIC_HARDIRQS_NO__DO_IRQ
>> 	help
>> 	  This Toshiba board is based on the TX4938 processor. Say Y here to
>> 	  support this machine type

> RBTX4938(rbhma4500) uses i8259 which is not converted to irq flow
> handler yet.

    I'm afraid there's some mistake in Kconfig -- RBTX4938 doesn't have 8259 
compatible controller. And the backplane that has it isn't supported by the 
current code anyway.

WBR, Sergei
