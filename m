Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 19:31:35 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:54543 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122121AbSKESbe>;
	Tue, 5 Nov 2002 19:31:34 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 1899PX-0007Sr-00; Tue, 05 Nov 2002 13:30:51 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 1898Uu-0002J1-00; Tue, 05 Nov 2002 13:32:20 -0500
Date: Tue, 5 Nov 2002 13:32:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021105183220.GA8656@nevyn.them.org>
Mail-Followup-To: Richard Sandiford <rsandifo@redhat.com>,
	"Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com> <20021105172627.GA5275@nevyn.them.org> <wvnpttjdgoc.fsf@talisman.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvnpttjdgoc.fsf@talisman.cambridge.redhat.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 06:17:55PM +0000, Richard Sandiford wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
> > Surely we can't...  Remember what EF_MIPS_ARCH says: it's actually what
> > we call ISA level elsewhere!  I just spent a day beating on this and
> > settled for untagged instead of correctly-tagged binaries; I was trying
> > to built SB-1 binaries (that's EF_MIPS_MACH of EF_MIPS_MACH_SB1) for a
> > 32-bit userland (that's EF_MIPS_ARCH_2).  Not just E_MIPS_ABI_O32, but
> > actually -mips2 code.
> 
> I'm not sure what you want from a MIPS II SB-1 binary, though.
> Does it mean that you can't use instructions that are defined
> in the MIPS32 ISA but not the MIPS II one?  But you can use
> the SB-1-specific instructions (i.e. those not defined in the
> MIPS64 ISA)?

Maybe I'm barking up the wrong tree... yes, it seems that I am....

The principal thing is that I want O32 code.  You can't use a higher
ISA level than MIPS2 and still use O32, as far as I understand. And
this setup has a 32-bit kernel, so using MIPS3/4/64 instructions in
userspace is a real losing proposition.

I obviously want -mtune=sb1.  So probably I should just be using
-mtune=sb1 -mips2.  And hack the GENERATE_BRANCHLIKELY test to honor
-mtune.  Blech, I wish these options were less confusing!

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
