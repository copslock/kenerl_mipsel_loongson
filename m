Received:  by oss.sgi.com id <S554250AbRBENBY>;
	Mon, 5 Feb 2001 05:01:24 -0800
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3859 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S554248AbRBENBP>;
	Mon, 5 Feb 2001 05:01:15 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14PlGy-0003IW-00; Mon, 5 Feb 2001 13:01:36 +0000
Subject: Re: Filesystem corruption
To:     geert@linux-m68k.org (Geert Uytterhoeven)
Date:   Mon, 5 Feb 2001 13:01:33 +0000 (GMT)
Cc:     alan@lxorguk.ukuu.org.uk (Alan Cox),
        ralf@oss.sgi.com (Ralf Baechle),
        carstenl@mips.com (Carsten Langgaard), linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.4.10.10102051356090.1124-100000@escobaria.sonytel.be> from "Geert Uytterhoeven" at Feb 05, 2001 01:56:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PlGy-0003IW-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Is the zero page mapped on non-m68k architectures?

It can certainly be hit by DMA and kernel memory ops

> > I dont believe any 2.4 is currently 'safe'
> Ugh...

We'll get there, its doing pretty well for most folks
