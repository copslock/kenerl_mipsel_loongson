Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 14:21:38 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:40130 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225269AbUBCOVh>; Tue, 3 Feb 2004 14:21:37 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id CAA6A4781E; Tue,  3 Feb 2004 14:21:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B3B9A4622B; Tue,  3 Feb 2004 14:21:29 +0100 (CET)
Date: Tue, 3 Feb 2004 14:21:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mipsel-linux-objcopy problem
In-Reply-To: <Law10-F967gzKHmdpVn0001d29b@hotmail.com>
Message-ID: <Pine.LNX.4.55.0402031413150.16076@jurand.ds.pg.gda.pl>
References: <Law10-F967gzKHmdpVn0001d29b@hotmail.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 2 Feb 2004, Mark and Janice Juszczec wrote:

> # ls -l memload-full
> -rwxr-xr-x    1 root     root      1791550 Feb  1 20:35 memload-full
> 
> mipsel-unknown-linux-gnu-objcopy -Obinary --remove-section=.bss 
> --remove-section=.data --remove-section=.mdebug --pad-to=0x9fe00000 
> memload-full tryrom
> 
> # ls -l tryrom
> -rwxr-xr-x    1 root     root      1725680 Feb  1 21:01 tryrom
> 
> Any idea why tryrom made with mipsel-unknown-linux-gnu-objcopy ver 
> 2.13.90.0.18 is smaller than the one made with mipsel-linux-objcopy ver 
> 2.8.1

 Perhaps there's a bug in one or both of the versions.  2.8.1 is terribly
old and 2.13.90 (as all binutils versions with 9x at the third position)  
is a CVS snapshot.  You may try upgrading to 2.14 before starting further
experiments.

> This is a step in making a rom image for an emulator.  The emulator needs 
> the file tryrom to be  2097152.  I'm stuck.

 What does `readelf -e memload-full' output?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
