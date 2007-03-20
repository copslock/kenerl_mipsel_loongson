Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 16:00:45 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:14310 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022201AbXCTQAl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 16:00:41 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E047C3ED1; Tue, 20 Mar 2007 09:00:06 -0700 (PDT)
Message-ID: <4600052B.40901@ru.mvista.com>
Date:	Tue, 20 Mar 2007 19:00:43 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>	 <200703200204.l2K24WgH020041@centurysys.co.jp>	 <45FFEDED.6060708@ru.mvista.com>	 <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>	 <45FFFE8B.1010806@ru.mvista.com> <d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>
In-Reply-To: <d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marco Braga wrote:

> I think I'm beginning to make a lot of confusion. Is the problem that the
> PCI1510 must NOT be behind a bridge, or the problem is that PCI1510 acts as
> a bridge, so cardbus cards cannot work?

    The second.

> This is my lspci at start:

> 00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)
> 00:0d.0 Non-VGA unclassified device: Texas Instruments TMS320DM642 (rev 01)
> 00:12.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus 
> Controller

    You can see yourself that PCI1510 is a bridge (Cardbus-to-PCI bridge is 
largely the same as PCI-to-PCI bridge).

> While this is the situation when I load yenta_socket:

> 00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)
> 00:0d.0 Non-VGA unclassified device: Texas Instruments TMS320DM642 (rev 01)
> 00:12.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus 
> Controller
> 01:00.0 Network controller: 3Com Corporation 3com 3CRWE154G72 [Office
> Connect Wireless LAN Adapter] (rev 01)

> So it seems that the 3Com card is behind a bus. Should this work? From what
> I've understood, it should now work..

    Think again. :-)

> In fact my problem is that it seems to work if I try to ping a host, but it fails when I try some serious 
> transfer.
> In this case, at some point, any readl() on 3Com returns 0xFFFFFFFF. 
> Just to
> test I've tried a pci_config_read() on the PCI1510 and it fails. The entire
> boards seems hung. The only thing I can do is to remove the 3Com card.

   Sounds like what's been told in the errata 32.

> Thanks!

WBR, Sergei
