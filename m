Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 16:25:13 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:63970 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225220AbTDYPZM>; Fri, 25 Apr 2003 16:25:12 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA14585
	for <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 17:25:31 +0200 (MET DST)
Date: Fri, 25 Apr 2003 17:25:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
Subject: Re: [patch] wait instruction on vr4181
In-Reply-To: <20030424190355.GB19131@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030425165319.14121A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 24 Apr 2003, Thiemo Seufer wrote:

> I have missed this word, but I still can't see how it is relevant to
> the problem. AFAICS adding '-Wa,-4100' to CFLAGS should solve it,
> even in the case of a very old gcc.

 But if I try to build for anything else, say for R3k or MIPS64, there
will be "-mcpu=r3000" or "-mcpu=r4600" passed and an assembly will fail as
the "standby" instruction won't magically disappear.  That's why
r4k_wait() and au1k_wait() use ".set mips3" for "wait". 

 BTW, "-m4100" and friends are deprecated and their interaction with
"-mcpu=", "-march=" and "-mtune=" is unobvious; I have no idea why they
haven't been banished from the trunk, yet.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
