Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 16:00:36 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:44868 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225202AbVBQQAW>;
	Thu, 17 Feb 2005 16:00:22 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1HG0BH16048;
	Thu, 17 Feb 2005 17:00:11 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1HG0Ac20287;
	Thu, 17 Feb 2005 17:00:10 +0100
Message-ID: <4214BF8A.5090206@schenk.isar.de>
Date:	Thu, 17 Feb 2005 17:00:10 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	TheNop <TheNop@gmx.net>
CC:	linux-mips@linux-mips.org
Subject: Re: configuration of yosemite board with titan 1.2
References: <42146C27.8080404@gmx.net> <42148926.8040306@schenk.isar.de> <4214913A.7000601@gmx.net>
In-Reply-To: <4214913A.7000601@gmx.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

TheNop wrote:
> Hi,
> 
> on the ftp site of PMC I only found kernel 2.4.26 sources supporting
> internal UART.
> I need kernel 2.6.

They have recently (about one week ago) uploaded a kernel 2.6
that supports the internal UART.


> Is it planed to integrate internal UART support to linux-mips.org 2.6
> sources?
> 
> Why PMC-Sierra removed the external UART chip?
> So it is not possible to use current yosemite boards with linux-mips.org 
> :-(
> 

Not without the external UART chip. On my board with chip revision 1.2
the external UART chip is still present. I just had to change some
resistor stuffing option to make it work.
