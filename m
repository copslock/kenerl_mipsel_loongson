Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 19:46:46 +0000 (GMT)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:2176
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225211AbTBETqq>; Wed, 5 Feb 2003 19:46:46 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h15JlJ205348;
	Wed, 5 Feb 2003 14:47:19 -0500
Message-ID: <3E416A47.2090900@embeddededge.com>
Date: Wed, 05 Feb 2003 14:47:19 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: Bruno Randolf <br1@4g-systems.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: which kernel tree for Au1500?
References: <200302051234.01252.br1@4g-systems.de> <1044464033.9562.22.camel@adsl.pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:

> ....The PM support ... I haven't tested it in
> linux-mips.org but it need a little work anyway.

It needs more than a little work :-)  I have lots of changes that
attempt to support sleep mode on the Au1xxxx.  Everything from
saving/restoring core state, to sdram self refresh, to driver
modifications for PM functions.  I've done this in the sourceforge
kernel and will update the linux-mips tree as I have time.  Some
of the patches will likely require some debate, as they touch software
outside of the core Au1xxx functions.

In addition to the kernel modifications, you need a boot rom that
will support the kernel.  It has to detect a wakeup condition, bring
the memory back the life, perform some processor initialization, and
then return to the kernel.  Basically, copy what Yamon does.  ;-)

If someone is seriously working on this, drop me a note and we can
exchange information.

Thanks.


	-- Dan
