Received:  by oss.sgi.com id <S42235AbQJJJle>;
	Tue, 10 Oct 2000 02:41:34 -0700
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21544 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S42213AbQJJJlK>;
	Tue, 10 Oct 2000 02:41:10 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 13ivuH-0003Un-00; Tue, 10 Oct 2000 10:41:09 +0100
Subject: Re: sgiserial.c
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Tue, 10 Oct 2000 10:41:08 +0100 (BST)
Cc:     kaos@melbourne.sgi.com (Keith Owens),
        linux-mips@oss.sgi.com (Linux on MIPS)
In-Reply-To: <20001010054506.F25504@bacchus.dhis.org> from "Ralf Baechle" at Oct 10, 2000 05:45:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ivuH-0003Un-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> The Origin's IOC3 16550 can go even higher rates at low interrupt load
> due to it's higher crystal frequency and a NIC-like DMA descriptors.
> We just don't do it yet in the Linux driver ...

165x0 chips on x86 running in normal FIFO modes we can do 900Kbits pretty
solidly. You should be able to hit the full 2Mbit without trying
