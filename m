Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 08:58:28 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:26791 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225214AbTHAH60>; Fri, 1 Aug 2003 08:58:26 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA03981;
	Fri, 1 Aug 2003 09:58:16 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 1 Aug 2003 09:58:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Subject: Re: Malta + USB on 2.4, anyone?
In-Reply-To: <20030731111506.F14914@mvista.com>
Message-ID: <Pine.GSO.3.96.1030801095654.3800A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 31 Jul 2003, Jun Sun wrote:

> Using the alternative JE driver sovles the problem.  
> 
> I suspect the main UHCI driver does not get cache flushing
> or bus/virt address right.

 Well, since the JE driver is the UHCI driver for 2.6, I wouldn't care.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
