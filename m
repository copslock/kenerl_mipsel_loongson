Received:  by oss.sgi.com id <S553777AbRAINI0>;
	Tue, 9 Jan 2001 05:08:26 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:50418 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553763AbRAINIC>;
	Tue, 9 Jan 2001 05:08:02 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA13529;
	Tue, 9 Jan 2001 14:00:03 +0100 (MET)
Date:   Tue, 9 Jan 2001 14:00:01 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Michael Shmulevich <michaels@jungo.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: User applications
In-Reply-To: <3A5AFAC8.CA682600@jungo.com>
Message-ID: <Pine.GSO.3.96.1010109135526.9911A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 9 Jan 2001, Michael Shmulevich wrote:

> As a side question, I would like to to know why exactly the CPU cache operations
> are
> promoted to the syscall status? What is the situation that a user in its program
> would like
> to call cacheflush() ? Unless, of course, he is doing DoS.

 Any software that modifes text needs it.  For example the dynamic linker
or libdl. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
