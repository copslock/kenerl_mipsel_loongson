Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4SH02nC026382
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 28 May 2002 10:00:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4SH02ri026381
	for linux-mips-outgoing; Tue, 28 May 2002 10:00:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4SGxunC026369
	for <linux-mips@oss.sgi.com>; Tue, 28 May 2002 09:59:56 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA29537;
	Tue, 28 May 2002 10:00:04 -0700
Message-ID: <3CF3B72B.4020600@mvista.com>
Date: Tue, 28 May 2002 09:58:19 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "Steven J. Hill" <sjhill@realitydiluted.com>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
References: <Pine.GSO.4.21.0205271534430.15706-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:

> On Mon, 27 May 2002, Steven J. Hill wrote:
> 
>>Kevin D. Kissell wrote:
>>
>>>I'd like to get a video-capable graphics card up
>>>and running on a MIPS Malta board (therefore
>>>PCI), ideally something mainstream like ATI.
>>>Does anyone on the list have any positive or
>>>negative recommendations in terms of cards
>>>and particularly in terms of the degree to which
>>>the drivers (and PCI set-up) have been ported
>>>to MIPS/Linux?  I'll do what I must, but I hate
>>>re-inventing the wheel.
>>>
>>>
>>I can think of two things. First, a lot of graphics cards
>>rely on BIOS calls to be set up before the operating system
>>even boots. Second, I would stick to graphics cards that
>>have framebuffer support in the kernel as you stand at least
>>half a chance that those cards don't rely so heavily on a
>>peecee bios. Just my $.02.
>>
> 
> Even then, most frame buffer device drivers rely on the firmware (PC BIOS or
> SPARC/PPC Open Firmware) having set up the video card.
> 
> One of the exceptions is matroxfb, 


Steve Longerbeam has a fb driver with BIOS init for ATI Xpert98 card, which 
you can still buy.  Dan Malek also wrote a driver for MQ200.  If you ask 
around, I am sure you can the patch somewhere.

For a while, I also had 3dfx voodoo3 working.  Not sure about its status now. 
  You can find the patch at http://www.medex.hu/~danthe/tdfx/.

Jun
