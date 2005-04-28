Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 22:31:26 +0100 (BST)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:6630 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225780AbVD1VbM>; Thu, 28 Apr 2005 22:31:12 +0100
Received: (qmail 16336 invoked by uid 101); 28 Apr 2005 21:31:04 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 28 Apr 2005 21:31:04 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j3SLUv45026981;
	Thu, 28 Apr 2005 14:31:03 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JGC86217>; Thu, 28 Apr 2005 14:30:57 -0700
Message-ID: <04781D450CFF604A9628C8107A62FCCF0257422D@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	"'Bryan Althouse'" <bryan.althouse@3phoenix.com>,
	linux-mips@linux-mips.org
Cc:	TheNop@gmx.net
Subject: RE: 
Date:	Thu, 28 Apr 2005 14:30:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

A quick and dirty fix is to remove CONFIG_HOTPLUG from your .config.  That function needs to be added to the driver code.

-Raj

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Bryan Althouse
> Sent: Thursday, April 28, 2005 12:16 PM
> To: linux-mips@linux-mips.org
> Cc: TheNop@gmx.net
> Subject: 
> 
> 
> Hello,
> 
> I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
> Somehow, I am unable to compile the kernel.  I have tried the 
> 2.6.10 kernel
> trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
> linux-mips.  I am using the 3.3.x cross compile tools from
> ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.
> 
> In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
>        Make[3]: *** [drivers/char/agp/backend.o] Error 1
> 
> 	
> In the case of 2.6.12 from linux-mips, my error looks like:
> 	drivers/net/titan_ge.c1950: error: 
> 'titan_device_remove"  undeclared
> here (not in a function)
> 
> My compile process is like so:
> make mrproper
> make xconfig
> make oldconfig
> make ARCH=mips CROSS_COMPILE=/<tool_path>/mips64-linux-gnu-    vmlinux
> 
> Could someone share their .config with me, or make some suggestions?
> 
> Thank you,
> Bryan
> 
> 
> 
