Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54EYxnC027972
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 07:34:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54EYxGx027971
	for linux-mips-outgoing; Tue, 4 Jun 2002 07:34:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54EYqnC027968;
	Tue, 4 Jun 2002 07:34:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA18282;
	Tue, 4 Jun 2002 16:37:12 +0200 (MET DST)
Date: Tue, 4 Jun 2002 16:37:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Ralf Baechle <ralf@oss.sgi.com>, "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   Jun Sun <jsun@mvista.com>, Alexandr Andreev <andreev@niisi.msk.ru>,
   linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
In-Reply-To: <20020603230107.GH23411@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1020604163438.17556C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 4 Jun 2002, Thiemo Seufer wrote:

> One simple patch [1] is missing from the release. R_MIPS_HIGHEST relocs
> are zeroed out in a few cases where the assembler resolves them itself.
> The rest works for me quite nice.

 How about R_MIPS_26 relocs?  I discovered they are broken for the 64 ABI
(likely a RELA problem) and I am currently working on a fix.  As a result
of the bug a kernel executable is useless. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
