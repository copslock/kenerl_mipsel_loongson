Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2006 21:26:50 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:42989 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20039933AbWLOV0q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Dec 2006 21:26:46 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 642B48814; Sat, 16 Dec 2006 01:26:44 +0400 (SAMT)
Message-ID: <45831375.4060303@dev.rtsoft.ru>
Date:	Sat, 16 Dec 2006 00:28:21 +0300
From:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	elmar gerdes <elmar.gerdes@engel-kg.com>
Cc:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: Question on UDC driver for the Alchemy Au1550
References: <20061214234250.Q13369@pogo.engel-kg.com>
In-Reply-To: <20061214234250.Q13369@pogo.engel-kg.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hello.

elmar gerdes wrote:
> to make this short:

>   Is anybody working on a UDC driver for the Alchemy Au1550
>   (MIPS-based)?

> If you are interested in details, please read on:

> I'm working with an Au1550-based board and would like to run it as a USB
> device.  There have been a few drivers around for Au1xxx-based boards,
> but none of them seems to be adequate for this processor (or else I
> missed something...):

>  a) in the kernel tree: arch/mips/au1000/common/usbdev.c
> 
>     This one was for Au1000, Au1100, and Au1500 IIRC.  But it didn't
>     even compile for quite some kernel versions and now it has been
>     removed from the tree.

> The first driver (usbdev.c) cannot work this way, but the access to

    It was written by MontaVista in the ancient times when there was no USB
gadget stack I think. It was never completeed because of the known USB device
  interrupt latency issues in the early revisions of Au1xx0 chips.

> registers and endpoints is like that for the Au1500 which should be
> correct for the Au1500, too.  But the Au1550's DMA differs.

> The second driver (au1200udc.c / amd5536udc.c) has the same DMA, but the
> registers and endpoint stuff are different, and it supports USB 2.0
> whereas the Au1550 only supports USB 1.1.

    Au1200 has OTG controller, hasn't it?

> It looks like the Au1550 needs a driver merged from the 2 (or 3) above
> drivers.

    Probably.

> Is anybody working on that?  Can anybody point me to some projects,
> people or other source code that could help me?

    I think Rodolfo Giometti was working on Au1100 (and hence Au1000/1500) USB
device support.
    The topic of Alchemy USB device has been touched several times on 
linux-mips, I'd suggest to look thru the list archives. Getting the Au1550 
spec. update would be a good idea too... although you're probably lucky with 
Au1550 -- I'm not seeing any USB device errata listed for there.

> Regards,

>     Elmar

WBR, Sergei
