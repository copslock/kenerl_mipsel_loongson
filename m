Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 21:55:23 +0000 (GMT)
Received: from [IPv6:::ffff:63.161.110.249] ([IPv6:::ffff:63.161.110.249]:62448
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225253AbTCGVzW>; Fri, 7 Mar 2003 21:55:22 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h27LsSf06478;
	Fri, 7 Mar 2003 16:54:28 -0500
Message-ID: <3E691514.7000907@embeddededge.com>
Date: Fri, 07 Mar 2003 16:54:28 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Bruno Randolf <br1@4g-systems.de>,
	Alexander Popov <s_popov@prosyst.bg>, linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E689267.3070509@prosyst.bg> <1047040846.10649.10.camel@adsl.pacbell.net> <200303071647.13275.br1@4g-systems.de> <20030307101354.N26071@mvista.com> <3E68FD21.5050402@embeddededge.com> <20030307133919.P26071@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

> I have seen USB working under BE mode in many instances.  (Acutally
> that I have two that work.).  I don't think endianess is the issue.

Guess I wasn't clear :-)  That comment was directed toward the on-chip
peripheral version of the USB controller.

> Of course, I have only dealt with PCI USB controllers.  On-chip ones may
> have another set of additional issues that I am not aware of.

That's what I wanted to clarify.  Are we discussing one of the on-chip
peripheral USB controllers of the Au1xxx, or is it a PCI USB controller
that was plugged into the Au1500.  In the case of the on-chip controller,
there aren't any interrupt routing problems, it's identical (and the same
code) on all Au1xxx boards.

Thanks.

	-- Dan
