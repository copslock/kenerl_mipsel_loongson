Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 15:32:33 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:40421 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022185AbXCTPcb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 15:32:31 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 6C1C33ED2; Tue, 20 Mar 2007 08:31:52 -0700 (PDT)
Message-ID: <45FFFE8B.1010806@ru.mvista.com>
Date:	Tue, 20 Mar 2007 18:32:27 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>	 <200703200204.l2K24WgH020041@centurysys.co.jp>	 <45FFEDED.6060708@ru.mvista.com> <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
In-Reply-To: <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Marco Braga wrote:
> 2007/3/20, Sergei Shtylyov <sshtylyov@ru.mvista.com>:

>>     What I don't understand is why use USB card on CardBus, if the Au1500
>> datasheet clearly tells us (well, at least me :-) that this is *not* 
>> going to work?

> I'll reply for my part: we need something hotswappable, and support for
> wifi. The first idea was to use cardbus, so a board was built using 
> PCI1510.
> When the system was projected, USB2.0 was not easy to find (if even 
> existed)
> and almost every wifi card was PCMCIA or Cardbus. The PCI1510 never worked,
> and it seems now that never will. So at the moment an alternative is to try
> a wifi dongle on USB. USB 1.x was too slow, but USB 2.0 seems ok for our
> application. Au1500 does not support USB2.0, so I am looking for a
> PCI/USB2.0 controlles. Does something similar exist? Does it work on 
> Au1500?

    Well, it all should be working fine in the board's own PCI slots, i.e. on 
the primary PCI bus.

> To make it short, we are NOT trying to make USB work on Cardbus, but to use
> either cardbus OR usb. :-)

>  From what you've told me cardbus on PCI (being a bridge) cannot work with
> AU1500's PCI device. So the next idea is to try an USB controller on PCI.
> Will it work? Well, I'm hoping for some fresh hand advice on this.

    Yes, this should work.

> Now Takeyoshi tells me that he's using both USB2.0 and Cardbus (not USB on
> Cardbus), so this seems interesting. I still think that USB is the best way

    From what I saw his USB is not on the primary bus, so he's taking the 
mentioned risks.

> to go, but still a working PCI to Cardbus controller can be interesting. 
> But
> I don't know how he's managed to make it work, since from what you have 
> told
> me it should not work.

    The layout of his PCI busses is not clear from lspci's dump he's cited but 
his USB is clearly in the "risk zone".

> Perhaps he's not using Cardbus devices but PCMCIA.

    It's not me -- it's written in the publicly available datasheet (spec. 
update I have just has more details :-)

WBR, Sergei
