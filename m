Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 11:59:04 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:63370 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022978AbXGKK7C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 11:59:02 +0100
Received: (qmail 18939 invoked by uid 511); 11 Jul 2007 11:02:51 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 11 Jul 2007 11:02:51 -0000
Message-ID: <4694B7E1.2010009@lemote.com>
Date:	Wed, 11 Jul 2007 18:58:41 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Songmao Tian <tiansm@lemote.com>, linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
References: <4694A495.1050006@lemote.com>
In-Reply-To: <4694A495.1050006@lemote.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Songmao Tian wrote:
> Hi,
>    I am trying to use a mips cpu the cs5536. I have some problem with 
> the 8259 of cs5536.  The  databook said,

cs5536 is a south bridge, cpu, of couse, is loongson:)

>
> "Control Logic
> The INT output goes directly to the CPU interrupt input.
> When an INT signal is activated, the CPU responds with an
> Interrupt Acknowledge access that is translated to two
> pulses on the INTA input of the PIC. At the first INTA pulse,
> the highest priority IRR bit is loaded into the corresponding
> ISR bit, and that IRR bit is reset. The second INTA pulse
> instructs the PIC to present the 8-bit vector of the interrupt
> handler onto the data bus."
>
> Is it the responsibility of north bridge to reponse to intr with a PCI 
> Interrupt Ack cycle?
> it's a problem that my northbridge didn't implement that! Fortunately 
> we use a fpga as a northbridge.
>
> it seem it's no way to fix this by software, for OCW3 didn't implemnt 
> Poll command:(
>
> so I guess the the process is:
> 1) 8259 receive a int, a bit irr got set.
> 2) 8259 assert intr.
> 3) northbrige generate a int ack cycle.
> 4) cs5536 translate the ack into two INTA pulse, and the reponse 
> northbridge with a interrupt vector.
> 5) then my program can get the vector from northbridge?
>
> Is that right?
>
> Without int ack, generic linux-mips 8259 code can't work.
>
> Greetings,
> Tian
>
>
>
>
>
>
