Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 16:51:48 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:33772 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225256AbTGBPvq>;
	Wed, 2 Jul 2003 16:51:46 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h62FpbRd005470;
	Wed, 2 Jul 2003 17:51:37 +0200 (MEST)
Date: Wed, 2 Jul 2003 17:51:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Sirotkin, Alexander" <demiurg@ti.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: do_ri
In-Reply-To: <3F02FBE1.7070107@ti.com>
Message-ID: <Pine.GSO.4.21.0307021750091.15047-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 2 Jul 2003, Sirotkin, Alexander wrote:
> Are you sure ?
> 
> Because "grep -r" shows only 
> 
> ./arch/mips/kernel/traps.c:asmlinkage void do_ri(struct pt_regs *regs)
> ./arch/mips/kernel/traps.c:             do_ri(regs);
> ./arch/mips/lx/lxRi.c:  do_ri(regp);
> 
> On my linux-2.4.17_mvl21 kernel. And I'm quite sure that when my kernel 
> crashes it's not being called from any of these places.

I remember getting bitten by that one, too...

Check out BUILD_HANDLER(ri,ri,sti,silent) in arch/mips/kernel/entry.S.

Grep isn't always your friend, `nm -g' is, in this case :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
