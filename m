Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 22:16:07 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:10852 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20155369AbYIPVQF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2008 22:16:05 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B42693EC9; Tue, 16 Sep 2008 14:16:00 -0700 (PDT)
Message-ID: <48D0220B.4090601@ru.mvista.com>
Date:	Wed, 17 Sep 2008 01:15:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48CA8BEE.1090305@ru.mvista.com>	<20080913.005904.07457691.anemo@mba.ocn.ne.jp>	<48CAA498.9090804@ru.mvista.com> <20080913.213226.106262199.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080913.213226.106262199.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>> Well, let me explain a bit.  The datasheed say I should wait _both_
>>> XFERINT and HOST interrupt.  So, if only one of them was asserted, I
>>> mask it and wait another one.  But on the error case, only HOST was
>>> asserted and XFERINT was never asserted.  Then I could not exit from
>>> "waiting another one" state, until timeout.
>>>       
>>     Hmm, I got it: you decide whether it's worth waiting more for XFEREND 
>> interrupt based on whether ERR is set or not. I suppose IDE_INT doesn't get 
>> set in case the command gets endede with ERR set?
>>     
>
> IIRC, yes.  And anyway, the interrupt signal from this controller to
>   

Thats wrong -- According t the spec. the bit should be set following any 
assertion of INTRQ on IDE bus (possibly not at once though -- after 
flushing FIFO). Well, no wonder with such description of the bits as:


INT_IDE (RWC) [Interrupt]
Is “1” when data transfer completes. This bit is cleared by writing “1” 
to it.
When this bit is set to ‘1’, the following bits of the ATA Interrupt 
Controller Register will be
reset: bits [15:8] (Mask Address Error INT, Mask Reach Multiple INT, 
Mask DEV
Timing Error, Mask Ultra DMA DEV Terminate, Mask Timer INT, Mask Bus 
Error, Mask
Data Transfer End, Mask Host INT), and bits [1:0] (Data Transfer End, 
Host INT).

> CPU is not asserted because HOSTINT was masked by int_ctl register to
> wait for XFERINT interrupt.
>
> So, regardless of IDE_INT was set or not, no more interrupt raised to
> CPU.
>   

Ah, it gets purposedly masked out...

> Many of strangeness of interrupt handling in this driver is based on
> the fact that the IDE_INT bit in DMA status register does not refrect
> the controllers interrupt status directly.

It also seems to reflect the wrong status, i.e. that of the XFEREND 
interrupt...

> And the implementation of
> the IDE_INT bit is actually broken.  Claring the IDE_INT bit also
> clears all mask bits in int_ctl registers.  Usually this sort of
> behaviour is called "bug". ;)
>   

Hm, I thought that was done on purpose to "accelerate" interrupt 
handling or something... it can help indeed if you're not masking those 
interrupts.

> ---
> Atsushi Nemoto
>   

MBR, Sergei
