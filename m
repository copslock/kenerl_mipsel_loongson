Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 21:40:25 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:15767 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226105AbVGBUkH>;
	Sat, 2 Jul 2005 21:40:07 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j62Ke2pr017362;
	Sat, 2 Jul 2005 22:40:03 +0200 (MEST)
Date:	Sat, 2 Jul 2005 22:39:54 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
cc:	"'Maciej W. Rozycki'" <macro@linux-mips.org>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: top and SMP
In-Reply-To: <20050701172641Z8226172-3678+842@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0507022238060.19703@numbat.sonytel.be>
References: <20050701172641Z8226172-3678+842@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Bryan Althouse wrote:
> Looks like I am running procps version 2.0.7.  The latest is 3.2.5, so I am
> a bit out of date.  I would like to upgrade, but I am having trouble cross
> compiling the latest.  I get this error:
> 	Proc/libproc-3.2.5.so: undefined reference to '__ctype_b'

Is the version of glibc your cross-toolchain links against the same as the
version of glibc on the target?

Last time I saw that one was when trying to run `old' (i.e. dynamically linked
against an older glibc) binaries on a system with a new glibc.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
