Received:  by oss.sgi.com id <S42526AbQJFKhP>;
	Fri, 6 Oct 2000 03:37:15 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:17539 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42222AbQJFKgw>;
	Fri, 6 Oct 2000 03:36:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA28253;
	Fri, 6 Oct 2000 12:26:28 +0200 (MET DST)
Date:   Fri, 6 Oct 2000 12:26:28 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>
cc:     Gordon McNutt <gmcnutt@ridgerun.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: insmod hates RELA?
In-Reply-To: <20001006045151.B4123@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001006121819.26752C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 6 Oct 2000, Ralf Baechle wrote:

> A possible explanation would be that you use the wrong binutils, have a
> corrupt module file or try to load a module for another architecture or
> modutils being plain broken?

 The linker tends to create empty .rela sections even if there is no input
for them.  This actually is a minor error and until (unless) we modify the
linker just use the quick fix for modutils that is available from my FTP
site (not that these modutils actually work ;-) ). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
