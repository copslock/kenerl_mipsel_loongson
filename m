Received:  by oss.sgi.com id <S553891AbQKMR5W>;
	Mon, 13 Nov 2000 09:57:22 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:12218 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553860AbQKMR46>;
	Mon, 13 Nov 2000 09:56:58 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA12619;
	Mon, 13 Nov 2000 18:53:21 +0100 (MET)
Date:   Mon, 13 Nov 2000 18:53:20 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
cc:     linux-mips@oss.sgi.com
Subject: Re: Patch Problems with Glibc 2.2
In-Reply-To: <20001105235715.A5531@woody.ichilton.co.uk>
Message-ID: <Pine.GSO.3.96.1001113184904.12211A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 5 Nov 2000, Ian Chilton wrote:

> I am having a problem with patch under glibc 2.2
> 
> patch: **** Only garbage was found in the patch input.
> 
> If I exit my chroot, back to my 2.0.6 base and use the same source dir, with the same patch there, it works fine, so it is definatly the patch program.
> 
> It was compiled exactly the same way as the 2.0.6 based base too. Tried re-compiling, and still the same..
> 
> Everything else so far seems to work under my 2.2 base, incl compiler etc..

 This is due to the LFS support that's present in glibc 2.2 (fseeko() is
the reason of the trouble here).  Get a patch source RPM package from my
FTP site (ftp://ftp.ds2.pg.gda.pl/pub/macro/) for a fix.  An alternative
solution is available in the current CVS version of patch, I am told.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
