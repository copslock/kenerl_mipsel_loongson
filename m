Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBKFC6P07531
	for linux-mips-outgoing; Thu, 20 Dec 2001 07:12:06 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBKFBtX07527
	for <linux-mips@oss.sgi.com>; Thu, 20 Dec 2001 07:11:56 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA06453;
	Thu, 20 Dec 2001 15:06:39 +0100 (MET)
Date: Thu, 20 Dec 2001 15:06:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jun Sun <jsun@mvista.com>,
   jim@jtan.com, Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
In-Reply-To: <Pine.GSO.4.21.0112201444280.502-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1011220145351.3556E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 20 Dec 2001, Geert Uytterhoeven wrote:

> Yes, you have <bus>_ioremap() anyway, since plain ioremap() is for PCI only.

 Indeed.  But then ioremap() naming is inconsistent -- pci_ioremap()
should be defined and used for PCI and ioremap() should be reserved for
mapping devices straightly from the CPU's physical space (think devices
plugged into CPU's local memory sockets -- I have one here).

> And then struct busops starts looking like an interesting direction...

 Agreed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
