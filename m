Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 13:55:44 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:8984 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133479AbWAXNz0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 13:55:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0ODwtIH027801;
	Tue, 24 Jan 2006 13:58:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0ODwrNA027800;
	Tue, 24 Jan 2006 13:58:53 GMT
Date:	Tue, 24 Jan 2006 13:58:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-fbdev-devel@lists.sourceforge.net, jgarzik@pobox.com,
	linux-mips@linux-mips.org
Subject: Re: Compiler error in =?utf-8?Q?drivers=2F?=
	=?utf-8?Q?video=2Fcirrusfb=2Ec=3A_syntax_error_before_=E2=80=98volatile?=
	=?utf-8?B?4oCZ?=
Message-ID: <20060124135853.GE3459@linux-mips.org>
References: <20060124025130.GA8418@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124025130.GA8418@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 24, 2006 at 02:51:30AM +0000, Martin Michlmayr wrote:

> I get the following compiler error for drivers/video/cirrusfb.c on
> mips:
> 
>   CC      drivers/video/cirrusfb.o
> In file included from include/video/vga.h:25,
>                  from drivers/video/cirrusfb.c:70:
> include/asm/vga.h:29: error: syntax error before ‘volatile’
> include/asm/vga.h:34: error: syntax error before ‘volatile’
> make[2]: *** [drivers/video/cirrusfb.o] Error 1
> 
> These lines define scr_writew() and scr_readw():
> 
> 29:static inline void scr_writew(u16 val, volatile u16 *addr)
> 34:static inline u16 scr_readw(volatile const u16 *addr)
> 
> Note that some other arches (powerpc, alpha) have the same
> definitions in vga.h.
> 
> This is with 2.6.15.

Interesting catch.  The reason is this code in <linux/vt_buffer.h>:

[...]
#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
#include <asm/vga.h>
#endif

#ifndef VT_BUF_HAVE_RW
#define scr_writew(val, addr) (*(addr) = (val))
#define scr_readw(addr) (*(addr))
#define scr_memcpyw(d, s, c) memcpy(d, s, c)
[...]

But VT_BUF_HAVE_RW is defined in <asm/vga.h>, so if neither
CONFIG_VGA_CONSOLE nor CONFIG_MDA_CONSOLE is defined compilation will
blow up when <asm/vga.h> is being imported later.

  Ralf
