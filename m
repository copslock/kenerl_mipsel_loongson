Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 23:55:32 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:23437 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225239AbTGVWza>; Tue, 22 Jul 2003 23:55:30 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id AAA11353;
	Wed, 23 Jul 2003 00:55:28 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 23 Jul 2003 00:55:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
In-Reply-To: <20030722223745.GC1660@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030723005259.607P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 23 Jul 2003, Ralf Baechle wrote:

> To add some performance numbers to the debate.  The DS1286 which is one of
> the oldest chips we're supporting has a minimum write cycle time of 150ns.
> The M48T02 which is used in the Origin needs 70ns, 150ns or 200ns depending
> on the version.  Ok, those are slow numbers but they're not as bad as

 Add a number of divisions to get the conversion done to that.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
