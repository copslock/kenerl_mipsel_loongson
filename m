Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 23:17:12 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:46856 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225786AbVD1WQs>; Thu, 28 Apr 2005 23:16:48 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j3SMAsfg005348;
	Thu, 28 Apr 2005 18:10:55 -0400
In-Reply-To: <8230E1CC35AF9F43839F3049E930169A137228@yang.LibreStream.local>
References: <8230E1CC35AF9F43839F3049E930169A137228@yang.LibreStream.local>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c145ddc72b875ec3833ceba1a849b156@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	"Josh Green" <jgreen@users.sourceforge.net>,
	"Herbert Valerio Riedel" <hvr@hvrlab.org>,
	<linux-mips@linux-mips.org>,
	"Pete Popov" <ppopov@embeddedalley.com>
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: iptables/vmalloc issues on alchemy
Date:	Thu, 28 Apr 2005 18:16:43 -0400
To:	"Christian Gan" <christian.gan@librestream.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Apr 28, 2005, at 5:22 PM, Christian Gan wrote:

> ..... Again it would be okay if I used
> kmalloc or if I disabled CONFIG_64BIT_PHYS_ADDR.

An Au1500 or Au1550 isn't likely to work with this disabled.
PCI and other peripherals exist in the 36-bit space, unless you
disable them.  I suspect all of this got broken with the dynamic
exception handler building.  Prior to that, I suspect it works
fine.  I guess we need to do some regression testing ....

Thanks.


	-- Dan
