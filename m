Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2004 16:55:20 +0000 (GMT)
Received: from x1000-57.tellink.net ([IPv6:::ffff:63.161.110.249]:48627 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225315AbUCDQzT>;
	Thu, 4 Mar 2004 16:55:19 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id i24GuQn01252;
	Thu, 4 Mar 2004 11:56:26 -0500
Message-ID: <40475FB9.10701@embeddededge.com>
Date: Thu, 04 Mar 2004 11:56:25 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: sathis kanna <sathiskanna@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: physical memory Limitation
References: <20040303153505.2825.qmail@web14913.mail.yahoo.com> <20040304075906.GB23688@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> We currently don't support compressed kernels.

For AMD/Alchemy boards we do, they work very well, and there
isn't any reason it can't be supported on others.  If you
use boot code like u-boot, you would also get some pretty
nice compressed kernel and initrd support (but the MIPS kernel
doesn't have a very flexible implementation of initrd support).
These features are very useful for embedded systems to maximize
resource utilization, to provide field upgrade, and fallback
recovery methods.

> But if we were supporting it the limitation would depend on size of
> available memory and how it's used at boot time, that is the limit would
> depend on the exact system.

That's true.  For just a compressed kernel, size is no problem.
For initrd support, it's a little more of a challenge.  I have a
board with 128M of SDRAM and we regulary use 64M initrd images
for software install and upgrade.

Thanks.


	-- Dan
