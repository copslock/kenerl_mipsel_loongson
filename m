Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 17:45:17 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13015 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225268AbTDOQpQ>; Tue, 15 Apr 2003 17:45:16 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA17796;
	Tue, 15 Apr 2003 18:45:51 +0200 (MET DST)
Date: Tue, 15 Apr 2003 18:45:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [patch] cp0.config access macros
In-Reply-To: <20030415163558.B8778@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030415183753.13254K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 15 Apr 2003, Ralf Baechle wrote:

> (I'm not sure if in case of the IC, IB, DC and DB bits this is not adding
> some confusion - the same bits with slightly different meaning or position
> exist in various processors so we may want some distinguishable names
> eventually)

 I've put specific macros for such bits in the R10k section.  These shared
among a few processors (and not necessarily only the ones you mention) 
could get different names to emphasize they are not really generic, but I
have no obvious candidate for an adequate prefix.  Any proposals? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
