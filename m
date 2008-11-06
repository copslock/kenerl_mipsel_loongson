Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 22:50:54 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:61625 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23302467AbYKFWuv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Nov 2008 22:50:51 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 132433ECD; Thu,  6 Nov 2008 14:50:48 -0800 (PST)
Message-ID: <491374C4.7040400@ru.mvista.com>
Date:	Fri, 07 Nov 2008 01:50:44 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Martin Gebert <martin.gebert@alpha-bit.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: AU1000: SSI0 naming inconsistency
References: <4912CFA7.9000508@alpha-bit.de>
In-Reply-To: <4912CFA7.9000508@alpha-bit.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Martin Gebert wrote:

> Working on a 2.6.22 kernel for a AU1100 board, I came across the
> following inconsistency in register naming in
> include/asm/mach-au1x00/au1000.h, which still exists in 2.6.27.4 (lines 
> 1334-1389). There's no register SSI0_CONTROL, it should be named
> SSI0_ENABLE, as it is for SSI1:
>
> --8><--
> #define SSI0_CONTROL               0xB1600100
>   #define SSI_CONTROL_CD             (1<<1)
>   #define SSI_CONTROL_E              (1<<0)
>
> /* SSI1 */
> [...]
> #define SSI1_ENABLE                0xB1680100
>
> [...]
> #define SSI_ENABLE_CD               (1<<1)
> #define SSI_ENABLE_E                (1<<0)
> --><8--
>
> As I'm not working on a current kernel repo I don't dare to provide a
> patch. Would fixing this be desirable?
>   

   This seems to be a only top of iceberg as the SSI register bits are 
all defined twice in the arch/mips/include/asm/mach-au1x00/au1000.h. I 
wonder why gcc ignores macro redefinitions...
Patch is welcome but be sure not to break the users of those macros (if 
there are any :-)...

> Martin

WBR, Sergei
