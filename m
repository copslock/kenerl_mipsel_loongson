Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 22:48:04 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:3024 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225230AbTGVVsC>;
	Tue, 22 Jul 2003 22:48:02 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h6MLlh1W019226;
	Tue, 22 Jul 2003 23:47:43 +0200 (MEST)
Date: Tue, 22 Jul 2003 23:47:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <Pine.GSO.3.96.1030722232705.607L-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.21.0307222346260.27629-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jul 2003, Maciej W. Rozycki wrote:
> On Tue, 22 Jul 2003, Ralf Baechle wrote:
> > I was thinking about that also.  arch/mips64 and include/asm-mips64 will
> > go away but on the other side there will be an option to configure a
> > 64-bit kernel in the menus - which will hopefully be more visible than
> > just two subdirectories.
> 
>  Well, as long as one get that far to run a configuration script (BTW,
> what menus are you referring to? -- I haven't seen any).  Right now that's

It will flash up on your retina and stay there for a while, waiting for your
response, if you run `make oldconfig' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
