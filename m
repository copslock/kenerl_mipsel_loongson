Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 08:21:49 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:36775 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224935AbVAVIVk>;
	Sat, 22 Jan 2005 08:21:40 +0000
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j0M8LbGU017788;
	Sat, 22 Jan 2005 09:21:37 +0100 (MET)
Date:	Sat, 22 Jan 2005 09:21:36 +0100 (MET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Kumba <kumba@gentoo.org>
cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: O2 and 128Mb
In-Reply-To: <41F1BE9E.8070109@gentoo.org>
Message-ID: <Pine.GSO.4.61.0501220920460.21833@waterleaf.sonytel.be>
References: <1105602134.10493.23.camel@localhost>  <41E627F8.3010004@total-knowledge.com>
  <1105605285.10490.52.camel@localhost>  <41E6CB5B.6080303@total-knowledge.com>
 <1106338775.4760.17.camel@localhost>  <41F168DA.60301@total-knowledge.com>
 <1106342715.4757.27.camel@localhost> <41F1BE9E.8070109@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Jan 2005, Kumba wrote:
> Giuseppe Sacco wrote:
> > Fortunately, I have a second machine that I may use for tests, while
> > I'll find the problem with the first one. The second machine is the same
> > model of the first one. I just swapped disks and cable and made your
> > test: nothing changed.
> 
> Drop minicom, I get nothing but trouble with it.  Use "xc", a small, simple

Indeed.

> dial program.  If it's not on your system, you'll have to install it via
> whatever means your working distro provides, then do this:
> 
> xc -l/dev/ttyS0

Or you can try `cu' (`apt-get install cu'). 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
