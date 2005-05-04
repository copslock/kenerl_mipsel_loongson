Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2005 15:22:41 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:40877 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225804AbVEDOW0>; Wed, 4 May 2005 15:22:26 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc12) with SMTP
          id <2005050414221801400ks6u8e>; Wed, 4 May 2005 14:22:18 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Alex Gonzalez'" <linux-mips@packetvision.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: 
Date:	Wed, 4 May 2005 10:22:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVQszGDx8CrSHDqSta8AbdCekbhHAAAQP8Q
In-Reply-To: <1115214949.13387.13.camel@euskadi.packetvision>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050504142226Z8225804-1340+6519@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Thanks for your help.  Yes I do need SMP.  Jason Liu of PMC did a check on
my serial number, and found that I have rev 1.1 silicon.  He says I need rev
1.2 in order to use a 2.6.x kernel.  I have shipped my hardware back to them
for an upgrade.  Hopefully, I'll be back in business in a week or two.

Bryan

-----Original Message-----
From: Alex Gonzalez [mailto:linux-mips@packetvision.com] 
Sent: Wednesday, May 04, 2005 9:56 AM
To: Bryan Althouse
Cc: linux-mips@linux-mips.org; TheNop@gmx.net
Subject: Re:

I had no problems compiling the linux-2.6.10 kernel from pmc-sierra's
ftp.

>       Make[3]: *** [drivers/char/agp/backend.o] Error 1

Do you need AGP support? My kernel is configured without it.

Alex

On Thu, 2005-04-28 at 20:15, Bryan Althouse wrote:
> Hello,
> 
> I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
> Somehow, I am unable to compile the kernel.  I have tried the 2.6.10
kernel
> trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
> linux-mips.  I am using the 3.3.x cross compile tools from
> ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.
> 
> In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
>        Make[3]: *** [drivers/char/agp/backend.o] Error 1
> 
> 	
> In the case of 2.6.12 from linux-mips, my error looks like:
> 	drivers/net/titan_ge.c1950: error: 'titan_device_remove"  undeclared
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
