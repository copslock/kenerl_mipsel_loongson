Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 17:21:23 +0000 (GMT)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:5222
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8224817AbVCPRVI>; Wed, 16 Mar 2005 17:21:08 +0000
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 16 Mar 2005 17:21:05 -0000
Message-ID: <42386B0A.5070006@embeddedalley.com>
Date:	Wed, 16 Mar 2005 09:21:14 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
References: <200503151245.15920.eckhardt@satorlaser.com> <200503160816.52467.eckhardt@satorlaser.com> <4237E80F.90305@embeddedalley.com> <200503161808.10088.eckhardt@satorlaser.com>
In-Reply-To: <200503161808.10088.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> OK, I'm just giving a short update on what I've found. In 
> asm-mips/mach-generic/ide.h is a function ide_probe_legacy() which is called 
> to determine IDE support but which returns 0 for my setup. I simply 
> hard-wired this value to 1 and now at least it tries to probe something.
> 
> However, it is looking at ioports in the range 366-3f6, which are already 
> reserved by something else. Anyway, that is rather a legacy PC-style layout 
> and thus probably doesn't apply to the PCMCIA version, if I'm not mistaken. I 
> also tried simply removing the check whether they are reserved, but that just 
> OOPSed.
> 
> Looking at EBOOT (a bootloader for win CE that boots off the compactflash), it 
> tries to access the IDE interface at address 0x1a00000 for io_addr and 
> 0x1a00000e for control, let's see if I can find any IDE hardware at that 
> address...

Uhm, I don't think you'll resolve this that easily. There is some code that 
needs to go in the au1x00 socket driver which means  you would have to 
understand pretty well how this thing works. Ultimately the addresses you'll 
probe are very high ioremapped addresses, since the pcmcia attribute, common 
mem, and i/o are 36 bit physical addresses.

Pete
