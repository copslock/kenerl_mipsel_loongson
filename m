Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 22:54:59 +0100 (BST)
Received: from 206.173.66.57.ptr.us.xo.net ([IPv6:::ffff:206.173.66.57]:44745
	"EHLO tibook.embeddededge.com") by linux-mips.org with ESMTP
	id <S8225477AbUC3Vy6>; Tue, 30 Mar 2004 22:54:58 +0100
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.embeddededge.com (8.11.1/8.11.1) with ESMTP id i2ULuJf00862;
	Tue, 30 Mar 2004 16:56:19 -0500
Message-ID: <4069ED03.8060202@embeddededge.com>
Date: Tue, 30 Mar 2004 16:56:19 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Lees <bob@diamond.demon.co.uk>
CC: linux-mips@linux-mips.org
Subject: Re: Frequency (cpu speed) control on AU1100
References: <200403302137.38123.bob@diamond.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Bob Lees wrote:

 > ....I suspect I am
> missing something somewhere, but I can't find any references to cpu speed 
> control for the MIPS processors, specically the au1x range.

The Au1xxx has a PLL that multiplies the incoming 12 MHz clock up to the
internal frequency.  Just be aware there are lots of peripheral clocks
and bus clocks derived from this internal frequency.  There is code
in the kernel power management to allow changing the frequency during
operation of Linux, but I don't know how well it works today as I have
not tested that for quite some time.

Thanks.


	-- Dan
