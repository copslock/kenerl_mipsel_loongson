Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 16:22:37 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:11729 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225229AbUCQQWg>; Wed, 17 Mar 2004 16:22:36 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 612414B3CA; Wed, 17 Mar 2004 17:22:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 54D7B4ADFC; Wed, 17 Mar 2004 17:22:30 +0100 (CET)
Date: Wed, 17 Mar 2004 17:22:30 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Patch for o32/n32 mmap on 64-bit kernel
In-Reply-To: <20040309042130.GA21423@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0403171718540.14525@jurand.ds.pg.gda.pl>
References: <20040308214629.GA2568@nevyn.them.org> <20040309042130.GA21423@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 9 Mar 2004, Ralf Baechle wrote:

> > As discussed.  Applies to linux-2.4 cleanly, to linux-2.6 also but you'll
> > need to add:
> 
> Thanks for doing all the work.  Applied,

 Thanks from me, too -- it was on my to-do list.  It should fix at least
one configure script misbehavior -- I'll check if it really does.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
