Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 10:14:56 +0200 (CEST)
Received: from mail2.sonytel.be ([195.0.45.172]:40660 "EHLO mail.sonytel.be")
	by linux-mips.org with ESMTP id <S1122978AbSJYIOz>;
	Fri, 25 Oct 2002 10:14:55 +0200
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA25572;
	Fri, 25 Oct 2002 10:14:36 +0200 (MET DST)
Date: Fri, 25 Oct 2002 10:14:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Aric <aricwang@svanetworks.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: can not check out linux repository
In-Reply-To: <000601c27bed$ce019130$4a48a8c0@rd06>
Message-ID: <Pine.GSO.4.21.0210251013470.9034-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 25 Oct 2002, Aric wrote:
> I can't check out the linux directory by execute the following commands:
> 
> c:\> cvs -d :pserver:cvs@oss.sgi.com:/cvs login
>  enter password: cvs

Please use `:pserver:cvs@ftp.linux-mips.org:/home/cvs' instead. The server was
moved.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
