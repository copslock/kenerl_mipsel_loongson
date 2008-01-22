Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 18:02:11 +0000 (GMT)
Received: from monty.telenet-ops.be ([195.130.132.56]:13743 "EHLO
	monty.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28589455AbYAVSCC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 18:02:02 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by monty.telenet-ops.be (Postfix) with SMTP id 6B43C54031;
	Tue, 22 Jan 2008 19:02:02 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by monty.telenet-ops.be (Postfix) with ESMTP id 4B93854064;
	Tue, 22 Jan 2008 19:02:02 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id m0MI2299027761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jan 2008 19:02:02 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id m0MI22YX027758;
	Tue, 22 Jan 2008 19:02:02 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 22 Jan 2008 19:02:02 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
In-Reply-To: <20080122175734.GA31013@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0801221901380.17593@anakin>
References: <4794DFE1.5040805@nortel.com> <20080122175734.GA31013@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jan 2008, Ralf Baechle wrote:
> On Mon, Jan 21, 2008 at 12:09:37PM -0600, Chris Friesen wrote:
> > We're running a 64-bit kernel and 32-bit userspace.  We've got some code 
> > that is trying to get a 64-bit timestamp in userspace.
> >
> > The following code seems to work fine in the kernel but in userspace it 
> > appears to be swapping the two words in the result.
> >
> > gethrtime(void)
> > {
> >    unsigned long long result;
> >
> >    asm volatile ("rdhwr %0,$31" : "=r" (result));
> 
> Ah, Cavium.
> 
> >    return result;
> > }
> >
> > Do I need to do something special because userspace is 32-bit?  If so, can 
> > someone point me to a reference?
> 
> Ouch.  You found a nasty special case.  Normally 32-bit userspace should
> not use 64-bit values but since you're running a 64-bit kernel.
> 
> unsigned long long gethrtime(void)
> {
> 	unsigned long result;
        ^^^^^^^^^^^^^
	unsigned long long

> 	asm volatile(
> 	"	.set	mips64r2		\n"
> 	"	rdhwr	%M0, $31		\n"
> 	"	sll	%L0, %M0, 0		\n"
> 	"	dsra	%M0, 32			\n"
> 	"	.set	mips0			\n"
> 	: "=r" (result));
> 
> 	return result;
> }
> 
> Note this wouldn't possibly work on a 32-bit kernel because 32-bit kernels
> will corrupt the upper 32-bit of integer registers so you might lose the
> result value before you can stash it away.  Also 32-bit kernels don't allow
> the execution of 64-bit instructions, not even on 64-bit processors.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
