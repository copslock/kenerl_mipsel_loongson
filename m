Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PIBW305955
	for linux-mips-outgoing; Fri, 25 May 2001 11:11:32 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PIBSF05952
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 11:11:29 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4PHxxJ02133;
	Fri, 25 May 2001 14:59:59 -0300
Date: Fri, 25 May 2001 14:59:59 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: George Gensure <werkt@csh.rit.edu>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: crti.o
Message-ID: <20010525145959.C1196@bacchus.dhis.org>
References: <3B0D990B.6090301@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0D990B.6090301@csh.rit.edu>; from werkt@csh.rit.edu on Thu, May 24, 2001 at 07:28:11PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 24, 2001 at 07:28:11PM -0400, George Gensure wrote:

> Anyone know what the problem is when building the latest gcc when I get 
> a problem doing the final linking of the libgcc subdir?  after listing a 
> whole bunch of object files, (not including crti.o) the linker errors 
> out, saying that it can't find crti.o.  I've been muddling through this 
> for a while and just can't figure the problem out exactly...

This file is part of the glibc package.

  Ralf
