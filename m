Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 14:16:24 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:14194 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022711AbXCXOQW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2007 14:16:22 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E26613ECA; Sat, 24 Mar 2007 07:15:47 -0700 (PDT)
Message-ID: <460532BF.6080605@ru.mvista.com>
Date:	Sat, 24 Mar 2007 17:16:31 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Attila Kinali <attila@kinali.ch>
Cc:	Marco Braga <marco.braga@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>	<200703200204.l2K24WgH020041@centurysys.co.jp>	<45FFEDED.6060708@ru.mvista.com>	<d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>	<45FFFE8B.1010806@ru.mvista.com>	<d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>	<4600052B.40901@ru.mvista.com>	<d459bb380703200908t2ab759f0u352dc0014ebe0b17@mail.gmail.com>	<46000ADD.3050309@ru.mvista.com>	<d459bb380703200933w501736cfmfbd19cc1b03f8ed1@mail.gmail.com> <20070324072308.c69557d0.attila@kinali.ch>
In-Reply-To: <20070324072308.c69557d0.attila@kinali.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Attila Kinali wrote:

>>To sum it up, Cardbus bridge is not a viable solution on Au1500 for
>>hotswapping devices, since any decent one (bus mastering) will not work.
>>USB2.0 should instead work with PCI based controllers, that must be
>>connected to the main PCI device (directly to Au1500).

> We are using a board with a Au1550 with cardbus (PCI1520) and
> USB2.0. The USB controller is directly connected to PCI.
> Although cardbus isn't fully tested yet, USB seems to work fine
> (atleast i haven't heard of any problems), but i don't know
> from the top of my head which chip they used.

> Also, the Au1550 doesn't seem to have the master-behind-bridge
> bug as the 1500 does (at least according to the datasheet),

    Reading revisions C and D of the Au1550 datasheet, I see:

4.3.9 System Considerations

The Au1550 PCI controller cannot be used with external PCI-to-PCI bridges that 
have PCI bus-mastering devices on the secondary bus which target the Au1550 
memory.

> so i guess cardbus should work also with "decent" cards :)

    OTOH, Au1550 errata I have is silent about the P2P bridges.

> HTH 
> 			Attila Kinali

WBR, Sergei
