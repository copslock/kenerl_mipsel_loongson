Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 18:26:11 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:34319 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122121AbSKER0K>;
	Tue, 5 Nov 2002 18:26:10 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 1898No-0007MI-00; Tue, 05 Nov 2002 12:25:00 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 1897T9-0001Qr-00; Tue, 05 Nov 2002 12:26:27 -0500
Date: Tue, 5 Nov 2002 12:26:27 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021105172627.GA5275@nevyn.them.org>
Mail-Followup-To: Richard Sandiford <rsandifo@redhat.com>,
	"Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 03:19:04PM +0000, Richard Sandiford wrote:
> "Steven J. Hill" <sjhill@realitydiluted.com> writes:
> > In the '_bfd_mips_elf_final_write_processing' function in 'bfd/elfxx-mips.c'
> > If I print out the EF_MIPS_ARCH flags for the input BFD descriptor. It
> > is properly set to 'MIPS2', but when the case statement in
> > '_bfd_mips_elf_final_write_processing' is traversed, it
> > uses the R3000/default case which means that the target CPU architecture
> > didn't get put into the BFD descriptor.
> 
> Is it related to this?
> 
>     <http://sources.redhat.com/ml/binutils/2002-10/msg00248.html>
> 
> (In the message body, I accidentally copied the code after
> the patch rather than before.  Sorry about that.)
> 
> Anyway, that patch won't solve your problem, but the issue
> seems to be the same: _bfd_mips_elf_merge_private_bfd_data()
> merges the EF_MIPS_ARCH and EF_MIPS_MACH bits, but
> _bfd_mips_elf_final_write_processing() overwrites them
> based on the BFD mach.
> 
> Personally, I think _bfd_mips_elf_final_write_processing()
> is doing the right thing.  Surely we ought to be able to
> set EF_MIPS_ARCH and EF_MIPS_MACH based on the value of
> bfd_get_mach?

Surely we can't...  Remember what EF_MIPS_ARCH says: it's actually what
we call ISA level elsewhere!  I just spent a day beating on this and
settled for untagged instead of correctly-tagged binaries; I was trying
to built SB-1 binaries (that's EF_MIPS_MACH of EF_MIPS_MACH_SB1) for a
32-bit userland (that's EF_MIPS_ARCH_2).  Not just E_MIPS_ABI_O32, but
actually -mips2 code.

We can't infer that from the result of bfd_get_mach, I don't think! 
You're moving in the wrong direction.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
