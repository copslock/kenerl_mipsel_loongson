Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 00:09:32 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:4031 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226077AbTKZAJU>; Wed, 26 Nov 2003 00:09:20 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 06F654C136; Wed, 26 Nov 2003 01:09:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id ECC6647882; Wed, 26 Nov 2003 01:09:16 +0100 (CET)
Date: Wed, 26 Nov 2003 01:09:16 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
In-Reply-To: <20031125232439.GE11047@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0311260103320.6716@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
 <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl>
 <20031125232439.GE11047@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 26 Nov 2003, Ralf Baechle wrote:

> Guess we'll need a solution along the lines of
> unix/sysv/linux/sparc/sparc32/getpagesize.c then ...

 I suppose so, although being not that fond of insane numbers of syscalls
I wonder how sysdeps/unix/sysv/linux/ia64/getpagesize.c gets away with
static binaries...  Perhaps we should ask glibc hackers?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
