Received:  by oss.sgi.com id <S553841AbQJaUWB>;
	Tue, 31 Oct 2000 12:22:01 -0800
Received: from jester.ti.com ([192.94.94.1]:29369 "EHLO jester.ti.com")
	by oss.sgi.com with ESMTP id <S553751AbQJaUVj>;
	Tue, 31 Oct 2000 12:21:39 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id e9VKLXJ28628;
	Tue, 31 Oct 2000 14:21:33 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA20012;
	Tue, 31 Oct 2000 14:21:33 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA20008;
	Tue, 31 Oct 2000 14:21:32 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA25210;
	Tue, 31 Oct 2000 14:21:32 -0600 (CST)
Message-ID: <39FF2AEB.3137F75E@ti.com>
Date:   Tue, 31 Oct 2000 13:26:19 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: MIPS ftp problem!
References: <39FF1A83.387D0E1F@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:

> Hello,
>
> I have a problem with the mips machine. I have an Atlas board and when I
> do ftp on the mips machine from a intel one and I try to transfer files
> ( it works very very slow 0,0234 bytes/s). The same is happening when I
> try to make ftp from the mips machine on a intel box ( all running Linux
> ).
>
> Thanks,
> Nicu

Is this using the Atlas on-board NIC? We found some pretty bad performance
with the on-board NIC and went to the very cheap RTL8139 PCI card from
OvisLink (used the 8139too.o driver). Performance there is pretty good.
--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
