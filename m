Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 11:50:54 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:59108 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225198AbVEXKuj>;
	Tue, 24 May 2005 11:50:39 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4OAoOGx032132;
	Tue, 24 May 2005 06:50:24 -0400
Received: from firetop.home (vpn50-30.rdu.redhat.com [172.16.50.30])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4OAoNO22734;
	Tue, 24 May 2005 06:50:23 -0400
Received: from rsandifo by firetop.home with local (Exim 4.50)
	id 1DaWzJ-0001Zs-Bj; Tue, 24 May 2005 11:50:17 +0100
From:	Richard Sandiford <rsandifo@redhat.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
References: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl>
	<Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl>
Date:	Tue, 24 May 2005 11:50:17 +0100
In-Reply-To: <Pine.LNX.4.61L.0505241122290.13738@blysk.ds.pg.gda.pl> (Maciej
	W. Rozycki's message of "Tue, 24 May 2005 11:40:53 +0100 (BST)")
Message-ID: <871x7w99ue.fsf@firetop.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
>  Trying to support GNU extensions in ECOFF is probably hopeless and not 
> worth the hassle and the file format is likely to be obsoleted by the 
> toolchain soon (if not already done), except from BFD -- which'll let you 
> continue doing `objcopy', `objdump', etc.

Yeah.  It's probably also worth noting that we might (soon?) remove the
-mno-explicit-relocs/-mno-split-addresses mode from gcc.  Having both
modes does add to the maintenance burden and the gas support for PIC
relocation operators has been around for a while now.  (It dates back
to binutils 2.14 IIRC.)

Richard
