Received:  by oss.sgi.com id <S553836AbRAQTAz>;
	Wed, 17 Jan 2001 11:00:55 -0800
Received: from mailout1-0.nyroc.rr.com ([24.92.226.81]:65357 "EHLO
        mailout1-1.nyroc.rr.com") by oss.sgi.com with ESMTP
	id <S553688AbRAQTAp>; Wed, 17 Jan 2001 11:00:45 -0800
Received: from hork (roc-24-161-76-252.rochester.rr.com [24.161.76.252])
	by mailout1-1.nyroc.rr.com (8.9.3/8.9.3) with ESMTP id NAA01604;
	Wed, 17 Jan 2001 13:54:36 -0500 (EST)
Received: from molotov by hork with local (Exim 3.20 #1 (Debian))
	id 14Ixmk-0002yv-00; Wed, 17 Jan 2001 13:58:18 -0500
Date:   Wed, 17 Jan 2001 13:58:18 -0500
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: Current CVS (010116) Boots OK
Message-ID: <20010117135818.B7083@hork>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
References: <20010116192836.A26863@woody.ichilton.co.uk> <Pine.GSO.3.96.1010116210848.5546Z-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.3.96.1010116210848.5546Z-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 09:17:45PM +0100
From:   Chris Ruvolo <csr6702@grace.rit.edu>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 09:17:45PM +0100, Maciej W. Rozycki wrote:
> On Tue, 16 Jan 2001, Ian Chilton wrote:
> > Memory: 91868k/95716k available (1517k kernel code, 3848k reserved, 84k
> > data, 6)
> 
>  Great!  The code works.  Thanks for the report.  Hmm, that "6)" at the
> end looks weird, though -- there should be something like "xxxk init, 0k
> highmem)"... 

I belive this is because of the terminal program being used.  It appears to
not have any kind of line wrap, so characters printed after the 80th
overwrite the last column of the display.

-Chris
