Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2007 13:37:43 +0000 (GMT)
Received: from outmail1.freedom2surf.net ([194.106.33.237]:12984 "EHLO
	outmail1.freedom2surf.net") by ftp.linux-mips.org with ESMTP
	id S28641767AbXAONhi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jan 2007 13:37:38 +0000
Received: from [172.16.97.130] (f2s.colonel-panic.org [83.67.53.76])
	by outmail1.freedom2surf.net (Postfix) with ESMTP
	id 88E31CD92C; Mon, 15 Jan 2007 13:37:30 +0000 (GMT)
Message-ID: <45AB839A.50003@bitbox.co.uk>
Date:	Mon, 15 Jan 2007 13:37:30 +0000
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Alan <alan@lxorguk.ukuu.org.uk>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net> <20070111143116.GA4451@linux-mips.org> <45A79847.1060302@bitbox.co.uk> <20070112144042.74c4edca@localhost.localdomain> <20070112144905.2919e705@localhost.localdomain> <20070114115539.GA5755@linux-mips.org>
In-Reply-To: <20070114115539.GA5755@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Jan 12, 2007 at 02:49:05PM +0000, Alan wrote:
> 
>>>> The GT-64111 passes the CPU addresses straight onto the PCI bus and does 
>>>> not remove the offset of the Galileo's PCI window in CPU space. This 
>>>> means the only PCI I/O addresses that can be supported are 0x1000.0000 
>>>> to 0x11ff.ffff, hence the negative 'io_offset'.
>> Does this mean it can't hit PCI I/O space legacy addresses (0x1F0 etc) ?
>>
>> If so can you set CONFIG_NO_ATA_LEGACY in your platform configuration
> 
> In the meantime I checked this against the Galileo documentation.  Which
> says just like Yoichi and Peter that the GT-64111 is passing local
> addresses in the configured PCI memory or I/O windows straight through to
> the PCI bus.  Reconfiguring the PCI I/O window to start at physical address
> zero is not really an option because the CPU has it's exception vectors
> there.
> 
> There is one inconsistency in the whole story still.  Cobalts use a PC-style
> legacy RTC chip at I/O port 0x70 and that seems to work just fine.  I suspect
> the the VIA Apollo SuperIO chip makes this work by just dropping some of the
> high I/O port address bits ...
> 

I've just checked on the Qube2 here and the RTC can be found at 
0x1000.0070, 0x1001.0070 etc so the VIA bridge is only decoding the low 
16 address lines for I/O space. Handy really otherwise it wouldn't work 
with the GT-64111 :-)

P.
