Received:  by oss.sgi.com id <S553941AbRAPTw3>;
	Tue, 16 Jan 2001 11:52:29 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:3290 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553933AbRAPTwU>;
	Tue, 16 Jan 2001 11:52:20 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA26090;
	Tue, 16 Jan 2001 20:52:41 +0100 (MET)
Date:   Tue, 16 Jan 2001 20:52:40 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116194817.B12610@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010116204822.5546Y-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Florian Lohoff wrote:

> Once removed all the debugging stuff even without the mem= parm - Interesting.

 It's weird.  Could you please check it's repeatable?  It might be the
debugging stuff does destructive actions or we trigger an unrelated
problem such as a compiler/assembler/linker bug.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
