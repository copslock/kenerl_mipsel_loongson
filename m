Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A69iA03150
	for linux-mips-outgoing; Thu, 9 Aug 2001 23:09:44 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A69eV03129;
	Thu, 9 Aug 2001 23:09:40 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id XAA05920; Thu, 9 Aug 2001 23:08:32 -0700 (PDT)
	mail_from (nathans@wobbly.melbourne.sgi.com)
Received: from wobbly.melbourne.sgi.com (wobbly.melbourne.sgi.com [134.14.55.135]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA23914; Fri, 10 Aug 2001 16:08:20 +1000
Received: (from nathans@localhost)
	by wobbly.melbourne.sgi.com (SGI-8.9.3/8.9.3) id QAA17338;
	Fri, 10 Aug 2001 16:08:20 +1000 (AEST)
Date: Fri, 10 Aug 2001 16:08:19 +1000
From: Nathan Scott <nathans@sgi.com>
To: Seth Mos <knuffie@xs4all.nl>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Brandon Barker <bebarker@meginc.com>,
   linux-mips@oss.sgi.com, linux-xfs@oss.sgi.com
Subject: Re: XFS installer
Message-ID: <20010810160819.D279562@wobbly.melbourne.sgi.com>
References: <20010810035106.A23548@bacchus.dhis.org> <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl>; from knuffie@xs4all.nl on Fri, Aug 10, 2001 at 07:38:15AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

On Fri, Aug 10, 2001 at 07:38:15AM +0200, Seth Mos wrote:
> On Fri, 10 Aug 2001, Ralf Baechle wrote:
> 
> > On Thu, Aug 09, 2001 at 08:53:11PM -0400, Brandon Barker wrote:
> > 
> > > My intel workstation uses SGI's XFS Installer to create partitions with XFS 
> > > for Redhat 7.1 before it is installed, along with installing a modified 
> > > kernel and utilitiies.  I was wondering if there is anything like this for 
> > > Linux Mips (on Indys), or if IRIX 6.2 can create a compatible XFS partition 
> > > for use with linux.
> > 
> > Don't take my answer as authoritative for XFS stuff - the directory format
> > of XFS on disk has somewhen been changed; the Linux version only supports
> > v2 while IRIX 6.2 is rather old so I think only supports v1.  Thus both
> > flavours are incompatible.
> 
> True, linux suports only v2. I don't know if Irix 6.2 supports the v2
> mode. Another thing to watch out for is that the blocksize must equal
> pagesize to be able to als mount it under linux.
> 
> This has different size on different architectures. Most are 4k but ia64
> is variable from 2 - 16k or so.
> 
> This exlpained a bit in the FAQ http://oss.sgi.com/projects/xfs/faq.html
> 
> I will cc the linux-xfs list for an answer on which Irix versions can
> support the v2 format. 

V2 directories were first introduced in 6.5.5 and, AFAICT, there was
no IRIX 6.2 patch.  The default XFS blocksize on an Indy is 4K, you
shouldn't have any trouble there.  You could upgrade your Indy to a
recent IRIX (6.5 has been around for 3+ years now...) or figure out
what's wrong with the v1 directory support on Linux - can't remember
what the issues were there, but the code is all still in the tree,
might be just a "simple matter of programming".

I thought RedHat dropped MIPS as a platform awhile back, so you may
be out of luck on the installer front (I'll toss you back to the mips
list on that one, I really don't know).

cheers.

-- 
Nathan
