Received:  by oss.sgi.com id <S553709AbRCMVcV>;
	Tue, 13 Mar 2001 13:32:21 -0800
Received: from u-89-10.karlsruhe.ipdial.viaginterkom.de ([62.180.10.89]:5114
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553695AbRCMVcH>; Tue, 13 Mar 2001 13:32:07 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2DIRBb19054;
	Tue, 13 Mar 2001 19:27:11 +0100
Date:   Tue, 13 Mar 2001 19:27:11 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Cc:     bunk@fs.tum.de (Adrian Bunk), linux-mips@oss.sgi.com
Subject: Re: Compile error with current CVS kernel
Message-ID: <20010313192711.F1208@bacchus.dhis.org>
References: <20010313152236.B1208@bacchus.dhis.org> <200103131818.TAA14585@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103131818.TAA14585@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Tue, Mar 13, 2001 at 07:18:05PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Mar 13, 2001 at 07:18:05PM +0100, Karel van Houten wrote:

> > That's scary - these sections are explicitly mentioned in the linker
> > script and yet ld places them near address zero.  Oh pleassure, oh
> > garbage.
> > 
> > This can probably be fixed by changing the ldscript; can experiment what
> > it takes to get your ld to place all sections with a LOAD attribute placed
> > next to each other?  My ld behaves fine.
> 
> Can you point me to a binutils version and/or patches that should
> behave OK for native compiles?

It's not native vs. crosscompile; this problem with binutils hits in both
cases and only older versions (which aren't suitable for use with
glibc 2.2 ...) are not affected.

  Ralf
