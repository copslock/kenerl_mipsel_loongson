Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 15:44:44 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:35021 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225749AbVEWOo3>;
	Mon, 23 May 2005 15:44:29 +0100
Received: by mail.dfpost.ru (Postfix, from userid 7897)
	id 3332A3E457; Mon, 23 May 2005 18:42:16 +0400 (MSD)
Received: from toch.dfpost.ru (toch [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id B99883E455
	for <linux-mips@linux-mips.org>; Mon, 23 May 2005 18:42:14 +0400 (MSD)
Date:	Mon, 23 May 2005 18:45:01 +0400
From:	Dmitriy Tochansky <toch@dfpost.ru>
To:	linux-mips@linux-mips.org
Subject: yenta_socket
Message-Id: <20050523184501.3e733eb3.toch@dfpost.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.8
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Hi!

Cant get where is the problem.

Look. I have pci->pcmcia cardbus adaptor CP3-HOUSE and I want to start it on mips.

Im enable cardbus yenta type in kernel config and see the follow:

Yenta: CardBus bridge found at 0000:00:11.0 [e4bf:2000]                         
yenta 0000:00:11.0: Preassigned resource 0 busy, reconfiguring...               
yenta 0000:00:11.0: Preassigned resource 1 busy, reconfiguring...               
Yenta: Enabling burst memory read transactions                                  
Yenta: Using CSCINT to route CSC interrupts to PCI                              
Yenta: Routing CardBus interrupts to PCI                                        
Yenta TI: socket 0000:00:11.0, mfunc 0x0fc01d02, devctl 0x66                    
drivers/pcmcia/ti113x.h pci_irq_status = 0                                      
Yenta TI: socket 0000:00:11.0 probing PCI interrupt failed, trying to fix       
Yenta TI: socket 0000:00:11.0 falling back to parallel PCI interrupts           
Yenta TI: socket 0000:00:11.0 no PCI interrupts. Fish. Please report.           
CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc =0
....

As far I understand driver cant get irq for this card but when I disable
this driver I can see(via cat /proc/pci) that cardbus have irq 4... :(
Ideas\advices are wellcome!

-- 
Dmitriy Tochansky
toch@dfpost.ru
JID: dtoch@jabber.ru
