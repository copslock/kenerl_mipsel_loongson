Received:  by oss.sgi.com id <S42440AbQJBLns>;
	Mon, 2 Oct 2000 04:43:48 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:36055 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42232AbQJBLnX>;
	Mon, 2 Oct 2000 04:43:23 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA08876;
	Mon, 2 Oct 2000 13:39:39 +0200 (MET DST)
Date:   Mon, 2 Oct 2000 13:39:39 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000929220103.A396@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1001002133633.6563F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 29 Sep 2000, Florian Lohoff wrote:

> Sorry for the confusion - It seems i was inaccurate - I tried on
> the /260 and it works ... See attached - Ill retry the /125 in a minute.

 Good -- I was really wondering what would be wrong here -- the only
difference between the /260 and the (well-tested) /240 path is the use of
cycle counter routines and they weren't changed seriously.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
