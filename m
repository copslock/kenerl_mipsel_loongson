Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 16:18:07 +0100 (CET)
Received: from x1000-57.tellink.net ([63.161.110.249]:42734 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S1122165AbSKHPSH>;
	Fri, 8 Nov 2002 16:18:07 +0100
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id gA8FHMt00686;
	Fri, 8 Nov 2002 10:17:22 -0500
Message-ID: <3DCBD582.200@embeddededge.com>
Date: Fri, 08 Nov 2002 10:17:22 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Burgess <Jon_Burgess@eur.3com.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: EV64120 anybody?
References: <80256C6B.0051C5D4.00@notesmta.eur.3com.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Jon Burgess wrote:

> I think this is the only example of support for a compressed
> kernel image in the linux-mips.org code. There was the start of
> some more generic support in the SF tree but I haven't
> looked at it recently.

I've been doing lots of compressed kernel/initrd work recently
in the Alchemy Au1xxx kernels.  It's part of the SF stuff I'd
like to get into Ralf's tree one of these days so we stop having
different source pools.  IMHO, the MIPS initrd stuff is quite
broken, works only in a few very specific cases.  I have a more
generic version in the SF tree that would be nice to move forward
someday as well.

Most of this work was taken from the PowerPC and ARM versions
of compressing kernels and using initrd, so it looks familiar
to others that may venture out of MIPS-land. :-)

Thanks.


	-- Dan
