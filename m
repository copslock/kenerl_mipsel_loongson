Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ADmbF12607
	for linux-mips-outgoing; Fri, 10 Aug 2001 06:48:37 -0700
Received: from yog-sothoth.sgi.com (eugate.sgi.com [192.48.160.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ADmWV12604;
	Fri, 10 Aug 2001 06:48:32 -0700
Received: from zeus-fddi.americas.sgi.com (zeus-fddi.americas.sgi.com [128.162.8.103]) by yog-sothoth.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam-europe) via ESMTP id PAA974927; Fri, 10 Aug 2001 15:47:21 +0200 (CEST)
	mail_from (lord@sgi.com)
Received: from daisy-e185.americas.sgi.com (daisy.americas.sgi.com [128.162.185.214]) by zeus-fddi.americas.sgi.com (8.9.3/americas-smart-nospam1.1) with ESMTP id IAA2681294; Fri, 10 Aug 2001 08:47:12 -0500 (CDT)
Received: from jen.americas.sgi.com (IDENT:root@jen.americas.sgi.com [128.162.187.49]) by daisy-e185.americas.sgi.com (SGI-8.9.3/SGI-server-1.7) with ESMTP id IAA03690; Fri, 10 Aug 2001 08:47:12 -0500 (CDT)
Received: from jen.americas.sgi.com by jen.americas.sgi.com (8.11.2/SGI-client-1.7) via ESMTP id f7ADkQ307720; Fri, 10 Aug 2001 08:46:26 -0500
Message-Id: <200108101346.f7ADkQ307720@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Seth Mos <knuffie@xs4all.nl>, Brandon Barker <bebarker@meginc.com>,
   linux-mips@oss.sgi.com, linux-xfs@oss.sgi.com
Subject: Re: XFS installer 
In-Reply-To: Message from Ralf Baechle <ralf@oss.sgi.com> 
   of "Fri, 10 Aug 2001 13:19:54 +0200." <20010810131954.C23866@bacchus.dhis.org> 
Date: Fri, 10 Aug 2001 08:46:26 -0500
From: Steve Lord <lord@sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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

The page size == block size will get fixed, we need to do that, but it
may take a while. Block size less than pagesize will come first, blocksize
greater than pagesize needs PAGE_CACHE_SIZE to be bumped, which appears to
be on the cards for 2.5.

V1 directories mostly work in Linux, but there are glibc getdents issues
with them. The glibc code which lseeks backwards in a directory is the issue,
if you have control over your glibc it can be fixed by using the 64 bit
version of lseek in this code. This is all because the directory offset in
V1 is a 64 bit hash value, not a 32 bit signed number.

Steve

> 
>   Ralf
