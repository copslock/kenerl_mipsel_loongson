Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2005 00:10:25 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:60802
	"EHLO mail.chipsag.com") by linux-mips.org with ESMTP
	id <S8225241AbVBRAKK>; Fri, 18 Feb 2005 00:10:10 +0000
Received: from [10.1.100.35] ([10.1.100.35]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 17 Feb 2005 16:13:05 -0800
Message-ID: <4215325D.5050709@embeddedalley.com>
Date:	Thu, 17 Feb 2005 16:10:05 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Prashant Viswanathan <vprashant@echelon.com>
CC:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: dbAu1550: booting linux from flash
References: <5375D9FB1CC3994D9DCBC47C344EEB59016544F9@miles.echelon.com>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB59016544F9@miles.echelon.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2005 00:13:05.0119 (UTC) FILETIME=[9DEE26F0:01C5154E]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Prashant Viswanathan wrote:
> Hi All,
> 
> I have a dbAu1550 board running Linux. The way it works now, I have YAMON
> booting the kernel via tftp. The kernel itself mounts the root file system
> from NAND flash (JFFS2).
> 
> How can I use YAMON to copy the kernel image to flash (so that I don't have
> to tftp every time)? And what changes would I have to make to the way I
> build the "falsh-resident-kernel" (if any)?

You can put the kernel in NOR flash, but I don't think yamon 
supports the nand part on the board. Putting the kernel in NOR flash 
is easy, especially if you use the zImage support. You can then use 
yamon to just jump to that flash location and the kernel will 
relocate itself from flash to RAM, decompress itself, and boot.

Pete
