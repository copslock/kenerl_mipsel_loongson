Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f31Ji9R17013
	for linux-mips-outgoing; Sun, 1 Apr 2001 12:44:09 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f31Ji8M17010
	for <linux-mips@oss.sgi.com>; Sun, 1 Apr 2001 12:44:08 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2ACF17F4; Sun,  1 Apr 2001 21:44:06 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4B2E8F014; Sun,  1 Apr 2001 20:54:32 +0200 (CEST)
Date: Sun, 1 Apr 2001 20:54:32 +0200
From: Florian Lohoff <flo@rfc822.org>
To: vhouten@kpn.com
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
Message-ID: <20010401205432.B12404@paradigm.rfc822.org>
References: <Pine.GSO.3.96.1010329195202.16049B-100000@delta.ds2.pg.gda.pl> <200104011439.QAA12245@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104011439.QAA12245@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Sun, Apr 01, 2001 at 04:39:34PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 01, 2001 at 04:39:34PM +0200, Houten K.H.C. van (Karel) wrote:
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, line 372:
> $0 : 00000000 10010c00 8017fed0 00000000
> $4 : 801fe33c 80200000 813de000 802db000
> $8 : 10010c01 8019af20 00000000 00000000
> $12: 00000000 fffff000 fffffff7 802db060
> $16: 00000000 813de000 00000001 00000000
> $20: 00000005 801cbe34 801eb070 801eb1ac
> $24: 00000000 0000000a
> $28: 8022e000 8022fe88 00000000 80066cc0
> epc   : 8017ff08
> Status: 10010c03
> Cause : 00002010
> Process swapper (pid: 1, stackpage=8022e000)
> 
> etc.
> I have not yet found the time to look further into that...

Guido did that last weekend and discovered that this is a toolchain
problem which disappears when compiling with gcc 3.0

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
