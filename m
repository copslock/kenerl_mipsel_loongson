Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 14:21:30 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:49635 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021949AbXCTOV3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 14:21:29 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A8C113ED1; Tue, 20 Mar 2007 07:20:53 -0700 (PDT)
Message-ID: <45FFEDED.6060708@ru.mvista.com>
Date:	Tue, 20 Mar 2007 17:21:33 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Takeyoshi Kikuchi <kikuchi@centurysys.co.jp>
Cc:	Marco Braga <marco.braga@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com> <200703200204.l2K24WgH020041@centurysys.co.jp>
In-Reply-To: <200703200204.l2K24WgH020041@centurysys.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Takeyoshi Kikuchi wrote:

>>we need PCI so Au15xx is our only choice. Internal USB 1.1 is working well,
>>but what about adding a PCI to USB controller? Has anyone tried this?

>>Regards,
>>Marco

> Our Au1500 board works fine with Ricoh CardBus Bridge and NEC USB 
> controller.
> However, the board does not work stably with TI PCI1520 controller.

> ~# lspci 
> 00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 82)
> 00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 82)
> 00:0b.0 RAID bus controller: Triones Technologies, Inc. HPT371/371N (rev 02)
> 05:00.0 USB Controller: NEC Corporation USB (rev 43)
> 05:00.1 USB Controller: NEC Corporation USB (rev 43)
> 05:00.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

    What I don't understand is why use USB card on CardBus, if the Au1500 
datasheet clearly tells us (well, at least me :-) that this is *not* going to 
work?

WBR, Sergei
