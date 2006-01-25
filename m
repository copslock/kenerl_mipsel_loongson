Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 12:27:24 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:29628 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133502AbWAYM1G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2006 12:27:06 +0000
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k0PCSqYL021746;
	Wed, 25 Jan 2006 13:28:57 +0100 (MET)
Date:	Wed, 25 Jan 2006 13:28:51 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Akinobu Mita <mita@miraclelinux.com>
cc:	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	parisc-linux@parisc-linux.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
In-Reply-To: <20060125113446.GF18584@miraclelinux.com>
Message-ID: <Pine.LNX.4.62.0601251323420.19174@pademelon.sonytel.be>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113446.GF18584@miraclelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Jan 2006, Akinobu Mita wrote:
> If the arechitecture is
> - BITS_PER_LONG == 64
> - struct thread_info.flag 32 is bits
> - second argument of test_bit() was void *
> 
> Then compiler print error message on test_ti_thread_flags()
> in include/linux/thread_info.h
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> ---
>  thread_info.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: 2.6-git/include/linux/thread_info.h
> ===================================================================
> --- 2.6-git.orig/include/linux/thread_info.h	2006-01-25 19:07:12.000000000 +0900
> +++ 2.6-git/include/linux/thread_info.h	2006-01-25 19:14:26.000000000 +0900
> @@ -49,7 +49,7 @@
>  
>  static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
>  {
> -	return test_bit(flag,&ti->flags);
> +	return test_bit(flag, (void *)&ti->flags);
>  }

This is not safe. The bitops are defined to work on unsigned long only, so
flags should be changed to unsigned long instead, or you should use a
temporary.

Affected platforms:
  - alpha: flags is unsigned int
  - ia64, sh, x86_64: flags is __u32

The only affected 64-platforms are little endian, so it will silently work
after your change, though...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
