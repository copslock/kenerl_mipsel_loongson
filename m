Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 16:57:20 +0100 (BST)
Received: from p508B6205.dip.t-dialin.net ([IPv6:::ffff:80.139.98.5]:4766 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225256AbTGBP5R>; Wed, 2 Jul 2003 16:57:17 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h62Fv8DB008518;
	Wed, 2 Jul 2003 17:57:08 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h62Fv7sJ008517;
	Wed, 2 Jul 2003 17:57:07 +0200
Date: Wed, 2 Jul 2003 17:57:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Sirotkin, Alexander" <demiurg@ti.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: do_ri
Message-ID: <20030702155707.GA6158@linux-mips.org>
References: <3F02FBE1.7070107@ti.com> <Pine.GSO.4.21.0307021750091.15047-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0307021750091.15047-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 02, 2003 at 05:51:37PM +0200, Geert Uytterhoeven wrote:

> > 
> > ./arch/mips/kernel/traps.c:asmlinkage void do_ri(struct pt_regs *regs)
> > ./arch/mips/kernel/traps.c:             do_ri(regs);
> > ./arch/mips/lx/lxRi.c:  do_ri(regp);
> > 
> > On my linux-2.4.17_mvl21 kernel. And I'm quite sure that when my kernel 
> > crashes it's not being called from any of these places.
> 
> I remember getting bitten by that one, too...
> 
> Check out BUILD_HANDLER(ri,ri,sti,silent) in arch/mips/kernel/entry.S.
> 
> Grep isn't always your friend, `nm -g' is, in this case :-)

I guess people not finding the callers of the do_* functions is one of the
most common questions on this list :-)

  Ralf

PS: Ever heared of Intercal? ;-)
