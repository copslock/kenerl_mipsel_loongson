Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 20:13:03 +0000 (GMT)
Received: from [IPv6:::ffff:63.161.110.249] ([IPv6:::ffff:63.161.110.249]:59376
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225253AbTCGUNC>; Fri, 7 Mar 2003 20:13:02 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h27KCIf00870;
	Fri, 7 Mar 2003 15:12:22 -0500
Message-ID: <3E68FD21.5050402@embeddededge.com>
Date: Fri, 07 Mar 2003 15:12:17 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Bruno Randolf <br1@4g-systems.de>,
	Alexander Popov <s_popov@prosyst.bg>, linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg> <1047040846.10649.10.camel@adsl.pacbell.net> <200303071647.13275.br1@4g-systems.de> <20030307101354.N26071@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

> More than likely this is due to the interrupt routing for USB controller
> not being setup correctly.

How did you come to this conclusion?  Is this a PCI USB controller or the
on-chip peripheral?  I have Au1xxx boards were on-chip usb is
required and is working fine.  There aren't any options to configuring
on-chip USB interrupts on Au1xxx.  It could just as likely be a Linux kernel
configuration problem.  We know there is something amiss with Au1xxx USB
in big endian mode, but all LE boards should work fine.

Thanks.


	-- Dan
