Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 15:11:09 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:45444 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225221AbVASPLE>;
	Wed, 19 Jan 2005 15:11:04 +0000
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j0JFA0GU006768;
	Wed, 19 Jan 2005 16:10:00 +0100 (MET)
Date: Wed, 19 Jan 2005 16:10:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Scott Miller <scomille@cisco.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Newbie questions
In-Reply-To: <41EE77B3.30302@cisco.com>
Message-ID: <Pine.GSO.4.61.0501191609360.15516@waterleaf.sonytel.be>
References: <41EE77B3.30302@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Jan 2005, Scott Miller wrote:
> I'm trying to build a MIPS kernel (2.4) and I'm stuck.
> 
> I'm using the MIPS SDE-lite installed on a linux box, but I don't think I have
> it configured properly.  (I have to define things like -D_MIPS_SZLONG in
> CPPFLAGS to get it to compile.)
> 
> I've gotten it all to compile, but it fails to link at the end with undefined
> reference to handle_reserved, handle_watch, handle_adel, etc.
> I assume these are intrinsics in the MIPS libraries, but I can't find them.
> 
> Is there a missing step in my configuration, or am I using the wrong tools?

You must use a compiler targeted for mips(el)-linux.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
