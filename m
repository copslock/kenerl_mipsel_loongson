Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2003 17:57:30 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:51639 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225377AbTIEQ52>; Fri, 5 Sep 2003 17:57:28 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA07161;
	Fri, 5 Sep 2003 18:57:23 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 5 Sep 2003 18:57:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kip Walker <kwalker@broadcom.com>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] sibyte patch for 2.6 ide.h
In-Reply-To: <3F567D4A.BA3FD396@broadcom.com>
Message-ID: <Pine.GSO.3.96.1030905185304.1692G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 3 Sep 2003, Kip Walker wrote:

> Any objection to the following patch, which lets IDE work on 2.6 for
> SiByte platforms?  Before getting it checked in, I'm willing to hear
> style comments.  I need extra work to happen in ide_init_default_hwifs,
> but that code doesn't fit well in <asm/ide.h> because most of the useful
> declarations in <linux/ide.h> haven't been made yet.  With this patch, I
> hoist the code into a C file, but can call back into the existing code
> (avoiding maintaining a duplicate).

 Hmm, dumb question -- can't your extra work be done in code specific to
the host-adapter?  The ide_init_default_hwifs() function looks like ISA
legacy.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
