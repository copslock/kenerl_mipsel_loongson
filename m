Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 11:55:18 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:7141 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224821AbTHKKzQ>; Mon, 11 Aug 2003 11:55:16 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA18622;
	Mon, 11 Aug 2003 12:55:04 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 11 Aug 2003 12:55:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Chip Coldwell <coldwell@frank.harvard.edu>,
	linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
In-Reply-To: <20030810145425.GE22977@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030811125208.18443A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 10 Aug 2003, Thiemo Seufer wrote:

> Produces the expected output. So it is actually an implementation
> bug in binutils, which isn't fixable for 2.14 and earlier, because
> those have to remain at K&R C level. The K&R requirement was only
> recenly loosened.

 Strangely enough, the Atsushi's code builds just fine with 2.13.2.1. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
