Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2003 19:54:51 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14211 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225209AbTFNSyt>; Sat, 14 Jun 2003 19:54:49 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA06240;
	Sat, 14 Jun 2003 20:55:46 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Sat, 14 Jun 2003 20:55:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>, Dan Malek <dan@embeddededge.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030613232315.GB22949@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030614204954.1934F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 14 Jun 2003, Ralf Baechle wrote:

> > We can use some scheme like Geert was proposing, i.e., named after
> > boards and chipsets.  Hack, I think even naming after board vendor
> > is acceptable.
> 
> Chipsets are a too coarse granularity to structure things these days.
> Modern chipsets integrate a large number of logically independant
> functionality.  Frequently such chipsets are ASICs which consist of
> various logically independant functions licensed from several sources
> and possibly multiple chipset / ASICs are being used in a single
> system.  The world just isn't that simple ...

 What's the deal?  E.g. for a PCI chip we can have a separate file for
each function.  And anything that is not related to a system's core, i.e. 
a peripheral device, belongs to drivers/whatever anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
