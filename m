Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 00:47:24 +0000 (GMT)
Received: from smtp002.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.126]:11688
	"HELO smtp002.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8225325AbVBBArI>; Wed, 2 Feb 2005 00:47:08 +0000
Received: from unknown (HELO ?10.2.2.64?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp002.bizmail.yahoo.com with SMTP; 2 Feb 2005 00:47:06 -0000
Message-ID: <4200230A.6020002@embeddedalley.com>
Date:	Tue, 01 Feb 2005 16:47:06 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Josh Green <jgreen@users.sourceforge.net>
CC:	linux-mips@linux-mips.org
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
In-Reply-To: <1107304567.2912.34.camel@SillyPuddy.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Josh Green wrote:
> I'm using the latest Linux MIPS CVS (2.6.11-rc2) on an AMD Alchemy
> DB1100 with a tool chain created with buildroot (gcc 3.4.3, binutils
> 2.15.91.0.2) and found a bug in drivers/pcmcia/au1000_generic.c that was
> causing the following error during initialization (not exact text, close
> as I can remember), and subsequently the PCMCIA hardware was unavailable
> (pcmcia_register_socket() was failing due to NULL resource_opts field).
> 
> au1x00_pcmcia: probe of au1x00-pcmcia0 failed with error -22

Interesting. I haven't seen this problem with a slightly older kernel.

> Additionally I noticed that some of the 36 bit constants in
> au1000_generic.h (AU1X_SOCK0_IO and AU1X_SOCK1_IO) were causing the
> warning "Integer constant too large for long type" (IIRC).  Here is a
> patch for this, although I'm not sure if this is the correct way to fix
> it, or even if it was causing problems or not, although it does get rid
> of the warnings.

Thanks, will apply.


> Some additional problems that I have been experiencing, but am still
> investigating.  If anyone has any ideas of what is causing these, I'd
> love to hear them.
> 
> I have 2 Senao 802.11b PCMCIA cards and I'm using the hostap_cs driver.
> If I initialize pcmcia (cardmgr) with both cards in the PCMCIA slots
> only one of them will initialize, the second one causes an error:
> 
> Linux Kernel Card Services
>   options:  none
> hostap_cs: 0.2.6 - 2004-12-25 (Jouni Malinen <jkmaline@cc.hut.fi>)
> hostap_cs: Registered netdevice wifi0
> hostap_cs: index 0x01: Vcc 3.3, irq 34, io 0xc0000000-0xc000003f
> wifi0: NIC: id=0x800c v1.0.0
> wifi0: PRI: id=0x15 v1.1.0
> wifi0: STA: id=0x1f v1.4.9
> 0.0: RequestIO: Configuration locked    <--- Second card causes this
> 0.0: GetNextTuple: No more items
> ds: unable to create instance of 'hostap_cs'!
> 
> 
> If I bring up PCMCIA without the cards in, and then insert one, and then
> the other, both cards initialize fine and I get wlan0 and wlan1.

No suggestions right now.

> The other problem I've experienced is a kernel oops when ejecting a
> card.  While it isn't a problem for my project (should never be
> inserting/ejecting cards) I thought I'd mention it.  Here is the oops
> output, I wasn't able to use ksymoops since I'm having trouble building
> a cross compiled version (buildroot didn't install libbfd, etc from
> binutils), so this may or may not be useful:

I'll take a look at this.

Pete
