Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:21:06 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:15973 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021534AbXGKPVE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 16:21:04 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 6A6A33ECB; Wed, 11 Jul 2007 08:20:30 -0700 (PDT)
Message-ID: <4694F5B8.50009@ru.mvista.com>
Date:	Wed, 11 Jul 2007 19:22:32 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Songmao Tian <tiansm@lemote.com>
Cc:	linuxbios@linuxbios.org, marc.jones@amd.com,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
References: <4694A495.1050006@lemote.com>
In-Reply-To: <4694A495.1050006@lemote.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Songmao Tian wrote:
> Hi,

>    I am trying to use a mips cpu the cs5536. I have some problem with 
> the 8259 of cs5536.  The  databook said,

    Which databook?

> "Control Logic
> The INT output goes directly to the CPU interrupt input.
> When an INT signal is activated, the CPU responds with an
> Interrupt Acknowledge access that is translated to two
> pulses on the INTA input of the PIC. At the first INTA pulse,
> the highest priority IRR bit is loaded into the corresponding
> ISR bit, and that IRR bit is reset. The second INTA pulse
> instructs the PIC to present the 8-bit vector of the interrupt
> handler onto the data bus."

> Is it the responsibility of north bridge to reponse to intr with a PCI 
> Interrupt Ack cycle?



> it's a problem that my northbridge didn't implement that! Fortunately we 
> use a fpga as a northbridge.

    Wait, CS5536 is a nortbridge itself!

> it seem it's no way to fix this by software, for OCW3 didn't implemnt 
> Poll command:(

    Quite a few 8259 clones don't.

> so I guess the the process is:
> 1) 8259 receive a int, a bit irr got set.
> 2) 8259 assert intr.
> 3) northbrige generate a int ack cycle.

    To what, PCI?

> 4) cs5536 translate the ack into two INTA pulse, and the reponse 

    Nonsense. It would only make sense to translate INTA cycles from CPU bus 
to the PCI bus, not the other way around.

> northbridge with a interrupt vector.

    As I said, CS5536 is northbridge in itself.

> 5) then my program can get the vector from northbridge?

    It's CPU that gets the vector, your program could only do this using poll 
comand which as

> Is that right?

    No.

> Without int ack, generic linux-mips 8259 code can't work.

   I'm compleetly lost here -- what does CS5536 has to do with MIPS?

> Greetings,
> Tian

WBR, Sergei
