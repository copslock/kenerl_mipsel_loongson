Received:  by oss.sgi.com id <S553735AbQK2Mdk>;
	Wed, 29 Nov 2000 04:33:40 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:12777 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553721AbQK2MdS>;
	Wed, 29 Nov 2000 04:33:18 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA15886;
	Wed, 29 Nov 2000 13:10:58 +0100 (MET)
Date:   Wed, 29 Nov 2000 13:10:58 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ulrich Drepper <drepper@cygnus.com>
cc:     Ralf Baechle <ralf@uni-koblenz.de>, "H . J . Lu" <hjl@valinux.com>,
        Nick Clifton <nickc@redhat.com>, binutils@sources.redhat.com,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Update readelf to know about the new ELF constants
In-Reply-To: <m3wvdnsu3z.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.GSO.3.96.1001129130308.13815B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On 28 Nov 2000, Ulrich Drepper wrote:

> > >      EM_MIPS_RS3_LE    10		MIPS RS3000 Little-endian
> > 
> > I don't know where you got this constant's name from, it's name is
> > EM_MIPS_RS4_BE (MIPS R4000 big endian) in all literature and header files
> > I've seen.  RS3000 series from MIPS was a workstation series of the former
> > Mips Computer Systems, Inc.  not a processor.
> 
> This is the name in the current ABI specs.  If it's changed then on
> request of somebody who registered it.

 Well, I would only add the name should probably be EM_MIPS_R3_LE (and
ditto the comment).  We might actually use it for mipsel-linux especially
as the ABI explicitly states EM_MIPS is for big endian machines but I'm
not sure it's worth bothering as the endianness is specified
independently.  I believe all software involved should handle it well -- I
recall Linux, glibc, binutils, modutils all handle both tags fine.  It's
just BFD that does not generate EM_MIPS_R3_LE. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
