Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2003 13:22:21 +0000 (GMT)
Received: from x1000-57.tellink.net ([IPv6:::ffff:63.161.110.249]:12783 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225585AbTLBNWU>;
	Tue, 2 Dec 2003 13:22:20 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id hB2DP5Z00727;
	Tue, 2 Dec 2003 08:25:06 -0500
Message-ID: <3FCC92B1.2080206@embeddededge.com>
Date: Tue, 02 Dec 2003 08:25:05 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Okerson <eokerson@texasconnect.net>
CC: linux-mips@linux-mips.org
Subject: Re: Compact Flash on AU1500
References: <Pine.LNX.4.44.0312011710320.24981-100000@dallas.texasconnect.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Ed Okerson wrote:

> I recently finished work on u-boot to get it to read a compact flash
> properly on the AU1500.  Now I need to get it working under Linux as well,
> but have a few questions.  Is root fs on CF supported under 2.4.22?

I guess you mean a CF card in a PCMCIA slot.  There are boards that
use a CF through a CPLD connected to the processor bus, which works with
the usual custom IDE setup functions.

The kernel isn't going to support CF on PCMCIA the way you are asking
without some, ummm..."customizations" :-)  You have to modify the PCMCIA
functions so they don't try to use the slot, but you still need to
initialize the I/O.  Then you need a set of IDE setup/support functions in
your board specific files.

This can be done, but isn't pretty and I doubt would ever be selected
as something to be part of a standard kernel.  You may also want to
consider some kind of initrd or small flash file system that has the
PCMCIA services.  You would boot up using something else as the root
file system, then activate the CF on PCMCIA as a source of additional
mounted file systems.

Good Luck!


	-- Dan
