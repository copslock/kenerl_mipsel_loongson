Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Jan 2005 13:41:01 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:15353 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224926AbVAANk4>;
	Sat, 1 Jan 2005 13:40:56 +0000
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j01DeiGU029669;
	Sat, 1 Jan 2005 14:40:45 +0100 (MET)
Date: Sat, 1 Jan 2005 14:40:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20041228080623Z8224908-1340+368@linux-mips.org>
Message-ID: <Pine.GSO.4.61.0501011440070.27452@waterleaf.sonytel.be>
References: <20041228080623Z8224908-1340+368@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Dec 2004 ralf@linux-mips.org wrote:
> Added files:
> 	lib/reed_solomon: .cvsignore 
> 	drivers/input/joystick/iforce: .cvsignore 
> 	drivers/input/touchscreen: .cvsignore 
> 	drivers/scsi/aacraid: .cvsignore 
> 	drivers/isdn/hardware/eicon: .cvsignore 
> 	drivers/char/ipmi: .cvsignore 
> 	drivers/mmc    : .cvsignore 
> 	drivers/media/video/ovcamchip: .cvsignore 
> 	net/bluetooth/cmtp: .cvsignore 
> 	net/bluetooth/bnep: .cvsignore 
> 	net/bluetooth/hidp: .cvsignore 
> 	net/bluetooth/rfcomm: .cvsignore 
> 	sound/mips     : .cvsignore 
> 	security/selinux/ss: .cvsignore 
> 	security/selinux: .cvsignore 
> 	fs/hfsplus     : .cvsignore 
> 
> Log message:
> 	Ignore much much more generated crapola ...

Don't we all use `make O=' these days? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
