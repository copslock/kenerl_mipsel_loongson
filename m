Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 15:37:13 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:30607 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225541AbSLTPhN>; Fri, 20 Dec 2002 15:37:13 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA01697;
	Fri, 20 Dec 2002 16:37:19 +0100 (MET)
Date: Fri, 20 Dec 2002 16:37:19 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make highmem only things enclosed in the right #ifdef
In-Reply-To: <m2y96lf03f.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021220163116.1459A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 20 Dec 2002, Juan Quintela wrote:

>         Do you preffer this way?

 It's actually alike to me.  I was ambiguous -- sorry for that.  But in
the context of spacing changes, I assumed it will be obvious I refer to
the double empty line.

 Anyway, the pgd_base variable seems superfluous here.  This patch is
fine.  Thanks for working on it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
