Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2003 13:17:11 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:59128 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224847AbTDBMRK>; Wed, 2 Apr 2003 13:17:10 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA02903;
	Wed, 2 Apr 2003 14:17:15 +0200 (MET DST)
Date: Wed, 2 Apr 2003 14:17:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pete Popov <ppopov@mvista.com>
cc: Hartvig Ekner <hartvig@ekner.info>, Pete@ekner.info,
	Popov@ekner.info,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1500 hardware cache coherency
In-Reply-To: <1049221364.26674.248.camel@zeus.mvista.com>
Message-ID: <Pine.GSO.3.96.1030402141350.1177F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 1 Apr 2003, Pete Popov wrote:

> > I'm not quite sure whether ld_mmu_mips32 is called after au1x00 setup, but if it is,
> > the bit is cleared, never to be set again. Maybe the c0_config macroes should be changed
> > due to errata #4?
> 
> I doubt Ralf is going to change common macros to fix a specific bug.

 You'd better ask instead of guessing.  I would see no problem with such a
workaround IF done cleanly. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
