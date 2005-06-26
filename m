Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jun 2005 09:06:41 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:39871 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225753AbVFZIGT>;
	Sun, 26 Jun 2005 09:06:19 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j5Q85Wpr012205;
	Sun, 26 Jun 2005 10:05:34 +0200 (MEST)
Date:	Sun, 26 Jun 2005 10:05:30 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Kumba <kumba@gentoo.org>
cc:	Prashant Viswanathan <vprashant@echelon.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: glibc based toolchain for mips
In-Reply-To: <42BCD015.5030803@gentoo.org>
Message-ID: <Pine.LNX.4.62.0506261003230.16249@numbat.sonytel.be>
References: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4351@miles.echelon.echcorp.com>
 <42BCD015.5030803@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 24 Jun 2005, Kumba wrote:
> Prashant Viswanathan wrote:
> > Thanks. But what I am really looking for is to cross-compile on a Linux i386
> > host. I think the SDE from MIPS can be customized to do this. But I am not
> > sure on how to proceed. Perhaps somebody can point me in the right
> > direction...
> 
> If you have an x86 box running Gentoo, there's the `sys-devel/crossdev`
> package for generating a wide variety of cross-compilers.  If you're running
> another distribution, you'll want to check out Dan Kegel's `crosstool` package
> at: http://kegel.com/crosstool/

And if you're using Debian, apt-get install toolchain-source. But this is
limited to one version, right now gcc 3.4.3 and binutils 2.15. If you need a
different version, fall back to crosstool.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
