Received:  by oss.sgi.com id <S554115AbRARFH4>;
	Wed, 17 Jan 2001 21:07:56 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:28152 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S554112AbRARFHf>; Wed, 17 Jan 2001 21:07:35 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867057AbRARFFb>; Thu, 18 Jan 2001 03:05:31 -0200
Date:	Thu, 18 Jan 2001 03:05:31 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Ian Chilton <ian@ichilton.co.uk>
Cc:	Chris Ruvolo <csr6702@grace.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: Current CVS (010116) Boots OK
Message-ID: <20010118030531.A929@bacchus.dhis.org>
References: <20010116192836.A26863@woody.ichilton.co.uk> <Pine.GSO.3.96.1010116210848.5546Z-100000@delta.ds2.pg.gda.pl> <20010117135818.B7083@hork> <20010117190219.A30315@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117190219.A30315@woody.ichilton.co.uk>; from ian@ichilton.co.uk on Wed, Jan 17, 2001 at 07:02:19PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 07:02:19PM +0000, Ian Chilton wrote:

> > I belive this is because of the terminal program being used.  It appears to
> > not have any kind of line wrap, so characters printed after the 80th
> > overwrite the last column of the display.
> 
> humm..could be minicom, but may be my mailer ?

True unixers use cu(1) as terminal program, works great.

  Ralf
