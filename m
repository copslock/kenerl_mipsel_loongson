Received:  by oss.sgi.com id <S42363AbQJCKKu>;
	Tue, 3 Oct 2000 03:10:50 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:14816 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42201AbQJCKKT>;
	Tue, 3 Oct 2000 03:10:19 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA09153;
	Tue, 3 Oct 2000 12:08:32 +0200 (MET DST)
Date:   Tue, 3 Oct 2000 12:08:31 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20001003014451.B614@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001003120613.8359B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 3 Oct 2000, Ralf Baechle wrote:

> I have a nice little solution, we can wrap the divide with ll / sc.  If
> the sc ever fails we took an exception and retry ...

 Could be, but I'm still uncertain whether we want to keep 64-bit code at
all. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
