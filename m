Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 12:18:01 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17908 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225450AbTISLR6>; Fri, 19 Sep 2003 12:17:58 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA09504;
	Fri, 19 Sep 2003 13:17:50 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 19 Sep 2003 13:17:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Daney <ddaney@avtrex.com>
cc: linux-mips@linux-mips.org
Subject: Re: Will ll/sc work from user space?
In-Reply-To: <3F6A4E41.1090100@avtrex.com>
Message-ID: <Pine.GSO.3.96.1030919130424.9134A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2003, David Daney wrote:

> Q:  Will ll/sc instructions work from a linux user process ?

 Yep.

> If so What happens if there is a context switch between the two?
> 
> What happens if the memory location is paged out and then back into a 
> different physical page?

 Then sc will fail.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
