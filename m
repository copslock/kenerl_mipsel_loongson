Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 14:23:44 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30949 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225204AbTDWNXn>; Wed, 23 Apr 2003 14:23:43 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA06597;
	Wed, 23 Apr 2003 15:24:10 +0200 (MET DST)
Date: Wed, 23 Apr 2003 15:24:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Jun Sun <jsun@mvista.com>, Jeff Baitis <baitisj@evolution.com>,
	Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org,
	Matthew Dharm <mdharm@momenco.com>
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
In-Reply-To: <20030423022953.B5843@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030423151038.6238A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 23 Apr 2003, Ralf Baechle wrote:

> That's basically the old situation again, just in disguise this time.  In
> practice I fear that's going to be used to keep inferior copies of some
> code alive so let's see if we can avoid it.

 Board-specific variations are unavoidable.  I'll see how to deal with
that as I want to merge the DECstation code (which already supports three
configuration variations) with the generic one.  It needs to be done for
2.5 and shouldn't hurt for 2.4, either. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
