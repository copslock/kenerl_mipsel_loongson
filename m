Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 08:19:10 +0000 (GMT)
Received: from d062149.adsl.hansenet.de ([IPv6:::ffff:80.171.62.149]:27667
	"EHLO gruft.cubic.org") by linux-mips.org with ESMTP
	id <S8224929AbVCUISz>; Mon, 21 Mar 2005 08:18:55 +0000
Received: from cubic.org (starbase [192.168.10.1])
	by gruft.cubic.org (8.12.2/8.12.2) with ESMTP id j2L8Iqm9029305
	for <linux-mips@linux-mips.org>; Mon, 21 Mar 2005 09:18:53 +0100
Message-ID: <423E7B9D.3040908@cubic.org>
Date:	Mon, 21 Mar 2005 08:45:33 +0100
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org>
In-Reply-To: <20050320224028.GB6727@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Sat, Mar 19, 2005 at 02:13:51PM -0800, Andrew Morton wrote:
>  
>
>No argument here.  Pete says the AMD Alchemy UART is just different enough
>to be hard to handle in the 8250 and so the driver is just an ugly
>chainsawed version of the 8250.c
>  
>
Even if I don't make me a lot of friends, the au1x00 driver seems to be 
a hack.

Most of the difference seems to be the PCI stuff, that has been removed 
and the access method.
Shouldn't we have a driver for the chip and one driver for each access 
method (isa,pci,...).
The access method should handle register access and the bus abstraction.
I have a lot of problems with the au1x00 serial driver, because I use it 
together
with a PCMCIA serial port card.

Michael
