Received:  by oss.sgi.com id <S553914AbRA1Cz0>;
	Sat, 27 Jan 2001 18:55:26 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:51718 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553918AbRA1CzJ>;
	Sat, 27 Jan 2001 18:55:09 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02500
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:08 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870769AbRA0SuS>; Sat, 27 Jan 2001 10:50:18 -0800
Date: 	Sat, 27 Jan 2001 10:50:18 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Florian Lohoff <flo@rfc822.org>, Pete Popov <ppopov@mvista.com>,
        linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
Message-ID: <20010127105018.D867@bacchus.dhis.org>
References: <20010126212341.A26384@paradigm.rfc822.org> <Pine.GSO.3.96.1010127083433.29150D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010127083433.29150D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sat, Jan 27, 2001 at 08:42:34AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jan 27, 2001 at 08:42:34AM +0100, Maciej W. Rozycki wrote:

> > I definitly go for native builds - Once you have a working stable 
> > base you can set up debian autobuilders which will do nearly 
> > everything for you except signing and uploading the package into
> > the main repository.
> 
>  Yep, native builds are more likely to get correct as that's what most
> developers out there check (there are actually developers who never heard
> of something like a cross-compilation, sigh...).  But not everyone can
> afford a week to build glibc or X11... 

Sounds like DECstation results.  Building all the Redhat 7.0 packages which
are on oss + some others which could build for MIPS but don't for some
reason to the point where the build fails takes approx 40h on an Origin 200
with 2 180MHz R10000 processors and 1.5gb RAM.

I recently was told there is some m68k VME system out there which needs
approx. 3 days to rebuild it's kernel.

  Ralf
