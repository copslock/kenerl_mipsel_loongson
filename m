Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 14:17:25 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:48378 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225294AbTDPNRY>; Wed, 16 Apr 2003 14:17:24 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA01871;
	Wed, 16 Apr 2003 15:17:51 +0200 (MET DST)
Date: Wed, 16 Apr 2003 15:17:50 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hartvig Ekner <hartvig@ekner.info>
cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: MIPS32 cache functions now using c-r4k?
In-Reply-To: <3E9D0C34.38FE2749@ekner.info>
Message-ID: <Pine.GSO.3.96.1030416151228.1322A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Apr 2003, Hartvig Ekner wrote:

> Which is:
> 
> 80109654 <r4k_clear_page_d32>:
> 80109654:       24811000        addiu   $at,$a0,4096
> 80109658:       bc8d0000        cache   0xd,0($a0)
> 8010965c:       fc800000        sdc3    $0,0($a0)
> 80109660:       fc800008        sdc3    $0,8($a0)
> 80109664:       fc800010        sdc3    $0,16($a0)
> 80109668:       fc800018        sdc3    $0,24($a0)
> 8010966c:       24840040        addiu   $a0,$a0,64
> 80109670:       bc8dffe0        cache   0xd,-32($a0)
> 80109674:       fc80ffe0        sdc3    $0,-32($a0)
> 80109678:       fc80ffe8        sdc3    $0,-24($a0)
> 8010967c:       fc80fff0        sdc3    $0,-16($a0)
> 80109680:       1424fff5        bne     $at,$a0,80109658 <r4k_clear_page_d32+0x4>
> 80109684:       fc80fff8        sdc3    $0,-8($a0)
> 80109688:       03e00008        jr      $ra
> 
> It seems much of the r4k cache code assumes the presence of SD - which breaks on all MIPS32 CPU's?

 Not much -- only arch/mips/mm/pg-r4k.S.  It looks like MIPS32 needs an
own implementation -- trivially different and half as fast.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
