Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 13:19:47 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:19112 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037767AbWLHNTm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2006 13:19:42 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 80B243EC9; Fri,  8 Dec 2006 05:19:39 -0800 (PST)
Message-ID: <457966C9.8000801@ru.mvista.com>
Date:	Fri, 08 Dec 2006 16:21:13 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Vitaly Wool <vitalywool@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] add STB810 support (Philips PNX8550-based)
References: <20061208114035.000049c4.vitalywool@gmail.com> <20061208130543.GB5797@linux-mips.org> <20061208130806.GA7439@linux-mips.org>
In-Reply-To: <20061208130806.GA7439@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:
> On Fri, Dec 08, 2006 at 01:05:43PM +0000, Ralf Baechle wrote:

> Hmmm...

>   CC      arch/mips/philips/pnx8550/common/setup.o
> arch/mips/philips/pnx8550/common/setup.c:27:34: error: linux/serial_pnx8xxx.h: No such file or directory

> arch/mips/philips/pnx8550/common/setup.c: In function 'plat_mem_setup':
> arch/mips/philips/pnx8550/common/setup.c:147: error: 'PNX8XXX_UART_LCR_8BIT' undeclared (first use in this function)
> arch/mips/philips/pnx8550/common/setup.c:147: error: (Each undeclared identifier is reported only once
> arch/mips/philips/pnx8550/common/setup.c:147: error: for each function it appears in.)
> make[1]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
> make: *** [arch/mips/philips/pnx8550/common] Error 2

    PNX8xxx UART driver still not accepted it seems, thanks to RMK's step out 
from the serial core maintenance...

WBR, Sergei
