Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 14:52:32 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:57296 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226168AbTAJOwb>; Fri, 10 Jan 2003 14:52:31 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA27368;
	Fri, 10 Jan 2003 15:52:41 +0100 (MET)
Date: Fri, 10 Jan 2003 15:52:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org,
	Karsten Merker <karsten@excalibur.cologne.de>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: [patch] R4000/R4400 64-bit errata handling
In-Reply-To: <20030110154745.D7699@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030110155123.23678N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 10 Jan 2003, Ralf Baechle wrote:

> > +	__save_and_cli(flags);
> 
> > +	__restore_flags(flags);
> 
> I suggest to replace these with local_irq_save and local_irq_restore.
> They're already deprecated for 2.4 and completly gone in 2.5.

 Sure -- sorry for missing it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
