Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 16:55:35 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:17124 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225220AbTDYPzf>; Fri, 25 Apr 2003 16:55:35 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA14930;
	Fri, 25 Apr 2003 17:55:42 +0200 (MET DST)
Date: Fri, 25 Apr 2003 17:55:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Steven Seeger <sseeger@stellartec.com>
cc: "'Jun Sun'" <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [patch] new wait instruction for vr4181
In-Reply-To: <079701c30aa8$7de13300$3501a8c0@wssseeger>
Message-ID: <Pine.GSO.3.96.1030425175203.14121E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2003, Steven Seeger wrote:

> I think I figured this out. Could someone look at this and tell me if I did
> it right?

 The ifdefs are unnecessary and clutter the code and you should add a
comment near the handcoded instruction, explaining what it is and possibly
sticking a "FIXME" to it.

 BTW, please try to send patches inline in the future. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
