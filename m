Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AEjOd14297
	for linux-mips-outgoing; Fri, 10 Aug 2001 07:45:24 -0700
Received: from dea.waldorf-gmbh.de (u-65-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AEj7V14276;
	Fri, 10 Aug 2001 07:45:10 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7ACcDS24442;
	Fri, 10 Aug 2001 14:38:13 +0200
Date: Fri, 10 Aug 2001 14:38:13 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Seth Mos <knuffie@xs4all.nl>, Brandon Barker <bebarker@meginc.com>,
   linux-mips@oss.sgi.com, linux-xfs@oss.sgi.com
Subject: Re: XFS installer
Message-ID: <20010810143813.A24347@bacchus.dhis.org>
References: <20010810035106.A23548@bacchus.dhis.org> <Pine.BSI.4.10.10108100733470.24104-100000@xs3.xs4all.nl> <20010810131954.C23866@bacchus.dhis.org> <20010810214211.B282097@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010810214211.B282097@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Fri, Aug 10, 2001 at 09:42:11PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 09:42:11PM +1000, Nathan Scott wrote:

> > Urg.  MIPS also supports various page sizes and so this will limit the
> > use of XFS for file exchange.  Is this planned to be fixed?
> 
> Yes, for the filesystem blocksize < pagesize case anyway - slated
> for Linux/XFS 1.1.  On IRIX mkfs defaults to a 4K blocksize, which
> is fortunate I guess.
> 
> IRIX/XFS supports 512byte through to 64K blocksizes, so having
> variable page sizes on Linux/MIPS actually makes sharing easier
> on MIPS than on many other architectures.

Some chips now support page sizes of 1kb an higher, so the case of
filesystems of large blocksize than pagesize is also going to be of some
interest.

  Ralf
