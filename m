Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 06:06:32 +0000 (GMT)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:23705
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225218AbVCPGGP>; Wed, 16 Mar 2005 06:06:15 +0000
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 16 Mar 2005 06:06:12 -0000
Message-ID: <4237CCDC.1030104@embeddedalley.com>
Date:	Tue, 15 Mar 2005 22:06:20 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: need help with CompactFlash/PCMCIA
References: <200503151245.15920.eckhardt@satorlaser.com> <42371C05.7060401@embeddedalley.com> <200503160651.42705.eckhardt@satorlaser.com>
In-Reply-To: <200503160651.42705.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> On Tuesday 15 March 2005 18:31, Pete Popov wrote:
> 
>>>2. How can I find out if it's looking at the right addresses? I just need
>>>some kind of register which I can probe to find out if the device is
>>>where I think it should be.
>>>
>>>Hmm, in fact I'd be happy about _any_ hint the would get me further. I'm
>>>slightly desparate...
>>
>>Start with the low level routines that detect the card and set the voltage
>>levels. When you plug in the card, is it detected? Are you setting the
>>correct voltages? What happens next -- is the card at least recognized by 
>>the cardmgr, which means that the attribute memory is read correctly?
> 
> 
> I don't see any message that something is found, nor can I definitely say 
> where an error happens. I mainly see two parts: one where cardservices are 
> initialised and one where the driver registers itself. The former doesn't say 
> it found anything at all, maybe that is already the problem... I'll 
> investigate further.

What I meant to say is to add debug prints to the driver so you can see if it 
detects and powers on the slot.

> Could you post the relevant messages of a working system, so I could compare 
> that?

I can do that ... just don't know if I'll get to it in the next couple of days.

> Hmmm, I just had a scary thought: I don't have any userspace programs running 
> yet, meaning also no cardmgr, because I intend to boot from that CF card - is 
> that possible at all? FYI, I don't need any hotplugging at all.

Do you really mean "boot" from it or "root" from it? If you want to "boot" from 
it, you need to work on your boot loader to be able to fetch the kernel from CF. 
If you mean "root" from it, then you are approaching this the wrong way -- it 
won't work through the pcmcia stack and cardmgr because that means you already 
have a root fs up and mounted. You could do this by creating a small ramdisk to 
serve as the root fs, run a special script on startup that loads the driver, 
starts cardmgr, cardmgr then detects the card and loads ide-cs.o, and finally 
the script exits back to the kernel. At that point the kernel mounts the real 
rootfs which is on the card itself.

Or, you use the ide mode/feature of CF and get it to work that way, but I've 
never had to do that myself. Then the card looks like an ide device. That's 
something one of our guys at Embedded Alley has done in the past. Don't know how 
easy it is; I'll ping him.

Pete
