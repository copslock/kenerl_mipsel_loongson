Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 23:38:29 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:51966 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225254AbVEEWiN>; Thu, 5 May 2005 23:38:13 +0100
Received: (qmail 11875 invoked by uid 101); 5 May 2005 22:38:02 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 5 May 2005 22:38:02 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j45MbwD8012701
	for <linux-mips@linux-mips.org>; Thu, 5 May 2005 15:38:02 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JGC9BS8M>; Thu, 5 May 2005 15:37:58 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259024380C6@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject:  CF custom implementation
Date:	Thu, 5 May 2005 15:37:56 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Kiran_Thota@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Kiran_Thota@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Hello!,
  I am working on a MIPS-based processor SoC which has a custom CF implementation over Local Bus.
The CF doesnt support IO mode, interrupts,  32-bit support.
It has limited register support [no interface registers to reset the CF]. I am using 2.6.10 from linux-mips.
I have already written a PCMCIA/CF socket socket for the same.
The goal is to use the CF cards as memoy devices. Advise me on the path to take:

PCMCIA/CF ->CS/DS -> IDE [I found a patch to make IDE work in polled mode]
PCMCIA/CF -> CS/DS -> MTD [drivers/mtc/maps/pcmciamtd.c]

I am currently using Lexar and Hitachi Compact Flash cards.
The CIS can be read and when the Linux boots up and I invoke cardmgr [v3.2.8], it sees the device as 
ATA/IDE Fixed Disk [Func = 4 (Fixed Disk) ]
Is there a way to force it to come up in memory only mode? Please suggest.

Thanks,
Kiran
