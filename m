Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 20:21:48 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:11791 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225216AbVAaUVc>; Mon, 31 Jan 2005 20:21:32 +0000
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j0VK2bIe030255;
	Mon, 31 Jan 2005 15:02:37 -0500
In-Reply-To: <ecb4efd10501311207faf0550@mail.gmail.com>
References: <ecb4efd10501311207faf0550@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4166eb6110a431795ca07047de8d347a@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: initial bootstrap and jtag
Date:	Mon, 31 Jan 2005 15:21:26 -0500
To:	Clem Taylor <clem.taylor@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Jan 31, 2005, at 3:07 PM, Clem Taylor wrote:

> .... Looking over the list some people seem to be using the
> Abatron BDI 2000 ...

This is clearly the best.

> ....  Who is
> responsible for configuring the PLL or SDRAM enough to allow code to
> be loaded into SDRAM?

Code in the boot rom.  Plus, they likely do much more.  YAMON does lots
of board specific initialization, so when porting Linux to an Au1xxx 
that doesn't
use YAMON, you are going to have to add to the Linux initialization 
functions
for the board.  U-Boot is a popular boot monitor that is now finding 
it's way
to the Au1xxx processors.

> ... Are bootloaders like YAMON position independent
> to run out of SDRAM?

Yes, they usually do that.


	-- Dan
