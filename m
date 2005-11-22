Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 21:06:25 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:28878 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8134460AbVKVVGG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 21:06:06 +0000
Received: (qmail 29247 invoked from network); 22 Nov 2005 21:08:41 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 22 Nov 2005 21:08:41 -0000
Message-ID: <43838957.2020106@ru.mvista.com>
Date:	Wed, 23 Nov 2005 00:10:47 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Retain the write-only OD from being clobbered
References: <20051122205938.GR18119@cosmic.amd.com>
In-Reply-To: <20051122205938.GR18119@cosmic.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Jordan Crouse wrote:

> First of several patches forwarded to me by Sergei Shtylyov.  Ralf,
> these should be good to go for the tree.
> 
> Retain the write-only OD bit from being clobbered by coherency_setup()
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Acked-by: Jordan Crouse <jordan.crouse@amd.com>

    A long story of a long standing bug follows...
    AMD Au1x00 board setup code in au1x00_setup() sets CONFIG.OD bit for the 
early steppings of the Au1x00 SOCs, consulting the PRID table in 
arch/mips/au1000/common/cputable.c. This bit disables the bus transaction 
overlapping which causes a number of errata in those early SOC steppings 
(including the one that I think we've run into with USB host--at least setting 
the bit back to 1 fixed it, although disabling USB host DMA coherency also 
seemd to help). The problem is that this bit is write-only and reads
as 0 on almost all SOCs that need it set. So, when the arch/mm/c-r4k.c code
does RMW to the CONFIG reg. in coherency_setup(), its value is lost, and the
chip again becomes prone to all the nasty errata that it has just been saved
from... :-)
       There's couple more places in the assembly code where the CP0 CONFIG 
reg. is written without care of OD bit:
    1) In the cache parity error handler (arch/mips/mm/cex-gen.S) -- as the 
panic() call follows shortly, probably CACHE.OD=0 doesn't matter much at this 
point;
    2) In arch/mips/au1000/common/sleeper.S, when the CPU regs are being
restored on wakeup; Au1x00 PM code in 2.6 seem to have fallen out of
maintenance, and the stack frame set up there seemed just erratic (2.4
situation in this module is much better).
    I didn't touch both those places. And of course, this CONFIG.OD bug is
present in 2.4 kernels as well...

WBR, Sergei
