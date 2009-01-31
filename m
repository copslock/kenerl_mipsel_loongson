Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2009 07:59:53 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:55779 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20611111AbZAaH7u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 31 Jan 2009 07:59:50 +0000
Received: (qmail 21921 invoked from network); 31 Jan 2009 08:59:48 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 31 Jan 2009 08:59:48 +0100
Date:	Sat, 31 Jan 2009 08:59:57 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	linux-mips@linux-mips.org
Subject: [SOLVED] Re: GCC-4.3.3 sillyness
Message-ID: <20090131085957.399614d1@scarran.roarinelk.net>
In-Reply-To: <20090130074407.GA12368@roarinelk.homelinux.net>
References: <20090130074407.GA12368@roarinelk.homelinux.net>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri, 30 Jan 2009 08:44:07 +0100
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Hello,
> 
> Can't build kernel because gcc-4.3.3 comes up with this gem:
> 
>   CC      arch/mips/kernel/traps.o
> cc1: warnings being treated as errors
> /linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
> /linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments

Turns out Gentoo applied a patch (from Debian) which unconditionally
enables -Wformat-security (which is responsible for the warning).

Sorry for the noise!
	Manuel Lauss
