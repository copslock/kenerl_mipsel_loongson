Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 11:26:59 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:61896 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225213AbTGaK05>; Thu, 31 Jul 2003 11:26:57 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA18201;
	Thu, 31 Jul 2003 12:26:45 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 31 Jul 2003 12:26:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Subject: Re: Malta + USB on 2.4, anyone?
In-Reply-To: <20030730191219.A14914@mvista.com>
Message-ID: <Pine.GSO.3.96.1030731121705.17497D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jul 2003, Jun Sun wrote:

> Has anybody tried USB on malta with 2.4 kernel?  I just found that
> I got 0xff IRQ number and kernel panics.

 Possibly IRQ routing is broken -- the PIIX4 uses INTD for its USB
controller's interrupt.  For the Malta it should be routed to the IRQ11
input of the PIIX4's internal dual-8259A PIC.  What does `/sbin/lspci -vv
-s 00:0a.2' print?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
