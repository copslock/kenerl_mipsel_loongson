Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 20:17:39 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:5050 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122960AbSIISRi>; Mon, 9 Sep 2002 20:17:38 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA03572;
	Mon, 9 Sep 2002 20:17:54 +0200 (MET DST)
Date: Mon, 9 Sep 2002 20:17:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Matthew Dharm <mdharm@momenco.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: LOADADDR and low physical addresses?
In-Reply-To: <20020906144232.E1382@mvista.com>
Message-ID: <Pine.GSO.3.96.1020909201102.28323J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Sep 2002, Jun Sun wrote:

> > And this is where I think the add_memory_region() magic might need to
> > happen.  Do I need to add the on-chip SRAM and control registers using
> > add_memory_region()?  
> 
> I don't think you have to.  I *think* it works if you don't.  Not sure
> know if you actuall do add.

 Well, you have to register usable RAM areas with add_memory_region(), if
you want to make them available to Linux.  Adding other ranges is optional
but you have to consider a part of the kernel may want to know if the
range is usable or occupied (consider e.g. the PCI setup code modifying
BARs).  It's also nice and sometimes useful to a user to let him see what
space is occupied.

 What you register with add_memory_region() is printed upon boot and
available from /proc/iomem.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
