Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 00:30:27 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:61569 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225391AbTJ1AaY>;
	Tue, 28 Oct 2003 00:30:24 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h9S1WA901369;
	Mon, 27 Oct 2003 20:32:10 -0500
Message-ID: <3F9DC719.50700@embeddededge.com>
Date: Mon, 27 Oct 2003 20:32:09 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Herlein <gherlein@herlein.com>
CC: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Pb1500 and PCMCIA booting?
References: <Pine.LNX.4.44.0310271113460.604-100000@io.herlein.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Greg Herlein wrote:

> Does anyone have advice/experience in what's the best way to get 
> linux booting from the Pb1500 development board directly off 
> PCMCIA?

Yes, but actually getting something to boot is the easy part.
When you look down the road to real products there are various
methods of software update/recovery chosen depending upon
the environment, device and features.

> Any advice/gotchas/hints as I start down this path?

There are various open source boot rom projects that you
can use to find examples of doing this.  If you don't want
to replace yamon on the board, just write some code (from
the boot rom examples) that initializes the PCMCIA, knows
how to peruse the file system of your choice, can read
the kernel into memory and jump to it.  Put this code
someplace in the flash so you can start it from yamon.

Depending upon the tools you have, this is probably
the "best" because it doesn't affect a working boot
rom on the board, just extends it use.


	-- Dan
