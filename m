Received:  by oss.sgi.com id <S553716AbQKPNdx>;
	Thu, 16 Nov 2000 05:33:53 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:13793 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553702AbQKPNdn>;
	Thu, 16 Nov 2000 05:33:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA15837;
	Thu, 16 Nov 2000 14:23:42 +0100 (MET)
Date:   Thu, 16 Nov 2000 14:23:41 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
In-Reply-To: <3A12F062.5E05CA0B@mvista.com>
Message-ID: <Pine.GSO.3.96.1001116131651.12770B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 15 Nov 2000, Jun Sun wrote:

> I gave more thoughts on this.  While your argument sounds plausible, the
> devil is in "retry" - without a lower-level atomic operation, you cannot
> "restore" the initial condition and conduct a re-try.

 You are right -- it's not that trivial, if at all possible (assuming O(1)
memory usage).

> Come up with a pseudo code to show I am wrong.

 I'm thinking -- I'll provide results if I invent something useful.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
