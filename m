Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 19:18:04 +0100 (CET)
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:39421 "EHLO
	executor.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S1122121AbSKESSE>; Tue, 5 Nov 2002 19:18:04 +0100
Received: from talisman.cambridge.redhat.com (talisman.cambridge.redhat.com [172.16.18.81])
	by executor.cambridge.redhat.com (Postfix) with ESMTP
	id F1E05ABAF8; Tue,  5 Nov 2002 18:17:57 +0000 (GMT)
Received: (from rsandifo@localhost)
	by talisman.cambridge.redhat.com (8.11.6/8.11.0) id gA5IHtb11344;
	Tue, 5 Nov 2002 18:17:55 GMT
X-Authentication-Warning: talisman.cambridge.redhat.com: rsandifo set sender to rsandifo@redhat.com using -f
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl>
	<3DC68907.30708@realitydiluted.com>
	<wvnvg3ct57b.fsf@talisman.cambridge.redhat.com>
	<20021105172627.GA5275@nevyn.them.org>
From: Richard Sandiford <rsandifo@redhat.com>
Date: 05 Nov 2002 18:17:55 +0000
In-Reply-To: <20021105172627.GA5275@nevyn.them.org>
Message-ID: <wvnpttjdgoc.fsf@talisman.cambridge.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz <dan@debian.org> writes:
> Surely we can't...  Remember what EF_MIPS_ARCH says: it's actually what
> we call ISA level elsewhere!  I just spent a day beating on this and
> settled for untagged instead of correctly-tagged binaries; I was trying
> to built SB-1 binaries (that's EF_MIPS_MACH of EF_MIPS_MACH_SB1) for a
> 32-bit userland (that's EF_MIPS_ARCH_2).  Not just E_MIPS_ABI_O32, but
> actually -mips2 code.

I'm not sure what you want from a MIPS II SB-1 binary, though.
Does it mean that you can't use instructions that are defined
in the MIPS32 ISA but not the MIPS II one?  But you can use
the SB-1-specific instructions (i.e. those not defined in the
MIPS64 ISA)?

Richard
