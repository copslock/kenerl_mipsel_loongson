Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2003 22:47:39 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:33408 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225320AbTKTWr1>;
	Thu, 20 Nov 2003 22:47:27 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id hAKMoHt01035;
	Thu, 20 Nov 2003 17:50:17 -0500
Message-ID: <3FBD4529.3070201@embeddededge.com>
Date: Thu, 20 Nov 2003 17:50:17 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: Ralf Baechle <ralf@linux-mips.org>, Colin.Helliwell@Zarlink.Com,
	linux-mips@linux-mips.org
Subject: Re: Compressed kernels
References: <20031120223335.03BFFC5F5F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Wolfgang Denk wrote:

> Well, instead of doing this in the Linux kernel, you could also do
> it in the boot loader.  U-Boot supports both gzip and bzip2 decom-
> pression.

Just to keep us busy, there are people that chose options
other than u-boot :-)  For embedded systems that are really sensitive
to boot time and amount of flash used, they may only have minimal
instructions for processor initialization and then jump to the
compressed kernel image.  I'm not going to discuss boot roms any
further (yes, I use u-boot every chance I get).


	-- Dan
