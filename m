Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g76CQcRw016718
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 6 Aug 2002 05:26:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g76CQcZm016715
	for linux-mips-outgoing; Tue, 6 Aug 2002 05:26:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g76CPwRw016577
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 05:26:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA12141;
	Tue, 6 Aug 2002 14:26:57 +0200 (MET DST)
Date: Tue, 6 Aug 2002 14:26:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pete Popov <ppopov@mvista.com>
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: DECSTATION breaks xconfig
In-Reply-To: <1028572909.19215.61.camel@zeus.mvista.com>
Message-ID: <Pine.GSO.3.96.1020806142026.11206A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 5 Aug 2002, Pete Popov wrote:

> This "if" in arch/mips/config-shared.in breaks xconfig because there are
> duplicate variables, such as CONFIG_RTC, which are used elsewhere.  Why
> does the DECSTATION RTC and SERIAL_CONSOLE selection have to be in this
> file instead of selecting it from drivers/char/Config.in?

 Both files are broken in this area, e.g. CONFIG_SERIAL in the latter one
should be for CONFIG_ISA or CONFIG_PCI only (it isn't, under the
assumption: "everything is a PC").  I'll see if something non-intrusive
can be cooked; otherwise wait for 2.6. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
