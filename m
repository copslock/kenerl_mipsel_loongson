Received:  by oss.sgi.com id <S42301AbQGaQcQ>;
	Mon, 31 Jul 2000 09:32:16 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:51338 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42233AbQGaQcF>;
	Mon, 31 Jul 2000 09:32:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24403;
	Mon, 31 Jul 2000 18:31:57 +0200 (MET DST)
Date:   Mon, 31 Jul 2000 18:31:56 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Dan Aizenstros <dan@vcubed.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Binutils-2.10
In-Reply-To: <39859107.195824A0@vcubed.com>
Message-ID: <Pine.GSO.3.96.1000731182751.21648Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 31 Jul 2000, Dan Aizenstros wrote:

> it is a generated file so how do I generate it?  I am also

 make -C bfd headers

> wondering if changes to this file are missing from the patch
> file.

 It's intentional.  Why would generated files be included in a patch?  It
only makes life more difficult when applying to modified sources.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
