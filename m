Received:  by oss.sgi.com id <S553872AbRAPRIP>;
	Tue, 16 Jan 2001 09:08:15 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:19672 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553870AbRAPRIH>;
	Tue, 16 Jan 2001 09:08:07 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA19782;
	Tue, 16 Jan 2001 18:06:27 +0100 (MET)
Date:   Tue, 16 Jan 2001 18:06:26 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ian Chilton <ian@ichilton.co.uk>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116165534.A26392@woody.ichilton.co.uk>
Message-ID: <Pine.GSO.3.96.1010116180315.5546Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Ian Chilton wrote:

> > mem=0x07800000@0x08800000
> 
> What will I use with 96MB RAM please ?

 "mem=0x05800000@0x08800000"?  Verify it with what is reported last by the
memory map.

> Is someone going to fix it so this param is not needed?

 I guess so.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
