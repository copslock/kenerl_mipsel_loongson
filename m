Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 17:25:05 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:16869 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225797AbVEWQYv>;
	Mon, 23 May 2005 17:24:51 +0100
Received: by mail.dfpost.ru (Postfix, from userid 7897)
	id 92C163E457; Mon, 23 May 2005 20:22:27 +0400 (MSD)
Received: from toch.dfpost.ru (toch [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 3901E3E455
	for <linux-mips@linux-mips.org>; Mon, 23 May 2005 20:22:27 +0400 (MSD)
Date:	Mon, 23 May 2005 20:25:14 +0400
From:	Dmitriy Tochansky <toch@dfpost.ru>
To:	linux-mips@linux-mips.org
Subject: Re: yenta_socket
Message-Id: <20050523202514.3d97d1b5.toch@dfpost.ru>
In-Reply-To: <20050523184501.3e733eb3.toch@dfpost.ru>
References: <20050523184501.3e733eb3.toch@dfpost.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.8
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

On Mon, 23 May 2005 18:45:01 +0400
Dmitriy Tochansky <toch@dfpost.ru> wrote:

> Yenta: CardBus bridge found at 0000:00:11.0 [e4bf:2000]                         
> yenta 0000:00:11.0: Preassigned resource 0 busy, reconfiguring...               
> yenta 0000:00:11.0: Preassigned resource 1 busy, reconfiguring...               
> Yenta: Enabling burst memory read transactions                                  
> Yenta: Using CSCINT to route CSC interrupts to PCI                              
> Yenta: Routing CardBus interrupts to PCI                                        
> Yenta TI: socket 0000:00:11.0, mfunc 0x0fc01d02, devctl 0x66                    
> drivers/pcmcia/ti113x.h pci_irq_status = 0                                      
> Yenta TI: socket 0000:00:11.0 probing PCI interrupt failed, trying to fix       
> Yenta TI: socket 0000:00:11.0 falling back to parallel PCI interrupts           
> Yenta TI: socket 0000:00:11.0 no PCI interrupts. Fish. Please report.           
> CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc =0
> ....

Hm... Bus 5?

Linux Kernel Card Services                                                      
  options:  [pci] [cardbus]                                                     
PCI: Bus 1, cardbus bridge: 0000:00:11.0                                        
  IO window: 00001000-00001fff                                                  
  IO window: 00002000-00002fff                                                  
  PREFETCH window: 40000000-41ffffff                                            
  MEM window: 42000000-43ffffff                                                 
PCI: Bus 5, cardbus bridge: 0000:00:11.1                                        
  IO window: 00003000-00003fff                                                  
  IO window: 00004000-00004fff                                                  
  PREFETCH window: 44000000-45ffffff                                            
  MEM window: 46000000-47ffffff                                                 
PCI: Enabling device 0000:00:11.0 (0000 -> 0002)                                
PCI: Enabling device 0000:00:11.1 (0000 -> 0002)                                


-- 
Dmitriy Tochansky
toch@dfpost.ru
JID: dtoch@jabber.ru
