Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 19:43:13 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:39887 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8134318AbVI0Smx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2005 19:42:53 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j8RId2va021796;
	Tue, 27 Sep 2005 20:39:02 +0200 (MEST)
Date:	Tue, 27 Sep 2005 20:39:00 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	oski <oski2001@hotmail.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Compiling a kernel for ibm z50
In-Reply-To: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl>
Message-ID: <Pine.LNX.4.62.0509272037590.30305@numbat.sonytel.be>
References: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 Sep 2005, oski wrote:
> I am a newbie trying to compile a kernel for my z50 and up to now failed.
> 
> This is my set up:
> -An old Pentium II box with Redhat 8
> -Downloaded linux-2.6.13.mipscvs-20050904 from www.longlandclan...and bzip2
> and tar into /usr/src.
> -Installed the mipsel crosscompiler from MIPS SDE

This is a FAQ, please use a real mipsel-linux crosscompiler instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
