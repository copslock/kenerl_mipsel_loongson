Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jun 2004 09:34:01 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:14244 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225287AbUFMIdu>;
	Sun, 13 Jun 2004 09:33:50 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i5D8XDXK017736;
	Sun, 13 Jun 2004 10:33:13 +0200 (MEST)
Date: Sun, 13 Jun 2004 10:33:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Daney <ddaney@avtrex.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, cgd@broadcom.com,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	binutils@sources.redhat.com
Subject: Re: [Patch] (revised patch) / 0 should send SIGFPE not SIGTRAP 
In-Reply-To: <40CA1FE3.9030507@avtrex.com>
Message-ID: <Pine.GSO.4.58.0406131032350.85@waterleaf.sonytel.be>
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
 <Pine.LNX.4.55.0406112133380.13062@jurand.ds.pg.gda.pl> <40CA1B35.6010603@avtrex.com>
 <40CA1FE3.9030507@avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jun 2004, David Daney wrote:
> David Daney wrote:
> > How about the attached (lightly tested) patch?
> >
> I will quit sending patches after this one.  It is equivalent to the
> previous version, except it uses the symbolic names of the break codes
> instead of the numeric values.

Please send one more, where you use `diff -up' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
