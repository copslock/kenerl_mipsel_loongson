Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 13:26:34 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20195 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1121742AbSKYM0e>; Mon, 25 Nov 2002 13:26:34 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10218;
	Mon, 25 Nov 2002 13:26:52 +0100 (MET)
Date: Mon, 25 Nov 2002 13:26:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Karsten Merker <karsten@excalibur.cologne.de>
cc: linux-mips@linux-mips.org
Subject: Re: [RFT] DEC SCSI driver clean-up
In-Reply-To: <20021124194936.GA6929@excalibur.cologne.de>
Message-ID: <Pine.GSO.3.96.1021125132134.8769C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 24 Nov 2002, Karsten Merker wrote:

> At least a short test on my /150 did not show any problems.

 The change is such that if the driver works at all, it will work in all
cases, not worse then before.  The patch is now in.  Thanks a lot for
testing it. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
