Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 19:18:43 +0000 (GMT)
Received: from allen.werkleitz.de ([80.190.251.108]:7863 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S8133546AbWAaTS0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 19:18:26 +0000
Received: from p54be8dcc.dip0.t-ipconnect.de ([84.190.141.204] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.60)
	(envelope-from <js@linuxtv.org>)
	id 1F415v-0007sq-3F; Tue, 31 Jan 2006 20:23:20 +0100
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1F415u-0002Jy-00; Tue, 31 Jan 2006 20:23:14 +0100
Date:	Tue, 31 Jan 2006 20:23:14 +0100
From:	Johannes Stezenbach <js@linuxtv.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Message-ID: <20060131192314.GB8826@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl> <20060131181414.GA8288@linuxtv.org> <20060131184253.GA23753@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131184253.GA23753@networkno.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.141.204
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 31, 2006, Thiemo Seufer wrote:
> On Tue, Jan 31, 2006 at 07:14:14PM +0100, Johannes Stezenbach wrote:
> [snip]
> > Yes, that's why I said I'm confused about mips_isa_regsize() vs.
> > mips_abi_regsize().
> > 
> > mips_abi_regsize() correctly says the register size is 32bit for o32,
> > but mips_register_type() calls mips_isa_regsize(), not
> > mips_abi_regsize(). That's why I chose to "fix" mips_isa_regsize().
> > 
> > Or should mips_register_type() simply call mips_abi_regsize()?
> 
> Without having had a look at the code I think that's the right fix.

OK, I'll test if that works for me, and post results here
and to gdb-patches@sources.redhat.com.

Thanks,
Johannes
