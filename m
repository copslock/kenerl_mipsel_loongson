Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 20:01:43 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:33166 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTGPTBl>; Wed, 16 Jul 2003 20:01:41 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA00767;
	Wed, 16 Jul 2003 21:01:38 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 16 Jul 2003 21:01:37 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: sudo oops on mips64 linux_2_4
In-Reply-To: <20030716184515.GA971@kopretinka>
Message-ID: <Pine.GSO.3.96.1030716205804.25959K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2003, Ladislav Michl wrote:

> >  At least we know the error is in drivers/video/fbmem.c:fbmem_read_proc() 
> 
> and at least we know there is something wrong. why is fbmem compiled in
> at all?

 Well, that's not wrong per se and is actually valid at least for
CONFIG_FB_VIRTUAL.  And the code should fail gracefully if there nothing
useful to do.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
