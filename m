Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A1qDw00818
	for linux-mips-outgoing; Thu, 9 Aug 2001 18:52:13 -0700
Received: from dea.waldorf-gmbh.de (u-219-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.219])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A1qAV00815
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 18:52:10 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7A1p7K23568;
	Fri, 10 Aug 2001 03:51:07 +0200
Date: Fri, 10 Aug 2001 03:51:07 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brandon Barker <bebarker@meginc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: XFS installer
Message-ID: <20010810035106.A23548@bacchus.dhis.org>
References: <01080920531200.02315@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080920531200.02315@linux>; from bebarker@meginc.com on Thu, Aug 09, 2001 at 08:53:11PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 09, 2001 at 08:53:11PM -0400, Brandon Barker wrote:

> My intel workstation uses SGI's XFS Installer to create partitions with XFS 
> for Redhat 7.1 before it is installed, along with installing a modified 
> kernel and utilitiies.  I was wondering if there is anything like this for 
> Linux Mips (on Indys), or if IRIX 6.2 can create a compatible XFS partition 
> for use with linux.

Don't take my answer as authoritative for XFS stuff - the directory format
of XFS on disk has somewhen been changed; the Linux version only supports
v2 while IRIX 6.2 is rather old so I think only supports v1.  Thus both
flavours are incompatible.

  Ralf
