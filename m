Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 15:29:18 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:49544 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225213AbTHDO3N>; Mon, 4 Aug 2003 15:29:13 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA18966;
	Mon, 4 Aug 2003 16:29:06 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 4 Aug 2003 16:29:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch] More time fixes: do_gettimeofday() & do_settimeofday()
In-Reply-To: <20030801102443.E11120@mvista.com>
Message-ID: <Pine.GSO.3.96.1030804162531.17066F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 1 Aug 2003, Jun Sun wrote:

> To be nit-picking, I might want to replace 'tick' with 'USECS_PER_JIFFY'.

 OK -- since I want to keep USECS_PER_JIFFY_FRAC as otherwise
unrecoverable, I decided to keep USECS_PER_JIFFY as well for consistency. 
But that's only after (or together with) the next patch. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
