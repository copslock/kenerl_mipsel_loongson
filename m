Received:  by oss.sgi.com id <S553780AbRACLcN>;
	Wed, 3 Jan 2001 03:32:13 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:35738 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553687AbRACLbt>;
	Wed, 3 Jan 2001 03:31:49 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA21067;
	Wed, 3 Jan 2001 12:29:18 +0100 (MET)
Date:   Wed, 3 Jan 2001 12:29:18 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: missing data cache flush in trap_init?
In-Reply-To: <3A5277C6.89170BAD@mvista.com>
Message-ID: <Pine.GSO.3.96.1010103122052.20372B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 2 Jan 2001, Jun Sun wrote:

> The following patch should fix it.  I am not sure if I can use
> flush_cache_range() to have potentially better performance.

 Yes, flush_cache_range() is the right function and it should be used even
if no performance gain is achieved (it is in this case, though).  I can't
comment if that's needed at all, though.  R3k which I use has its data
cache write-through so it doesn't need such a change.  I might check IDT
R4k and possibly IDT R5k docs yet but I have no idea about other
implementations. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
