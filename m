Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 16:05:21 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:54164 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225226AbUBCQFU>; Tue, 3 Feb 2004 16:05:20 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D7F6047828; Tue,  3 Feb 2004 17:04:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 32657474C8; Tue,  3 Feb 2004 17:04:44 +0100 (CET)
Date: Tue, 3 Feb 2004 17:04:44 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20040203154935.GB1018@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402031704120.16076@jurand.ds.pg.gda.pl>
References: <20040202141939Z8225226-9616+1555@linux-mips.org>
 <Pine.LNX.4.55.0402021611490.6182@jurand.ds.pg.gda.pl>
 <20040202152307.GB28673@linux-mips.org> <Pine.LNX.4.55.0402031612100.16076@jurand.ds.pg.gda.pl>
 <20040203154935.GB1018@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 3 Feb 2004, Ralf Baechle wrote:

> I don't know details but since the person who answered my question was
> directly working on the CPU design I have to take that as authoritative
> information and after all, the systems seems stable.

 OK then.

> Daring a guess, the CPU restarts the pipeline following an eret therefore
> instructions preceeding the eret can't cause the problem.

 That's possible.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
