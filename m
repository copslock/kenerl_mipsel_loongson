Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 21:14:20 +0000 (GMT)
Received: from 69-149-250-3.ded.swbell.net ([IPv6:::ffff:69.149.250.3]:41351
	"EHLO optic.calpha.com") by linux-mips.org with ESMTP
	id <S8225216AbVAaVOE>; Mon, 31 Jan 2005 21:14:04 +0000
Received: from mail.okerson.com (optic [127.0.0.1])
	by optic.calpha.com (8.12.11/8.12.11) with ESMTP id j0VLF7GO021189;
	Mon, 31 Jan 2005 15:15:08 -0600
Received: from 66.93.44.28 (proxying for 127.0.0.1)
        (SquirrelMail authenticated user ed);
        by mail.okerson.com with HTTP;
        Mon, 31 Jan 2005 13:15:09 -0800 (PST)
Message-ID: <43357.66.93.44.28.1107206109.squirrel@66.93.44.28>
In-Reply-To: <ecb4efd10501311207faf0550@mail.gmail.com>
References: <ecb4efd10501311207faf0550@mail.gmail.com>
Date:	Mon, 31 Jan 2005 13:15:09 -0800 (PST)
Subject: Re: initial bootstrap and jtag
From:	"Ed Okerson" <ed@okerson.com>
To:	"Clem Taylor" <clem.taylor@gmail.com>
Cc:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <ed@okerson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed@okerson.com
Precedence: bulk
X-list: linux-mips

I use the BDI-2000 for an AU1500 based board.  For the boot loader I found
u-boot to be very functional.  It did require a bit of patching to handle
the Au1500 in little endian mode, but since that is now done everything
works great.

Ed Okerson

> We are finishing up the design of our new Au1550 based board. I was
> wondering if someone could recommend an ejtag wiggler. I need
> something that has full linux host support, is good enough to flash a
> bootloader and do some minimal debug while getting the board support
> working. Looking over the list some people seem to be using the
> Abatron BDI 2000 and others are using the Macraigor mpDemon. What do
> you guys recommend?
>
> This is my first time doing embedded linux, but I've done quite a bit
> with DSPs (written bootloaders, flash programmers, etc). I was
> wondering how people go about bootstrapping new Au1xxx systems. Who is
> responsible for configuring the PLL or SDRAM enough to allow code to
> be loaded into SDRAM? Are bootloaders like YAMON position independent
> to run out of SDRAM?
>
>                                      Thanks,
>                                      Clem
>
