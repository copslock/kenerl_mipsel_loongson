Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 13:25:06 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:57041 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122165AbSKHMZF>; Fri, 8 Nov 2002 13:25:05 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA03741;
	Fri, 8 Nov 2002 13:25:26 +0100 (MET)
Date: Fri, 8 Nov 2002 13:25:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
In-Reply-To: <20021107142304.B27505@mvista.com>
Message-ID: <Pine.GSO.3.96.1021108132207.3217C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 7 Nov 2002, Jun Sun wrote:

> Yes, this patch takes care of DECSTATION part of the xconfig problem. 

 Thanks for testing.

> Now we still have IP22 config which needs to be fixed.  Any volunteers?

 Renaming CONFIG_SERIAL_CONSOLE to CONFIG_SGI_SERIAL_CONSOLE where
appropriate should suffice.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
