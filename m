Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 15:21:33 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:29138 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225264AbTDOOVd>; Tue, 15 Apr 2003 15:21:33 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA15979;
	Tue, 15 Apr 2003 16:22:12 +0200 (MET DST)
Date: Tue, 15 Apr 2003 16:22:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
cc: source@mvista.com
Subject: wbflush() abuse for TOSHIBA_RBTX4927
Message-ID: <Pine.GSO.3.96.1030415161611.13254H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 I see wbflush() is abused in an interesting and inefficient way for
TOSHIBA_RBTX4927.  Is there any specific reason for such a setup?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
