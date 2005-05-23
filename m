Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 17:18:32 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:44514 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225792AbVEWQSQ>;
	Mon, 23 May 2005 17:18:16 +0100
Received: by mail.dfpost.ru (Postfix, from userid 7897)
	id 2080D3E457; Mon, 23 May 2005 20:16:04 +0400 (MSD)
Received: from toch.dfpost.ru (toch [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id A27E93E455
	for <linux-mips@linux-mips.org>; Mon, 23 May 2005 20:16:03 +0400 (MSD)
Date:	Mon, 23 May 2005 20:18:48 +0400
From:	Dmitriy Tochansky <toch@dfpost.ru>
To:	linux-mips@linux-mips.org
Subject: Re: yenta_socket
Message-Id: <20050523201848.3dd58338.toch@dfpost.ru>
In-Reply-To: <20050524.005447.96686952.anemo@mba.ocn.ne.jp>
References: <20050523184501.3e733eb3.toch@dfpost.ru>
	<20050524.005447.96686952.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.8
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

On Tue, 24 May 2005 00:54:47 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Mon, 23 May 2005 18:45:01 +0400, Dmitriy Tochansky <toch@dfpost.ru> said:
> 
> toch> Im enable cardbus yenta type in kernel config and see the
> toch> follow:
> 
> toch> yenta 0000:00:11.0: Preassigned resource 0 busy, reconfiguring...
> toch> yenta 0000:00:11.0: Preassigned resource 1 busy, reconfiguring...
> 
> I think these messages are due to confliction with resource management
> codes in drivers/pci/setup-bus.c.  Though I do not see details yet,
> this quick workaround might solve this issue.
> 
> --- linux-mips/drivers/pcmcia/yenta_socket.c	2005-04-18 00:43:34.000000000 +0900
> +++ linux/drivers/pcmcia/yenta_socket.c	2005-05-04 00:21:38.000000000 +0900
> @@ -611,10 +611,12 @@
  
  Well, yes, the resourse problem "dissapear", but irq is still asking to report. I'll try to check setup-bus.c becourse IMHO there is problem in irq assignment or something.
Yenta: CardBus bridge found at 0000:00:11.0 [e4bf:2000]                         
Yenta: Enabling burst memory read transactions                                  
Yenta: Using CSCINT to route CSC interrupts to PCI                              
Yenta: Routing CardBus interrupts to PCI                                        
Yenta TI: socket 0000:00:11.0, mfunc 0x0fc01d02, devctl 0x66                    
drivers/pcmcia/ti113x.h pci_irq_status = 0                                      
Yenta TI: socket 0000:00:11.0 probing PCI interrupt failed, trying to fix       
Yenta TI: socket 0000:00:11.0 falling back to parallel PCI interrupts           
Yenta TI: socket 0000:00:11.0 no PCI interrupts. Fish. Please report.           
CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc =c
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:                      


-- 
Dmitriy Tochansky
toch@dfpost.ru
JID: dtoch@jabber.ru
