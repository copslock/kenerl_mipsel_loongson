Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2005 15:11:53 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([IPv6:::ffff:212.104.129.139]:58577
	"EHLO mra04.ex.eclipse.net.uk") by linux-mips.org with ESMTP
	id <S8225797AbVEDOLj>; Wed, 4 May 2005 15:11:39 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id 369D3134498;
	Wed,  4 May 2005 15:11:37 +0100 (BST)
Received: from mra04.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra04.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 07388-01-41; Wed,  4 May 2005 15:11:35 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id AE0C4134013;
	Wed,  4 May 2005 14:55:39 +0100 (BST)
Subject: Re:
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org, TheNop@gmx.net
In-Reply-To: <20050428191608Z8225923-1340+6320@linux-mips.org>
References: <20050428191608Z8225923-1340+6320@linux-mips.org>
Content-Type: text/plain
Message-Id: <1115214949.13387.13.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Wed, 04 May 2005 14:55:49 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

I had no problems compiling the linux-2.6.10 kernel from pmc-sierra's
ftp.

>       Make[3]: *** [drivers/char/agp/backend.o] Error 1

Do you need AGP support? My kernel is configured without it.

Alex

On Thu, 2005-04-28 at 20:15, Bryan Althouse wrote:
> Hello,
> 
> I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
> Somehow, I am unable to compile the kernel.  I have tried the 2.6.10 kernel
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
