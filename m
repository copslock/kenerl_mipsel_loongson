Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Apr 2004 09:31:25 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:57984 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225776AbUDAIbZ>;
	Thu, 1 Apr 2004 09:31:25 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i318VMdU026574;
	Thu, 1 Apr 2004 10:31:23 +0200 (MEST)
Date: Thu, 1 Apr 2004 10:31:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brian Murphy <brian@murphy.dk>
cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: BUG in pcnet32.c?
In-Reply-To: <406B2E90.5060307@murphy.dk>
Message-ID: <Pine.GSO.4.58.0404011030310.12755@waterleaf.sonytel.be>
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com>
 <406B2E90.5060307@murphy.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 31 Mar 2004, Brian Murphy wrote:
> Anyway the attached patch fixes my problems, is anyone interested in
> reviewing it?

I guess netdev@oss.sgi.com and tsbogend@alpha.franken.de are.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
