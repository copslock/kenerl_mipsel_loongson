Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ABLG009148
	for linux-mips-outgoing; Fri, 10 Aug 2001 04:21:16 -0700
Received: from dea.waldorf-gmbh.de (u-187-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.187])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ABLCV09126;
	Fri, 10 Aug 2001 04:21:12 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7ABJsg24044;
	Fri, 10 Aug 2001 13:19:54 +0200
Date: Fri, 10 Aug 2001 13:19:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Seth Mos <knuffie@xs4all.nl>
Cc: Brandon Barker <bebarker@meginc.com>, linux-mips@oss.sgi.com,
   linux-xfs@oss.sgi.com
Subject: Re: XFS installer
Message-ID: <20010810131954.C23866@bacchus.dhis.org>
References: <20010810035106.A23548@bacchus.dhis.org> <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl>; from knuffie@xs4all.nl on Fri, Aug 10, 2001 at 07:38:15AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 07:38:15AM +0200, Seth Mos wrote:

> > of XFS on disk has somewhen been changed; the Linux version only supports
> > v2 while IRIX 6.2 is rather old so I think only supports v1.  Thus both
> > flavours are incompatible.
> 
> True, linux suports only v2. I don't know if Irix 6.2 supports the v2
> mode. Another thing to watch out for is that the blocksize must equal
> pagesize to be able to als mount it under linux.

Urg.  MIPS also supports various page sizes and so this will limit the
use of XFS for file exchange.  Is this planned to be fixed?

  Ralf
