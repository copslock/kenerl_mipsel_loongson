Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0GNQXj26404
	for linux-mips-outgoing; Wed, 16 Jan 2002 15:26:33 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0GNQVP26401
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 15:26:31 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0GMQS023775;
	Wed, 16 Jan 2002 14:26:28 -0800
Date: Wed, 16 Jan 2002 14:26:28 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: fsck fails on latest 2.4 kernel
Message-ID: <20020116142628.D20408@dea.linux-mips.net>
References: <3C454D61.ACF98623@mips.com> <3C459383.5C8A6C8B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C459383.5C8A6C8B@mips.com>; from carstenl@mips.com on Wed, Jan 16, 2002 at 03:51:47PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 16, 2002 at 03:51:47PM +0100, Carsten Langgaard wrote:

> ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/binutils-mipsel-linux-2.9.5-3.i386.rpm
> and
>  ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/egcs-mipsel-linux-1.1.2-4.i386.rpm
> , which seems to be the latest on the SGI FTP server.
> 
> What are the recommended toolchain ?

Don't use these for building userspace apps.

  Ralf
