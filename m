Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6JZuU08335
	for linux-mips-outgoing; Tue, 6 Nov 2001 11:35:56 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fA6JZp008332
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 11:35:51 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA6JZIi01957;
	Tue, 6 Nov 2001 11:35:18 -0800
Date: Tue, 6 Nov 2001 11:35:18 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: arcboot patches
Message-ID: <20011106113517.F1524@dea.linux-mips.net>
References: <20011104233218.A15847@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011104233218.A15847@bogon.ms20.nix>; from agx@sigxcpu.org on Sun, Nov 04, 2001 at 11:32:19PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Nov 04, 2001 at 11:32:19PM +0100, Guido Guenther wrote:

>  typedef struct {
> +#ifdef __MIPSEL__
>  	ULONG LowPart;
> +	*LONG HighPart;
> +#else /* !(__MIPSEL__) */
>  	LONG HighPart;
> +	ULONG LowPart;
> +#endif
>  } LARGEINTEGER;

Why not simply defining LARGEINTEGER as long long?

> Index: arclib/spb.h
> ===================================================================
> RCS file: /cvs/arcboot/arclib/spb.h,v
> retrieving revision 1.2
> diff -u -u -r1.2 spb.h
> --- arclib/spb.h	2001/03/20 02:55:56	1.2
> +++ arclib/spb.h	2001/11/04 22:06:28
> @@ -90,7 +90,7 @@
>  	ADAPTER Adapters[1];
>  } SPB;
>  
> -#define SystemParameterBlock	((SPB *) 0x1000)
> +#define SystemParameterBlock	((SPB *) 0xA0001000UL) 

That should be 0x80001000UL I think.

> -EXT2LIB = /usr/lib/libext2fs.a
> +#EXT2LIB = /usr/lib/libext2fs.a
> +EXT2LIB = ../../e2fslib/e2fsprogs-1.25/lib/libext2fs.a

That needs to be a non-pic library which nobody has installed on his
system so I suggest we just put a copy of libext2fs into the arcboot
sources.  That would alos make arcboot selfcontained and eleminate
build problems.

  Ralf
