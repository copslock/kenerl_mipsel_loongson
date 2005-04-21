Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2005 06:08:41 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:19812
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224916AbVDUFIZ>; Thu, 21 Apr 2005 06:08:25 +0100
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 21 Apr 2005 05:08:20 -0000
Message-ID: <42673538.90508@embeddedalley.com>
Date:	Wed, 20 Apr 2005 22:08:08 -0700
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"d.piccolo" <d.piccolo@exadron.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Bug detection and correction on Alchemy au1x00_uart.c serial
 driver
References: <1113822129.3261.42.camel@localhost.localdomain>
In-Reply-To: <1113822129.3261.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


Applied, thanks.

Pete

d.piccolo wrote:
> Hi Everybody
> 
> I've found a bug in the  au1x00_uart.c file in the drivers/serial/
> directory of the 2.6.10 linux kernel. There is only possible to change
> the speed of the communication but not to update other parameters of the
> serial link, like the number of bits involved, stop bits and parity.
>   Comparing the code of this source file with the code of the standard
> 8250 driver (8250.c also present in the same directory) I've found the
> problem:  au1x00_uart.c never updates the LCR register  (Line Control
> Register) of the serial controller at runtime, it happens only at first
> setup. The problem is solved by adding the line
> 
> 	serial_out(up, UART_LCR, cval);
> 
> just before the line 
>  
> 	up->lcr = cval;	  /* Save LCR */
> 
> (there is only one position in all the source code where is written
> "Save LCR")
> 
> I hope it could be useful.
>                               David Piccolo
> 
> 
>     
> 
> 
> 
