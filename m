Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A5cMm02690
	for linux-mips-outgoing; Thu, 9 Aug 2001 22:38:22 -0700
Received: from smtp9.xs4all.nl (smtp9.xs4all.nl [194.109.127.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A5cHV02687;
	Thu, 9 Aug 2001 22:38:17 -0700
Received: from xs3.xs4all.nl (xs3.xs4all.nl [194.109.6.44])
	by smtp9.xs4all.nl (8.9.3/8.9.3) with ESMTP id HAA13815;
	Fri, 10 Aug 2001 07:38:15 +0200 (CEST)
Received: from localhost (knuffie@localhost)
	by xs3.xs4all.nl (8.9.0/8.9.0) with ESMTP id HAA24389;
	Fri, 10 Aug 2001 07:38:15 +0200 (CEST)
Date: Fri, 10 Aug 2001 07:38:15 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Brandon Barker <bebarker@meginc.com>, linux-mips@oss.sgi.com,
   linux-xfs@oss.sgi.com
Subject: Re: XFS installer
In-Reply-To: <20010810035106.A23548@bacchus.dhis.org>
Message-ID: <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 10 Aug 2001, Ralf Baechle wrote:

> On Thu, Aug 09, 2001 at 08:53:11PM -0400, Brandon Barker wrote:
> 
> > My intel workstation uses SGI's XFS Installer to create partitions with XFS 
> > for Redhat 7.1 before it is installed, along with installing a modified 
> > kernel and utilitiies.  I was wondering if there is anything like this for 
> > Linux Mips (on Indys), or if IRIX 6.2 can create a compatible XFS partition 
> > for use with linux.
> 
> Don't take my answer as authoritative for XFS stuff - the directory format
> of XFS on disk has somewhen been changed; the Linux version only supports
> v2 while IRIX 6.2 is rather old so I think only supports v1.  Thus both
> flavours are incompatible.

True, linux suports only v2. I don't know if Irix 6.2 supports the v2
mode. Another thing to watch out for is that the blocksize must equal
pagesize to be able to als mount it under linux.

This has different size on different architectures. Most are 4k but ia64
is variable from 2 - 16k or so.

This exlpained a bit in the FAQ http://oss.sgi.com/projects/xfs/faq.html

I will cc the linux-xfs list for an answer on which Irix versions can
support the v2 format. 

>   Ralf
> 

Cheers
Seth
