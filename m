Received:  by oss.sgi.com id <S553698AbRBHXFU>;
	Thu, 8 Feb 2001 15:05:20 -0800
Received: from [62.145.23.107] ([62.145.23.107]:29547 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553683AbRBHXFD>;
	Thu, 8 Feb 2001 15:05:03 -0800
Received: from localhost (1513 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m14R07Z-0007GzC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Fri, 9 Feb 2001 00:05:01 +0100 (CET)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id AAA17674
	for linux-mips@oss.sgi.com; Fri, 9 Feb 2001 00:04:19 +0100
Date:   Fri, 9 Feb 2001 00:04:19 +0100
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@oss.sgi.com
Subject: DECstation crashes
Message-ID: <20010209000419.A17609@excalibur.cologne.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hallo everyone,

I have been experimenting a bit to find out which changes cause the
kernel crashes on DECstations we experience in the last days. A checkout
from 2001-01-30 00:00 works fine, a checkout from 2001-02-02 00:00
crashes. Between these two dates is the large patch merging in the
changes from 2.4.0 -> 2.4.1, so it looks like the bug is somewhere in
there. Any ideas?

Do other Linux/MIPS-targets besides the DECstations show similar problems
(kernel crash due to NULL-pointer dereference in __free_pages_ok just
after mounting the rootfs) or is this a decstation-specific effect? The
problems happens both on R3k and R4k (tested on 5000/20 and 5000/150).

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
