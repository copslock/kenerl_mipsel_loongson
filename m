Received:  by oss.sgi.com id <S554118AbRARIxi>;
	Thu, 18 Jan 2001 00:53:38 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:6128 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553918AbRARIxO>;
	Thu, 18 Jan 2001 00:53:14 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA08340;
	Thu, 18 Jan 2001 09:01:23 +0100 (MET)
Date:   Thu, 18 Jan 2001 09:01:22 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Chris Ruvolo <csr6702@grace.rit.edu>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: Current CVS (010116) Boots OK
In-Reply-To: <20010117135818.B7083@hork>
Message-ID: <Pine.GSO.3.96.1010118085018.8140A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 17 Jan 2001, Chris Ruvolo wrote:
> >  Great!  The code works.  Thanks for the report.  Hmm, that "6)" at the
> > end looks weird, though -- there should be something like "xxxk init, 0k
> > highmem)"... 
> 
> I belive this is because of the terminal program being used.  It appears to
> not have any kind of line wrap, so characters printed after the 80th
> overwrite the last column of the display.

 It's possible.  I'm actually using `cu' and it works fine wrt wrapping
but it requires hw flow control (it sets "-clocal" and "crtscts" 
explicitly) unfortunately, which is why it cannot be used for the
DECstation's REX console I/O (which uses DTR/DSR flow control due to
serial interface limitations on certain DEC hardware).  I'm going to
modify `cu' at one time but since I don't really work with REX that much
I'm just using `cat' for this purpose for now. 

 It's best to use `dmesg' (with "-s 32768" if necessary) if at all
possible to fetch logs anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
