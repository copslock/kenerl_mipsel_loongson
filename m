Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f97GKat21467
	for linux-mips-outgoing; Sun, 7 Oct 2001 09:20:36 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f97GKYD21463
	for <linux-mips@oss.sgi.com>; Sun, 7 Oct 2001 09:20:34 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA27028;
	Sun, 7 Oct 2001 09:20:24 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id JAA12728;
	Sun, 7 Oct 2001 09:20:24 -0700 (PDT)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f97GKNa06701;
	Sun, 7 Oct 2001 18:20:24 +0200 (MEST)
Message-ID: <3BC08164.D7332834@mips.com>
Date: Sun, 07 Oct 2001 18:23:00 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: MIPS PC - anyone?
References: <20011006102302.B3492@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What about a Malta board, it got a PC like structure with ATX form factor, a
Intel PIIX4E South Bridge (containing interrupt controller, RTC and USB), a
Super IO devices (with support for keyboard, 2 UARTs, floppy disk, parallel
port and mouse), AMD ethernet controller, Audio controller, Primary and
Secondary IDE, 4 PCI slots.
I probably forgot something, but the board is more or less designed to be a
"MIPS PC".

/Carsten

Jun Sun wrote:

> Does anybody know if there is such a "MIPS PC" machine?  Essentially
> I am looking for a machine with MIPS CPU and PC peripherals (such as
> SIMM RAM, PCI bus, EIDE HD, VGA graphics, PS/2 mouse/kbd, etc).
>
> It would be really nice to have such a box.  If it is massively produced,
> the price should be cheaper than i386 PCs because MIPS CPU price is
> much cheaper.
>
> Jun
