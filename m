Received:  by oss.sgi.com id <S553765AbRAHObI>;
	Mon, 8 Jan 2001 06:31:08 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:7140 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553740AbRAHO3p>;
	Mon, 8 Jan 2001 06:29:45 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA00208;
	Mon, 8 Jan 2001 15:16:47 +0100 (MET)
Date:   Mon, 8 Jan 2001 15:16:46 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Michael Shmulevich <michaels@jungo.com>
cc:     Carsten Langgaard <carstenl@mips.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: User applications
In-Reply-To: <3A59C0FB.62E52EF0@jungo.com>
Message-ID: <Pine.GSO.3.96.1010108151023.23234E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 8 Jan 2001, Michael Shmulevich wrote:

> > When a new user process is started will its user space be cleared by the
> > kernel or is there a potential leak from an older user process ?
> 
> Usually it is defied by the loader. If the data section contents is set to
> LOAD, then the contents of the section will be loaded from disk (no leak),
> if not -- whatever values left i nmemory will be there, or exactly, the
> virtual page of some other proccess that was swapped out or ended.

 What!???  I'm assume you are writing about executing a new program and
not forking a new process here.  In the latter case no memory is changed. 
When you exec a new program, any allocated memory is cleared by the kernel
before returning to the user space.  It would be a huge security hole
otherwise.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
