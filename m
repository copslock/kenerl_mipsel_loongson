Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0B3EbR06192
	for linux-mips-outgoing; Thu, 10 Jan 2002 19:14:37 -0800
Received: from mother.pmc-sierra.bc.ca (mother.pmc-sierra.bc.ca [216.241.224.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0B3EZg06188
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 19:14:35 -0800
Received: (qmail 14423 invoked by uid 104); 11 Jan 2002 02:14:27 -0000
Received: from Manoj_Ekbote@pmc-sierra.com by mother with qmail-scanner-1.00 (uvscan: v4.1.40/v4180. . Clean. Processed in 0.448729 secs); 11 Jan 2002 02:14:27 -0000
Received: from unknown (HELO procyon.pmc-sierra.bc.ca) (134.87.115.1)
  by mother.pmc-sierra.bc.ca with SMTP; 11 Jan 2002 02:14:27 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by procyon.pmc-sierra.bc.ca (jason/8.11.6) with ESMTP id g0B2EQm22411
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 18:14:26 -0800 (PST)
Received: by bby1exi01 with Internet Mail Service (5.5.2653.19)
	id <XNRN9Z84>; Thu, 10 Jan 2002 18:14:26 -0800
Message-ID: <DC10067A2F4A5944B7811FCF59ABB114745074@sjc2exm01>
From: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: sdram remapped to non-zero address
Date: Thu, 10 Jan 2002 18:13:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I got the latest kernel off the cvs tree and am running it on a board(CPU- RM5710) whose physical address has been remapped
 to 0x8000000, the virtual address being 0xa8000000.
 
The kernel fails while trying to allocate memory for the initbootmem map table.

In the setup_arch() routine of arch/mips/kernel/setup.c, the "start_pfn" variable gets a greater value than "max_pfn" before the
call to init_bootmem().
 I have done relevant changes to the call to add_memory_region() routine in arch/mips/alpine/setup.c.
CONFIG_BLK_DEV_INITRD is not set.

Manoj
