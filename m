Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 09:24:05 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:61898 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133353AbWCGJX5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2006 09:23:57 +0000
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k279WDlR002769;
	Tue, 7 Mar 2006 10:32:13 +0100 (MET)
Date:	Tue, 7 Mar 2006 10:32:13 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Francois Romieu <romieu@fr.zoreil.com>,
	Martin Michlmayr <tbm@cyrius.com>, netdev@vger.kernel.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
In-Reply-To: <20060307035824.GA24018@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0603071031520.5292@pademelon.sonytel.be>
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org>
 <20060306225131.GA23327@unjust.cyrius.com> <20060306231530.GB16082@electric-eye.fr.zoreil.com>
 <20060307035824.GA24018@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 7 Mar 2006, Ralf Baechle wrote:
> On Tue, Mar 07, 2006 at 12:15:30AM +0100, Francois Romieu wrote:
> 
> > [...]
> > > Does anyone have comments regarding this patch?  I received
> > > confirmation from a number of Debian users that this patch
> > > significantly improves the lockup situation on Cobalt, so
> > > it would be nice if it could go in.
> > 
> > I'll queue it with the pending de2104x fix(es ?) during my next
> > upkeep.
> 
> I'm just not convinced of having such a workaround as a build option.
> The average person building a a kernel will probably not know if the
> option needs to be enabled or not.

Indeed, if it's mentioned in the errata of the chip, the driver should take
care of it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
