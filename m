Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ABhYh10186
	for linux-mips-outgoing; Fri, 10 Aug 2001 04:43:34 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ABhUV10165;
	Fri, 10 Aug 2001 04:43:30 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id EAA05053; Fri, 10 Aug 2001 04:42:21 -0700 (PDT)
	mail_from (nathans@wobbly.melbourne.sgi.com)
Received: from wobbly.melbourne.sgi.com (wobbly.melbourne.sgi.com [134.14.55.135]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id VAA25379; Fri, 10 Aug 2001 21:42:12 +1000
Received: (from nathans@localhost)
	by wobbly.melbourne.sgi.com (SGI-8.9.3/8.9.3) id VAA90837;
	Fri, 10 Aug 2001 21:42:11 +1000 (EST)
Date: Fri, 10 Aug 2001 21:42:11 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Seth Mos <knuffie@xs4all.nl>, Brandon Barker <bebarker@meginc.com>,
   linux-mips@oss.sgi.com, linux-xfs@oss.sgi.com
Subject: Re: XFS installer
Message-ID: <20010810214211.B282097@wobbly.melbourne.sgi.com>
References: <20010810035106.A23548@bacchus.dhis.org> <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl> <20010810131954.C23866@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010810131954.C23866@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Aug 10, 2001 at 01:19:54PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

On Fri, Aug 10, 2001 at 01:19:54PM +0200, Ralf Baechle wrote:
> On Fri, Aug 10, 2001 at 07:38:15AM +0200, Seth Mos wrote:
> 
> > > of XFS on disk has somewhen been changed; the Linux version only supports
> > > v2 while IRIX 6.2 is rather old so I think only supports v1.  Thus both
> > > flavours are incompatible.
> > 
> > True, linux suports only v2. I don't know if Irix 6.2 supports the v2
> > mode. Another thing to watch out for is that the blocksize must equal
> > pagesize to be able to als mount it under linux.
> 
> Urg.  MIPS also supports various page sizes and so this will limit the
> use of XFS for file exchange.  Is this planned to be fixed?
> 

Yes, for the filesystem blocksize < pagesize case anyway - slated
for Linux/XFS 1.1.  On IRIX mkfs defaults to a 4K blocksize, which
is fortunate I guess.

IRIX/XFS supports 512byte through to 64K blocksizes, so having
variable page sizes on Linux/MIPS actually makes sharing easier
on MIPS than on many other architectures.

cheers.

-- 
Nathan
