Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:49:08 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:54685 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225758AbUDXHtH>; Sat, 24 Apr 2004 08:49:07 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id CBEBC4AEE3; Sat, 24 Apr 2004 09:48:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id F12E6474B6; Sat, 24 Apr 2004 09:48:58 +0200 (CEST)
Date: Sat, 24 Apr 2004 09:48:58 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <Pine.GSO.4.10.10404240931500.13336-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.55.0404240938380.14494@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404240931500.13336-100000@helios.et.put.poznan.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 24 Apr 2004, Stanislaw Skowronek wrote:

> True, the kernel is *huge* (some 7 MB). But there *will* be pointer crops

 Hmm, it depends on the number of drivers built-in -- my binaries are
usually around 3MB.  Or perhaps you should try strip? ;-)  You'll lose
symbol information for ksymoops then, though.

> if I'm using the xkphys, and I can't use ckseg0 because there are only 16
> kilobytes of RAM mapped there for exceptions. So I have to use abi=64. It
> does work for me, anyway.

 Sure, why wouldn't it?  Note, the current Makefile setup is intentionally 
easily tweakable for a fully 64-bit build.

> I think it really should be a config option. Even if not actually
> user-selectable (why should it be?), it should default to 'y' for Octanes
> and 'n' for everything else :)

 Well, I don't need it to be selectable, but I'd set all systems to use
the (n)64 ABI unconditionally, and the next minute someone would complain.  
;-)  Perhaps it can be unconditional for systems where the other setting 
makes no sense at all.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
