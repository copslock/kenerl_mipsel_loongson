Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 09:54:29 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:44190 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225203AbTD3Iy1>; Wed, 30 Apr 2003 09:54:27 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA01144;
	Wed, 30 Apr 2003 10:55:10 +0200 (MET DST)
Date: Wed, 30 Apr 2003 10:55:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ralf@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030427233451Z8225245-1272+1630@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030430105326.1016A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 28 Apr 2003 ralf@linux-mips.org wrote:

> Log message:
> 	Somhow those ll/sc counters in their current form are rather useless as
> 	they're only per system, not per thread so for now I'm removing them.
> 	Yell if somebody minds - I just don't think they're really useful in
> 	their current form ...

 One use is to check if the emulation is used at all.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
