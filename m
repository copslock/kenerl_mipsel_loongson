Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:02:46 +0000 (GMT)
Received: from x1000-57.tellink.net ([IPv6:::ffff:63.161.110.249]:48377 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225366AbUA1PCq>;
	Wed, 28 Jan 2004 15:02:46 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id i0SF3JT00914;
	Wed, 28 Jan 2004 10:03:20 -0500
Message-ID: <4017CF37.4070708@embeddededge.com>
Date: Wed, 28 Jan 2004 10:03:19 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tnt.com>
CC: linux-mips@linux-mips.org
Subject: Re: Linux 2.6 on AMD Alchemy Au1500
References: <4017927B.5080907@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Sylvain Munaut wrote:

> For a new design, we're considering Alchemy Au1500 processor family. I'd 
> like to know what is the current state of the linux 2.6 on this 
> platforms / experiences ?

There are several of us working on it.  The kernel is basically functional,
and we are now in the  midst of the 36-bit addressing updates for the
peripherals, such as PCI.  This should be completed soon.

> I mainly need :
> - PCI support to connect Wifi, IDE controller, USB2.0 Host, FireWire 
> controller
> - Included Ethernet support

If you are looking for product support, you should probably be contacting
people that provide these services :-)  We will eventually get around to
testing all of these devices, but those of us working on this are likely
to have different priorities.

> I've seen in the kernel sources that it should be supported but I'd like 
> to know if there are known issues, comments, ...

The kernel, serial ports, internal Ethernet are all functional.  The PCI
is going to require we complete the 36-bit addressing (as was done in 2.4),
and then I suspect the devices in your list will work as well as the
maintainers of them advertise, since they aren't Au1xxx specific.

Thanks.


	-- Dan
