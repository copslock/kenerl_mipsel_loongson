Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2002 12:13:48 +0100 (MET)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:65009 "EHLO
	mail.sonytel.be") by ralf.linux-mips.org with ESMTP
	id <S868809AbSLBLNj>; Mon, 2 Dec 2002 12:13:39 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA14792
	for <linux-mips@linux-mips.org>; Mon, 2 Dec 2002 12:15:54 +0100 (MET)
Date: Mon, 2 Dec 2002 12:15:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: atlas_serial_{in,out}
Message-ID: <Pine.GSO.4.21.0212021213490.10713-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi,

The MIPS 2.4.x drivers/char/serial.c differs from the upstream version by the
addition of hooks for the Atlas serial ports. However, I cannot find where
those hooks (atlas_serial_{in,out}) are actualy defined.

Did I overlook something, or is this a leftover from obsolete code?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
