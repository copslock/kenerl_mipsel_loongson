Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 18:34:07 +0100 (CET)
Received: from p508B66C1.dip.t-dialin.net ([80.139.102.193]:24505 "EHLO
	p508B66C1.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSKEReG>; Tue, 5 Nov 2002 18:34:06 +0100
Received: from sccrmhc01.attbi.com ([IPv6:::ffff:204.127.202.61]:41443 "EHLO
	sccrmhc01.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSKEReA>; Tue, 5 Nov 2002 18:34:00 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021105173333.AKB12959.sccrmhc01.attbi.com@lucon.org>;
          Tue, 5 Nov 2002 17:33:33 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 3E04B2C57C; Tue,  5 Nov 2002 09:33:33 -0800 (PST)
Date: Tue, 5 Nov 2002 09:33:33 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Richard Sandiford <rsandifo@redhat.com>,
	"Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021105093333.A3061@lucon.org>
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com> <wvnvg3ct57b.fsf@talisman.cambridge.redhat.com> <20021105172627.GA5275@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021105172627.GA5275@nevyn.them.org>; from dan@debian.org on Tue, Nov 05, 2002 at 12:26:27PM -0500
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 05, 2002 at 12:26:27PM -0500, Daniel Jacobowitz wrote:
> 
> Surely we can't...  Remember what EF_MIPS_ARCH says: it's actually what
> we call ISA level elsewhere!  I just spent a day beating on this and
> settled for untagged instead of correctly-tagged binaries; I was trying
> to built SB-1 binaries (that's EF_MIPS_MACH of EF_MIPS_MACH_SB1) for a
> 32-bit userland (that's EF_MIPS_ARCH_2).  Not just E_MIPS_ABI_O32, but
> actually -mips2 code.
> 

Have you tried my Linux binutils? If you follow the release note, it
may just work.


H.J.
