Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M30pu22024
	for linux-mips-outgoing; Mon, 21 Jan 2002 19:00:51 -0800
Received: from father.pmc-sierra.bc.ca (father.pmc-sierra.bc.ca [216.241.224.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M30iP22019
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 19:00:44 -0800
Received: (qmail 17488 invoked by uid 104); 22 Jan 2002 02:00:36 -0000
Received: from Manoj_Ekbote@pmc-sierra.com by father with qmail-scanner-1.00 (uvscan: v4.1.40/v4181. . Clean. Processed in 0.734354 secs); 22 Jan 2002 02:00:36 -0000
Received: from unknown (HELO procyon.pmc-sierra.bc.ca) (134.87.115.1)
  by father.pmc-sierra.bc.ca with SMTP; 22 Jan 2002 02:00:35 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by procyon.pmc-sierra.bc.ca (jason/8.11.6) with ESMTP id g0M20Zm17564
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 18:00:35 -0800 (PST)
Received: by bby1exi01 with Internet Mail Service (5.5.2653.19)
	id <XNR3DG99>; Mon, 21 Jan 2002 18:00:36 -0800
Message-ID: <DC10067A2F4A5944B7811FCF59ABB114745085@sjc2exm01>
From: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: changing the PAGE_OFFSET variable
Date: Mon, 21 Jan 2002 18:00:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am trying to load a kernel on a board whose SDRAM is mapped to 0x8000000.So, the LOADADDR reads 0xa8000000.
In order to generate the correct virtual and physical addresses (for __pa and __va macros), I would have to change the PAGE_OFFSET to 0xa0000000.I guess I would also have to change some routines in include/asm/io.h that translate the virtual addresses to physical addresses and vice versa.
I am not having any PCI access.

Do I need to make any other changes?

Thanks,
Manoj
