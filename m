Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 18:15:34 +0100 (CET)
Received: from p508B66C1.dip.t-dialin.net ([80.139.102.193]:22969 "EHLO
	p508B66C1.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKERPd>; Tue, 5 Nov 2002 18:15:33 +0100
Received: from sccrmhc02.attbi.com ([IPv6:::ffff:204.127.202.62]:52866 "EHLO
	sccrmhc02.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSKERPY>; Tue, 5 Nov 2002 18:15:24 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021105171502.OXMZ5946.sccrmhc02.attbi.com@lucon.org>;
          Tue, 5 Nov 2002 17:15:02 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id DECA22C57C; Tue,  5 Nov 2002 09:15:00 -0800 (PST)
Date: Tue, 5 Nov 2002 09:15:00 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021105091500.A2743@lucon.org>
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>; from rsandifo@redhat.com on Tue, Nov 05, 2002 at 03:19:04PM +0000
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
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
> 
> I wonder whether _bfd_mips_elf_merge_private_bfd_data() should
> be checking for compatibility based on the BFD machs rather
> than the header flags.  It seems a bit odd that we check the
> ISA level and "machine" separately.
> 
> In other words, replace:
> 
>   /* Compare the ISA's.  */
>   if ((new_flags & (EF_MIPS_ARCH | EF_MIPS_MACH))
>       != (old_flags & (EF_MIPS_ARCH | EF_MIPS_MACH)))
>     {
>       ...
>     }
> 
> with code that checks bfd_get_mach (ibfd) against bfd_get_mach (obfd).
> If ibfd's architecture is an extension of obfd's, copy it to obfd.

The FSF binutils has never been right. I have fixed it in my Linux
binutils. See my followups on this thread.


H.J.
