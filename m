Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2005 04:13:22 +0000 (GMT)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:12635
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224903AbVCRENF>; Fri, 18 Mar 2005 04:13:05 +0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 18 Mar 2005 04:13:03 -0000
Message-ID: <423A554D.2080505@embeddedalley.com>
Date:	Thu, 17 Mar 2005 20:13:01 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
References: <200503151245.15920.eckhardt@satorlaser.com> <200503161808.10088.eckhardt@satorlaser.com> <42386B0A.5070006@embeddedalley.com> <200503171626.01092.eckhardt@satorlaser.com>
In-Reply-To: <200503171626.01092.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Pete Popov wrote:
> 
>>>Looking at EBOOT (a bootloader for win CE that boots off the
>>>compactflash), it tries to access the IDE interface at address 0x1a00000
>>>for io_addr and 0x1a00000e for control, let's see if I can find any IDE
>>>hardware at that address...
>>
>>Uhm, I don't think you'll resolve this that easily. There is some code that
>>needs to go in the au1x00 socket driver which means  you would have to
>>understand pretty well how this thing works. Ultimately the addresses
>>you'll probe are very high ioremapped addresses, since the pcmcia
>>attribute, common mem, and i/o are 36 bit physical addresses.
> 
> 
> Looking at EBOOT, it creates these mappings here in the TLB:
>   0xf 0000 0000  -> 0x1a00 0000 (IO)
>   0xf 4000 0000  -> 0x1c00 0000 (attrib)
>   0xf 8000 0000  -> 0x1e00 0000 (mem)
> each time mapping 32MiB.

> In the Linux PCMCIA code, I see that only the IO range above gets ioremap()ed, 
> and only 4KiB thereof. 

That's all that's really needed.

> For the other two ranges, it uses two addresses that 
> are intended for use with fixup_bigphys_addr()[1] but seem to target the 
> equivalent physical addresses as in EBOOT.

Correct. The pcmcia stack will call ioremap on those phys addresses when necessary.

> I tried simply ioremap()ing the IO region and looked for an ATA interface at 
> the beginning of that range, but the contents of that memory seem to be 
> rather random. 

Well, that's the I/O registers. If you remapped them correctly and you are 
actually talking to the device, then the data should not be so random. But the 
attribute memory is a better first test. Hack up the driver to ioremap the attr 
space after a card is inserted, dump some of that data, and then free the region 
-- just a simple test to make sure the device is powered and you're actually 
talking to it.

> I'll next try to remove both PCMCIA and IDE drivers, just to 
> make sure they don't interact in any unforseeable way with my ad-hoc code, 
> but that's scheduled for tuesday.

> I also found www.ata-atapi.com/atadrvr.zip, which contains low-level driver 
> sourcecode and examples, so I have something to read over the weekend. ;)
> 
> Thank you all for your help!
> 
> Uli
> 
> [1] Why the difference in the handling of the three ranges? Also, what 
> additional effect does ioremap() have when compared to using the TLB? Is it 
> that ioremap() is the Right Way(tm) on any architecture 

Yes.

> while TLB is the way that works only on MIPS?

No, other processors have TLBs too. I assume you're refering to the yamon vs 
Linux kernel. Yamon just uses statically setup TLBs to access those addresses. 
When you call ioremap in the kernel, the kernel will setup the necessary tables 
to be able to map and handle those phys addresses only when needed. Those TLBs 
are flushed randomly, and then reentered by the kernel dynamically when needed 
because of a page fault.

Pete
