Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 18:51:44 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:15540 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225308AbUCQSvn>; Wed, 17 Mar 2004 18:51:43 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 1E79E4B05E; Wed, 17 Mar 2004 19:51:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id D28FF4ADFC; Wed, 17 Mar 2004 19:51:36 +0100 (CET)
Date: Wed, 17 Mar 2004 19:51:36 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
In-Reply-To: <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 9 Mar 2004, Thiemo Seufer wrote:

> >From the different alignment, this _might_ be related to Maciej's
> binutils patch for PAGE_SIZE != 4k.
> http://sources.redhat.com/ml/binutils/2003-12/msg00380.html
> 
> [snip]
> > >> boot -f 2425x1
> > 
> > Cannot load scsi(0)disk(4)rdisk(0)partition(8)/2425x1.
> > Text start 0x8000000, size 0x194400 doesn't fit in a FreeMemory area.
> 
> The text start should be at 0x8002000 or higher, else it will fail.

 It looks like a bug somewhere in binutils, probably BFD.  The segment's
start address should be rounded up to 0x8010000, not down to 0x8000000.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
