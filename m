Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 00:25:28 +0100 (BST)
Received: from 206.173.66.57.ptr.us.xo.net ([IPv6:::ffff:206.173.66.57]:7629
	"EHLO tibook.embeddededge.com") by linux-mips.org with ESMTP
	id <S8225479AbUC3XZ1>; Wed, 31 Mar 2004 00:25:27 +0100
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.embeddededge.com (8.11.1/8.11.1) with ESMTP id i2UNQTf00918;
	Tue, 30 Mar 2004 18:26:29 -0500
Message-ID: <406A0225.2060501@embeddededge.com>
Date: Tue, 30 Mar 2004 18:26:29 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Lees <bob@diamond.demon.co.uk>
CC: Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org
Subject: Re: Frequency (cpu speed) control on AU1100
References: <200403302137.38123.bob@diamond.demon.co.uk> <4069ED03.8060202@embeddededge.com> <200403302338.08735.bob@diamond.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Bob Lees wrote:

> Also I can see an approx 40-50mA change in current from 84 to 396MHz which 
> indicates something is changing. 

Uh oh.....You are looking for power saving by dynamically slowing the
processor?  Just enable CONFIG_PM and let it enter its low power wait
at idle.  Certainly the easiest way to save power.  Also, power management
is a whole system design consideration.  Unless you are using an x86
processor, the peripheral logic in a system is going to be much more
of a power mangement problem than the processor.  Low voltage power
conversion and LCD backlights are the killers, not the processor.
If you are using things like Ethernet PHYs in the product, take a close
look at how they can be used in power saving modes.  The AMD PHYs
are particularly good at this, others may be as well, and do the same
kind of analysis for all of the parts on the board.

If you are changing the processor speed, you are going to have to
look carefully how it affects the system bus and the SDRAM timing.
The list goes on.....effective power management is tedious and
challenging...been there, done that quite a bit with this
particular processor.  It's very system dependent.  The stuff in
the Linux kernel is a good starting point, but everything from
the applications to the additions you will have to make in the
kernel are going to be required.

Have fun!


	-- Dan
