Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 14:30:04 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:40120 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225576AbUDENaC>; Mon, 5 Apr 2004 14:30:02 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id E16854AD95; Mon,  5 Apr 2004 15:29:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id D559E4AC7D; Mon,  5 Apr 2004 15:29:55 +0200 (CEST)
Date: Mon, 5 Apr 2004 15:29:55 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: debian-mips@lists.debian.org, linux-mips@linux-mips.org,
	ralf@gnu.org
Subject: Re: [PATCH] ll/sc emulation fix (was: Kernel vs. glibc problems)
In-Reply-To: <20040404185551.GB31039@excalibur.cologne.de>
Message-ID: <Pine.LNX.4.55.0404051528060.31851@jurand.ds.pg.gda.pl>
References: <20040404115212.GA22445@excalibur.cologne.de>
 <20040404155010.GA1975@bogon.ms20.nix> <20040404173512.GA31039@excalibur.cologne.de>
 <20040404185551.GB31039@excalibur.cologne.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 4 Apr 2004, Karsten Merker wrote:

> i.e. R2k and R3k are assumed to have ll/sc implemented, so the
> ll/sc emulation does not get called. The following micro-patch
> should fix that.

 I've checked in the patch as obviously correct, both to the mainline and
to the 2.4 branch.  Thanks for working on the issue.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
