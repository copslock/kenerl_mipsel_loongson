Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 16:28:27 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:63145 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225238AbTGBP2Z>; Wed, 2 Jul 2003 16:28:25 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA23192;
	Wed, 2 Jul 2003 17:28:17 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 2 Jul 2003 17:28:16 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Sirotkin, Alexander" <demiurg@ti.com>
cc: linux-mips@linux-mips.org
Subject: Re: do_ri
In-Reply-To: <3F02F74F.5050300@ti.com>
Message-ID: <Pine.GSO.3.96.1030702172634.21225B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 2 Jul 2003, Sirotkin, Alexander wrote:

> Can anyone please enlighten me about the do_ri function ? I could not
> find any reference to what it does and when it's  called anywhere.

 It's called from arch/mips/kernel/entry.S or
arch/mips64/kernel/r4k_genex.S to handle the Reserved Instruction
exception. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
