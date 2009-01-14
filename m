Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 22:04:24 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:10444 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21365088AbZANWEW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jan 2009 22:04:22 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 704F63ECB; Wed, 14 Jan 2009 14:04:18 -0800 (PST)
Message-ID: <496E615E.9060006@ru.mvista.com>
Date:	Thu, 15 Jan 2009 01:04:14 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Don't use ttyS* serial device name for board specific
 PNX8XXX UART serial
References: <1231943742.8457.6.camel@EPBYMINW0568>
In-Reply-To: <1231943742.8457.6.camel@EPBYMINW0568>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ihar Hrachyshka wrote:
> I think that's a better solution for the problem I said so please commit
> this patch rather previous one...
>   

   Such comments are to be placed after --- tearline. Using several such 
tearlines makes it harder to apply your patch...
   And why do you expect the MIPS maintainer to commit a patch to the 
serial driver? Such patches should be addressed to 
linux-serial@vger.kernel.org and (most probably) Alan Cox...

> ---
>
> Don't use ttyS[0-1] serial device name for board specific PNX8XXX UART
> serial. Rather create ttyPNX[0-1]. Also changed minor number to be
> different with sa1100 serial driver one.
>
> Signed-off-by: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
>   
[...]
> diff --git a/drivers/serial/pnx8xxx_uart.c b/drivers/serial/pnx8xxx_uart.c
> index 22e30d2..96870f1 100644
> --- a/drivers/serial/pnx8xxx_uart.c
> +++ b/drivers/serial/pnx8xxx_uart.c
> @@ -34,9 +34,8 @@
>  #include <asm/io.h>
>  #include <asm/irq.h>
>  
> -/* We'll be using StrongARM sa1100 serial port major/minor */
>  #define SERIAL_PNX8XXX_MAJOR	204
> -#define MINOR_START		5
> +#define MINOR_START		96
>   

   This major-minor pair is reserved for the Altix serial cards. Have 
you tried registering the minor on http://www.lanana.org

WBR, Sergei
