Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0GIh6G03945
	for linux-mips-outgoing; Wed, 16 Jan 2002 10:43:06 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0GIgxP03938
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 10:43:01 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id DC364125C1; Wed, 16 Jan 2002 09:42:55 -0800 (PST)
Date: Wed, 16 Jan 2002 09:42:55 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: fsck fails on latest 2.4 kernel
Message-ID: <20020116094255.A10704@lucon.org>
References: <3C454D61.ACF98623@mips.com> <3C459383.5C8A6C8B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C459383.5C8A6C8B@mips.com>; from carstenl@mips.com on Wed, Jan 16, 2002 at 03:51:47PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 16, 2002 at 03:51:47PM +0100, Carsten Langgaard wrote:
> The problem turned out to be a compiler/binutils bug.
> 
> I'm using
> ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/binutils-mipsel-linux-2.9.5-3.i386.rpm
> and
>  ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/egcs-mipsel-linux-1.1.2-4.i386.rpm
> , which seems to be the latest on the SGI FTP server.

I won't use them myself. They are known to be broken.

> 
> What are the recommended toolchain ?

The toolchain from my RedHat 7.1 mips port is in reasonably good shape.


H.J.
