Received:  by oss.sgi.com id <S553661AbQK2BzI>;
	Tue, 28 Nov 2000 17:55:08 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:33284 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553653AbQK2Byo>;
	Tue, 28 Nov 2000 17:54:44 -0800
Received: from baton.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id D469D205FA
	for <linux-mips@oss.sgi.com>; Tue, 28 Nov 2000 17:54:38 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Tue, 28 Nov 2000 17:50:16 -0800
Received: by baton.sibyte.com (Postfix, from userid 1017)
	id 2B9F25703; Tue, 28 Nov 2000 17:54:23 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: Boot ordering quandry for time_init()
Date:   Tue, 28 Nov 2000 17:38:56 -0800
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0011281754234M.11653@baton.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Looking for some advice from some mips boot gurus.

I'm bringing up an SB1/SB1250 port of the mips/ arch
tree.  In particular, I'm in time_init() bringing up the
general purpose timer that's going to be used for 
the 100Hz clock.  The interrupt seems to be the rub. 

I've basically copied the request_irq() code from other
ports, but it uses kmalloc(), which I can't use at this point
in the boot sequence since we haven't yet initialized
the allocator (I believe it's done in mem_init()?  escapes 
me at the moment).  

The 4k way around this is to hook its timer interrupt handling
routing up directly to the interrupt handling stub  in indyIRQ.S.  This
certainly works, but seems somewhat messy to me in that it's a
 special case provided only to avoid ordering constraints. 

I could hack request_irq to use the boot memory allocator
than reallocate properly after kmalloc is available, but this
is even worse in terms of added complexity.

Anyone know a "better" way to do this that I'm missing?

Thanks, 
  Justin

------
Justin Carlson
carlson@sibyte.com
